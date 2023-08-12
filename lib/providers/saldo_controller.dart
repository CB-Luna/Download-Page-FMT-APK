import 'dart:convert';
import 'dart:developer';

import 'package:pluto_grid/pluto_grid.dart';
import 'package:dowload_page_apk/functions/date_format.dart';
import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/models/detalle_puntaje_ganado.dart';
import 'package:dowload_page_apk/models/detalle_puntaje_gastado.dart';
import 'package:dowload_page_apk/models/modelos_pantallas/saldo_empleado.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:dowload_page_apk/models/modelos_pantallas/ticket_producto_puntaje_gastado.dart';
import 'package:dowload_page_apk/models/modelos_pantallas/ticket_puntaje_gastado.dart';
import 'package:dowload_page_apk/models/modelos_pantallas/usuario_evento_puntaje_ganado.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SaldoController with ChangeNotifier {
  final puntajeAgregadoController = TextEditingController(text: "");
  final puntajeSustraidoController = TextEditingController(text: "");

  SaldoEmpleado? objectSaldoEmpleado;
  List<TicketProductoPuntajeGastado> listTicketProductoPG = [];
  UsuarioEventoPuntajeGanado? objectUsuarioEventoPuntajeGanado;
  PlutoGridStateManager? stateManager;
  List<PlutoRow> rows = [];
  List<bool> pageChecked = [];

  int registroPuntajeGanado = 0;
  int registroTotal = 0;
  int registroPuntajeGastado = 0;
  
  int idIterator = 1; 

  String? estatusFiltrado;

  bool stepperTaped = false;

   List<bool> isTaped = [
    true, //registroTotal       0
    false, //registroPuntajeGanado   1
    false, //registroPuntajeGastado    2
  ];

  final myChannel = supabase.channel('saldo');

  void seleccionado(int index) {
    for (var i = 0; i < isTaped.length; i++) {
      isTaped[i] = false;
    }
    isTaped[index] = true;
    notifyListeners();
  }

  // SaldoController(String userId) {
  //   suscripcionRealTime(userId);
  // }

  Future<void> suscripcionRealTime(String userId) async {
    myChannel.on(
        RealtimeListenTypes.postgresChanges,
        ChannelFilter(
          event: 'UPDATE',
          schema: 'public',
          table: 'saldo',
        ), (payload, [ref]) async {
      
    }).subscribe();
  }

  Future<void> updateState(String userId) async {
    if(await getSaldoEmpleadoSupabase(userId)){
      await getNumRegistrosPuntaje();
      await getRegistrosPuntaje();
    }
  }
  

  Future<void> getNumRegistrosPuntaje() async {

    final resPGanado = await supabase
        .from('puntaje_ganado')
        .select('monto')
        .eq('id_saldo_fk', 
        objectSaldoEmpleado!
        .saldoCollection
        .edges
        .first!
        .node.id);

    final registrosPuntajeGanado = resPGanado as List<dynamic>;

    for (var element in registrosPuntajeGanado) {
      int montoActual = element['monto'];
      registroPuntajeGanado = registroPuntajeGanado + montoActual;
    }
    
    final resPGastado = await supabase
        .from('puntaje_gastado')
        .select('monto')
        .eq('id_saldo_fk', 
        objectSaldoEmpleado!
        .saldoCollection
        .edges
        .first!
        .node.id);

    final registrosPuntajeGastado = resPGastado as List<dynamic>;

    for (var element in registrosPuntajeGastado) {
      int montoActual = element['monto'];
      registroPuntajeGastado = registroPuntajeGastado + montoActual;
    }


    registroTotal = registroPuntajeGanado -
        registroPuntajeGastado;
  }

  Future<void> getRegistrosPuntaje() async {
    try {
      //Se recuperan los registros de Puntaje Ganado
      String queryGetUsuarioEventoPuntajeGanado = """
        query Query {
          puntaje_ganadoCollection (filter: { id_saldo_fk: { eq: "${objectSaldoEmpleado!.saldoCollection.edges.first!.node.id}"} }){
            edges {
              node {
                id
                created_at
                monto
                usuario_evento {
                  evento {
                    evento_id
                    nombre
                    imagen
                    descripcion
                    fecha
                    puntaje_asistencia
                  }
                  perfil_usuario {
                    nombre
                    apellidos
                    rol {
                      rol_id
                      nombre
                    }
                    areas {
                      id_area_pk
                      nombre_area
                    }
                  }
                }
              }
            }
          }
        }
        """;
      final recordUsuarioEventoPuntajeGanado = await sbGQL.query(
        QueryOptions(
          document: gql(queryGetUsuarioEventoPuntajeGanado),
          fetchPolicy: FetchPolicy.noCache,
          onError: (error) {
            return null;
          },
        ),
      );
      objectUsuarioEventoPuntajeGanado =
        UsuarioEventoPuntajeGanado.fromJson(jsonEncode(recordUsuarioEventoPuntajeGanado.data).toString());
      for (var element in objectUsuarioEventoPuntajeGanado!.puntajeGanadoCollection.edges) {
        final detallePuntajeGanado = DetallePuntajeGanado(
          evento: element!
                .node
                .usuarioEvento
                .evento
                .nombre, 
          descripcion: element
                .node
                .usuarioEvento
                .evento
                .descripcion,
          puntaje: int.parse(element
                .node
                .usuarioEvento
                .evento
                .puntajeAsistencia), 
          nombreAdministrador: "${element
                .node
                .usuarioEvento
                .perfilUsuario
                .nombre} ${element
                .node
                .usuarioEvento
                .perfilUsuario
                .apellidos}", 
          imagenurl: element
                .node
                .usuarioEvento
                .evento
                .imagen);
        List listaAcciones = [];
        listaAcciones.add("GANADO");
        listaAcciones.add(detallePuntajeGanado);
        rows.add(
          PlutoRow(
            cells: {
              'id': PlutoCell(value: idIterator),
              'concepto': PlutoCell(value: element
                .node
                .usuarioEvento
                .evento
                .nombre),
              'puntos': PlutoCell(value: int.parse(element
                .node
                .usuarioEvento
                .evento
                .puntajeAsistencia)),
              'fecha_registro': PlutoCell(value: dateFormat(element
                .node
                .createdAt)),
              'fecha_entrega': PlutoCell(value: dateFormat(DateTime
                .now()
                .add(
                  const Duration(
                    days: 15
                )))),
              'semaforo': PlutoCell(value: "GANADO"),
              'acciones': PlutoCell(value: listaAcciones),
            },
          ),
        );
        idIterator ++;
      }
      //Se recuperan los registros de Puntaje Gastado
      String queryGetTicketPuntajeGastado = """
        query Query {
          puntaje_gastadoCollection (filter: { id_saldo_fk: { eq: "${objectSaldoEmpleado!.saldoCollection.edges.first!.node.id}"} }){
            edges {
              node {
                monto
                id_ticket
                created_at
              }
            }
          }
        }
        """;
      final recordTicketPuntajeGastado = await sbGQL.query(
        QueryOptions(
          document: gql(queryGetTicketPuntajeGastado),
          fetchPolicy: FetchPolicy.noCache,
          onError: (error) {
            return null;
          },
        ),
      );
      final objectTicketPuntajeGastado =
        TicketPuntajeGastado.fromJson(jsonEncode(recordTicketPuntajeGastado.data).toString());
      for (var element in objectTicketPuntajeGastado.puntajegastadoCollection.edges) {
        String queryGetTicketProductoPuntajeGastado = """
          query Query {
            ticket_productoCollection (filter: { ticket_fk: { eq: "${element!.node.idTicket}"} }){
              edges {
                node {
                  producto {
                    nombre
                    descripcion
                    costo
                    imagen
                  }
                  ticket {
                    id
                    total
                    created_at
                    perfil_usuario {
                      nombre
                      apellidos
                      rol {
                        nombre
                      }
                    }
                  }
                }
              }
            }
          }
          """;
        final recordTicketProductoPuntajeGastado = await sbGQL.query(
          QueryOptions(
            document: gql(queryGetTicketProductoPuntajeGastado),
            fetchPolicy: FetchPolicy.noCache,
            onError: (error) {
              return null;
            },
          ),
        );
        final objectTicketProductoPuntajeGastado =
          TicketProductoPuntajeGastado.fromJson(jsonEncode(recordTicketProductoPuntajeGastado.data).toString());
        DetallePuntajeGastado detallePuntajeGastado = DetallePuntajeGastado(
          ticket: objectTicketProductoPuntajeGastado.ticketProductoCollection.edges.first.node.ticket, 
          productos:[]
        );
        for (var element in objectTicketProductoPuntajeGastado.ticketProductoCollection.edges) {
          detallePuntajeGastado.productos.add(element.node.producto);
        }
        List listaAcciones = [];
        listaAcciones.add("GASTADO");
        listaAcciones.add(detallePuntajeGastado);
        rows.add(
          PlutoRow(
            cells: {
              'id': PlutoCell(value: idIterator),
              'concepto': PlutoCell(value: "Compra de productos: Id Ticket no. '${objectTicketProductoPuntajeGastado
                  .ticketProductoCollection
                  .edges
                  .first
                  .node
                  .ticket
                  .id}'"),
              'puntos': PlutoCell(value: int.parse(objectTicketProductoPuntajeGastado
                  .ticketProductoCollection
                  .edges
                  .first
                  .node
                  .ticket
                  .total)),
              'fecha_registro': PlutoCell(value: dateFormat(objectTicketProductoPuntajeGastado
                  .ticketProductoCollection
                  .edges
                  .first
                  .node
                  .ticket
                  .createdAt)),
              'fecha_entrega': PlutoCell(value: dateFormat(DateTime
                .now()
                .add(
                  const Duration(
                    days: 15
                )))),
              'semaforo': PlutoCell(value: "GASTADO"),
              'acciones': PlutoCell(value: listaAcciones),
            },
          ),
        );
        idIterator ++;
      }

      if (stateManager != null) stateManager!.notifyListeners();

      notifyListeners();
    } catch (e) {
      log('Error en getRegistrosPuntaje() - $e');
    }
    return;
  }

  Future<void> getRegistrosSaldo() async {
    try {
      idIterator = 1;
      rows.clear();
      if (estatusFiltrado == "Puntaje Ganado") {
        //Se recuperan los registros de Puntaje Ganado
        String queryGetUsuarioEventoPuntajeGanado = """
          query Query {
            puntaje_ganadoCollection (filter: { id_saldo_fk: { eq: "${objectSaldoEmpleado!.saldoCollection.edges.first!.node.id}"} }){
              edges {
                node {
                  id
                  created_at
                  monto
                  usuario_evento {
                    evento {
                      evento_id
                      nombre
                      imagen
                      descripcion
                      fecha
                      puntaje_asistencia
                    }
                    perfil_usuario {
                      nombre
                      apellidos
                      rol {
                        rol_id
                        nombre
                      }
                      areas {
                        id_area_pk
                        nombre_area
                      }
                    }
                  }
                }
              }
            }
          }
          """;
        final recordUsuarioEventoPuntajeGanado = await sbGQL.query(
          QueryOptions(
            document: gql(queryGetUsuarioEventoPuntajeGanado),
            fetchPolicy: FetchPolicy.noCache,
            onError: (error) {
              return null;
            },
          ),
        );
        objectUsuarioEventoPuntajeGanado =
          UsuarioEventoPuntajeGanado.fromJson(jsonEncode(recordUsuarioEventoPuntajeGanado.data).toString());
        for (var element in objectUsuarioEventoPuntajeGanado!.puntajeGanadoCollection.edges) {
          final detallePuntajeGanado = DetallePuntajeGanado(
            evento: element!
                  .node
                  .usuarioEvento
                  .evento
                  .nombre, 
            descripcion: element
                  .node
                  .usuarioEvento
                  .evento
                  .descripcion,
            puntaje: int.parse(element
                  .node
                  .usuarioEvento
                  .evento
                  .puntajeAsistencia), 
            nombreAdministrador: "${element
                  .node
                  .usuarioEvento
                  .perfilUsuario
                  .nombre} ${element
                  .node
                  .usuarioEvento
                  .perfilUsuario
                  .apellidos}", 
            imagenurl: element
                  .node
                  .usuarioEvento
                  .evento
                  .imagen);
          List listaAcciones = [];
          listaAcciones.add("GANADO");
          listaAcciones.add(detallePuntajeGanado);
          rows.add(
            PlutoRow(
              cells: {
                'id': PlutoCell(value: idIterator),
                'concepto': PlutoCell(value: element
                  .node
                  .usuarioEvento
                  .evento
                  .nombre),
                'puntos': PlutoCell(value: int.parse(element
                  .node
                  .usuarioEvento
                  .evento
                  .puntajeAsistencia)),
                'fecha_registro': PlutoCell(value: dateFormat(element
                  .node
                  .createdAt)),
                'fecha_entrega': PlutoCell(value: dateFormat(DateTime
                .now()
                .add(
                  const Duration(
                    days: 15
                )))),
                'semaforo': PlutoCell(value: "GANADO"),
                'acciones': PlutoCell(value: listaAcciones),
              },
            ),
          );
          idIterator ++;
        }
      } 
      if (estatusFiltrado == "Puntaje Gastado") {
        //Se recuperan los registros de Puntaje Gastado
        String queryGetTicketPuntajeGastado = """
          query Query {
            puntaje_gastadoCollection (filter: { id_saldo_fk: { eq: "${objectSaldoEmpleado!.saldoCollection.edges.first!.node.id}"} }){
              edges {
                node {
                  monto
                  id_ticket
                  created_at
                }
              }
            }
          }
          """;
        final recordTicketPuntajeGastado = await sbGQL.query(
          QueryOptions(
            document: gql(queryGetTicketPuntajeGastado),
            fetchPolicy: FetchPolicy.noCache,
            onError: (error) {
              return null;
            },
          ),
        );
        final objectTicketPuntajeGastado =
          TicketPuntajeGastado.fromJson(jsonEncode(recordTicketPuntajeGastado.data).toString());
        for (var element in objectTicketPuntajeGastado.puntajegastadoCollection.edges) {
          String queryGetTicketProductoPuntajeGastado = """
            query Query {
              ticket_productoCollection (filter: { ticket_fk: { eq: "${element!.node.idTicket}"} }){
                edges {
                  node {
                    producto {
                      nombre
                      descripcion
                      costo
                      imagen
                    }
                    ticket {
                      id
                      total
                      created_at
                      perfil_usuario {
                        nombre
                        apellidos
                        rol {
                          nombre
                        }
                      }
                    }
                  }
                }
              }
            }
            """;
          final recordTicketProductoPuntajeGastado = await sbGQL.query(
            QueryOptions(
              document: gql(queryGetTicketProductoPuntajeGastado),
              fetchPolicy: FetchPolicy.noCache,
              onError: (error) {
                return null;
              },
            ),
          );
          final objectTicketProductoPuntajeGastado =
            TicketProductoPuntajeGastado.fromJson(jsonEncode(recordTicketProductoPuntajeGastado.data).toString());
          DetallePuntajeGastado detallePuntajeGastado = DetallePuntajeGastado(
            ticket: objectTicketProductoPuntajeGastado.ticketProductoCollection.edges.first.node.ticket, 
            productos:[]
          );
          for (var element in objectTicketProductoPuntajeGastado.ticketProductoCollection.edges) {
            detallePuntajeGastado.productos.add(element.node.producto);
          }
          List listaAcciones = [];
          listaAcciones.add("GASTADO");
          listaAcciones.add(detallePuntajeGastado);
          rows.add(
            PlutoRow(
              cells: {
                'id': PlutoCell(value: idIterator),
                'concepto': PlutoCell(value: "Compra de productos: Id Ticket no. '${objectTicketProductoPuntajeGastado
                    .ticketProductoCollection
                    .edges
                    .first
                    .node
                    .ticket
                    .id}'"),
                'puntos': PlutoCell(value: int.parse(objectTicketProductoPuntajeGastado
                    .ticketProductoCollection
                    .edges
                    .first
                    .node
                    .ticket
                    .total)),
                'fecha_registro': PlutoCell(value: dateFormat(objectTicketProductoPuntajeGastado
                    .ticketProductoCollection
                    .edges
                    .first
                    .node
                    .ticket
                    .createdAt)),
                'fecha_entrega': PlutoCell(value: dateFormat(DateTime
                .now()
                .add(
                  const Duration(
                    days: 15
                )))),
                'semaforo': PlutoCell(value: "GASTADO"),
                'acciones': PlutoCell(value: listaAcciones),
              },
            ),
          );
          idIterator ++;
        }
      }

      if (estatusFiltrado == "Saldo Total") {
        //Se recuperan los registros de Puntaje Ganado
        String queryGetUsuarioEventoPuntajeGanado = """
          query Query {
            puntaje_ganadoCollection (filter: { id_saldo_fk: { eq: "${objectSaldoEmpleado!.saldoCollection.edges.first!.node.id}"} }){
              edges {
                node {
                  id
                  created_at
                  monto
                  usuario_evento {
                    evento {
                      evento_id
                      nombre
                      imagen
                      descripcion
                      fecha
                      puntaje_asistencia
                    }
                    perfil_usuario {
                      nombre
                      apellidos
                      rol {
                        rol_id
                        nombre
                      }
                      areas {
                        id_area_pk
                        nombre_area
                      }
                    }
                  }
                }
              }
            }
          }
          """;
        final recordUsuarioEventoPuntajeGanado = await sbGQL.query(
          QueryOptions(
            document: gql(queryGetUsuarioEventoPuntajeGanado),
            fetchPolicy: FetchPolicy.noCache,
            onError: (error) {
              return null;
            },
          ),
        );
        objectUsuarioEventoPuntajeGanado =
          UsuarioEventoPuntajeGanado.fromJson(jsonEncode(recordUsuarioEventoPuntajeGanado.data).toString());
        for (var element in objectUsuarioEventoPuntajeGanado!.puntajeGanadoCollection.edges) {
          final detallePuntajeGanado = DetallePuntajeGanado(
            evento: element!
                  .node
                  .usuarioEvento
                  .evento
                  .nombre, 
            descripcion: element
                  .node
                  .usuarioEvento
                  .evento
                  .descripcion,
            puntaje: int.parse(element
                  .node
                  .usuarioEvento
                  .evento
                  .puntajeAsistencia), 
            nombreAdministrador: "${element
                  .node
                  .usuarioEvento
                  .perfilUsuario
                  .nombre} ${element
                  .node
                  .usuarioEvento
                  .perfilUsuario
                  .apellidos}", 
            imagenurl: element
                  .node
                  .usuarioEvento
                  .evento
                  .imagen);
          List listaAcciones = [];
          listaAcciones.add("GANADO");
          listaAcciones.add(detallePuntajeGanado);
          rows.add(
            PlutoRow(
              cells: {
                'id': PlutoCell(value: idIterator),
                'concepto': PlutoCell(value: element
                  .node
                  .usuarioEvento
                  .evento
                  .nombre),
                'puntos': PlutoCell(value: int.parse(element
                  .node
                  .usuarioEvento
                  .evento
                  .puntajeAsistencia)),
                'fecha_registro': PlutoCell(value: dateFormat(element
                  .node
                  .createdAt)),
                'fecha_entrega': PlutoCell(value: dateFormat(DateTime
                .now()
                .add(
                  const Duration(
                    days: 15
                )))),
                'semaforo': PlutoCell(value: "GANADO"),
                'acciones': PlutoCell(value: listaAcciones),
              },
            ),
          );
          idIterator ++;
        }
        //Se recuperan los registros de Puntaje Gastado
        String queryGetTicketPuntajeGastado = """
          query Query {
            puntaje_gastadoCollection (filter: { id_saldo_fk: { eq: "${objectSaldoEmpleado!.saldoCollection.edges.first!.node.id}"} }){
              edges {
                node {
                  monto
                  id_ticket
                  created_at
                }
              }
            }
          }
          """;
        final recordTicketPuntajeGastado = await sbGQL.query(
          QueryOptions(
            document: gql(queryGetTicketPuntajeGastado),
            fetchPolicy: FetchPolicy.noCache,
            onError: (error) {
              return null;
            },
          ),
        );
        final objectTicketPuntajeGastado =
          TicketPuntajeGastado.fromJson(jsonEncode(recordTicketPuntajeGastado.data).toString());
        for (var element in objectTicketPuntajeGastado.puntajegastadoCollection.edges) {
          String queryGetTicketProductoPuntajeGastado = """
            query Query {
              ticket_productoCollection (filter: { ticket_fk: { eq: "${element!.node.idTicket}"} }){
                edges {
                  node {
                    producto {
                      nombre
                      descripcion
                      costo
                      imagen
                    }
                    ticket {
                      id
                      total
                      created_at
                      perfil_usuario {
                        nombre
                        apellidos
                        rol {
                          nombre
                        }
                      }
                    }
                  }
                }
              }
            }
            """;
          final recordTicketProductoPuntajeGastado = await sbGQL.query(
            QueryOptions(
              document: gql(queryGetTicketProductoPuntajeGastado),
              fetchPolicy: FetchPolicy.noCache,
              onError: (error) {
                return null;
              },
            ),
          );
          final objectTicketProductoPuntajeGastado =
            TicketProductoPuntajeGastado.fromJson(jsonEncode(recordTicketProductoPuntajeGastado.data).toString());
          DetallePuntajeGastado detallePuntajeGastado = DetallePuntajeGastado(
            ticket: objectTicketProductoPuntajeGastado.ticketProductoCollection.edges.first.node.ticket, 
            productos:[]
          );
          for (var element in objectTicketProductoPuntajeGastado.ticketProductoCollection.edges) {
            detallePuntajeGastado.productos.add(element.node.producto);
          }
          List listaAcciones = [];
          listaAcciones.add("GASTADO");
          listaAcciones.add(detallePuntajeGastado);
          rows.add(
            PlutoRow(
              cells: {
                'id': PlutoCell(value: idIterator),
                'concepto': PlutoCell(value: "Compra de productos: Id Ticket no. '${objectTicketProductoPuntajeGastado
                    .ticketProductoCollection
                    .edges
                    .first
                    .node
                    .ticket
                    .id}'"),
                'puntos': PlutoCell(value: int.parse(objectTicketProductoPuntajeGastado
                    .ticketProductoCollection
                    .edges
                    .first
                    .node
                    .ticket
                    .total)),
                'fecha_registro': PlutoCell(value: dateFormat(objectTicketProductoPuntajeGastado
                    .ticketProductoCollection
                    .edges
                    .first
                    .node
                    .ticket
                    .createdAt)),
                'fecha_entrega': PlutoCell(value: dateFormat(DateTime
                .now()
                .add(
                  const Duration(
                    days: 15
                )))),
                'semaforo': PlutoCell(value: "GASTADO"),
                'acciones': PlutoCell(value: listaAcciones),
              },
            ),
          );
          idIterator ++;
        }
      }

      if (stateManager != null) stateManager!.notifyListeners();

      notifyListeners();
    } catch (e) {
      log('Error en getSaldo() - $e');
    }
    return;
  }

  /*Función Saldo 1 Recuperación de Información del saldo por empleado:
  Se solicita el id del Empleado en Supabase y se actualiza la variable 'objectSaldoEmpleado'
  del controlador SaldoController con los nuevos datos obtenidos de la BD.
  */
  Future<bool> getSaldoEmpleadoSupabase(String userId) async {
    objectSaldoEmpleado = null;
    listTicketProductoPG.clear();
    objectUsuarioEventoPuntajeGanado = null;
    registroPuntajeGanado = 0;
    registroPuntajeGastado = 0;
    registroTotal = 0;
    idIterator = 1;
    rows.clear();
    String queryGetSaldoEmpleadoByID = """
      query Query {
        saldoCollection (filter: { id_usuario_fk: { eq: "$userId"} }){
          edges {
            node {
              id
              saldo
              created_at
            }
          }
        }
      }
      """;
    try {
      //Se recupera la información del Saldo del Empleado en Supabase
      final record = await sbGQL.query(
        QueryOptions(
          document: gql(queryGetSaldoEmpleadoByID),
          fetchPolicy: FetchPolicy.noCache,
          onError: (error) {
            return null;
          },
        ),
      );
      if (record.data != null) {
        //Existen datos del Saldo del Empleado en Supabase
        print("***Saldo: ${jsonEncode(record.data).toString()}");
        objectSaldoEmpleado =
            SaldoEmpleado.fromJson(jsonEncode(record.data).toString());
        if (objectSaldoEmpleado!.saldoCollection.edges != []) {
          return true;
        } else {
          return false;
        }
      } else {
        //No existen Saldo de Empleado en Supabase
        return false;
      }
    } catch (e) {
      print("Error en GetSaldoEmpleado: $e");
      return false;
    }
  }

  /*Función Saldo 2 Actualización del Saldo Empleado mediante la adición de puntos:
  Se solicita el id del Empleado en Supabase y el monto del registro a agregar para realizar
  la actualización del saldo total asociado al empleado.
  */
  Future<bool> addPuntajeEmpleadoSupabase(String userId, int monto) async {
    print("Recuperando Información");
    String queryGetSaldoEmpleadoByID = """
      query Query {
        saldoCollection (filter: { id_usuario_fk: { eq: "$userId"} }){
          edges {
            node {
              id
              saldo
              created_at
            }
          }
        }
      }
      """;
    try {
      //Se recupera la información del Saldo del Empleado en Supabase
      final record = await sbGQL.query(
        QueryOptions(
          document: gql(queryGetSaldoEmpleadoByID),
          fetchPolicy: FetchPolicy.noCache,
          onError: (error) {
            return null;
          },
        ),
      );
      if (record.data != null) {
        //Existen datos del Saldo del Empleado en Supabase
        print("***Saldo: ${jsonEncode(record.data).toString()}");
        //Se valida que el registro del Saldo exista en Supabase
        objectSaldoEmpleado =
            SaldoEmpleado.fromJson(jsonEncode(record.data).toString());
        if (objectSaldoEmpleado?.saldoCollection.edges != []) {
          final newSaldo = monto +
              objectSaldoEmpleado!.saldoCollection.edges.first!.node.saldo;
          //Se inserta un nuevo registro en la tabla Puntaje Ganado en Supabase
          await supabase.from('puntaje_ganado').insert([
            {
              'monto': monto,
              'id_saldo_fk':
                  objectSaldoEmpleado!.saldoCollection.edges.first!.node.id,
            },
          ]);
          //Se actualiza el Saldo del Cliente en Supabase
          await supabase.from('saldo').update({'saldo': newSaldo}).eq(
              'id', objectSaldoEmpleado!.saldoCollection.edges.first!.node.id);
          //Se actualiza el Saldo Localmente
          objectSaldoEmpleado!.saldoCollection.edges.first!.node.saldo =
              newSaldo;
          notifyListeners();
          return true;
        } else {
          //No existe un regitro de Saldo del Empleado en Supabase
          //Se inserta un nuevo registro en la tabla Saldo en Supabase
          final nuevoRegistroSaldo = await supabase.from('saldo').insert([
            {
              'saldo': 0,
              'id_usuario_fk':
                  userId,
            },
          ]).select<PostgrestList>('id');
          final newSaldo = monto +
              objectSaldoEmpleado!.saldoCollection.edges.first!.node.saldo;
          //Se inserta un nuevo registro en la tabla Puntaje Ganado en Supabase
          await supabase.from('puntaje_ganado').insert([
            {
              'monto': monto,
              'id_saldo_fk':
                  nuevoRegistroSaldo.first['id'],
            },
          ]);
          //Se actualiza el Saldo del Cliente en Supabase
          await supabase.from('saldo').update({'saldo': newSaldo}).eq(
              'id', nuevoRegistroSaldo.first['id']);
          //Se actualiza el Saldo Localmente
          objectSaldoEmpleado!.saldoCollection.edges.first!.node.saldo =
              newSaldo;
          notifyListeners();
          return true;
        }
      } else {
        //Fallo en recuperar Saldo del Empleado en Supabase
        return false;
      }
    } catch (e) {
      print("Error en GetSaldoEmpleado: $e");
      return false;
    }
  }

  /*Función Saldo 3 Actualización del Saldo Empleado mediante la sustracción de puntos:
  Se solicita el id del Empleado en Supabase y el monto del registro a sustraer para realizar
  la actualización del saldo total asociado al empleado.
  */
  Future<bool> substractPuntajeEmpleadoSupabase(
      String userId, int monto, int ticket) async {
    print("Recuperando Información");
    String queryGetSaldoEmpleadoByID = """
      query Query {
        saldoCollection (filter: { id_usuario_fk: { eq: "$userId"} }){
          edges {
            node {
              id
              saldo
              created_at
            }
          }
        }
      }
      """;
    try {
      //Se recupera la información del Saldo del Empleado en Supabase
      final record = await sbGQL.query(
        QueryOptions(
          document: gql(queryGetSaldoEmpleadoByID),
          fetchPolicy: FetchPolicy.noCache,
          onError: (error) {
            return null;
          },
        ),
      );
      if (record.data != null) {
        //Existen datos del Saldo del Empleado en Supabase
        print("***Saldo: ${jsonEncode(record.data).toString()}");
        //Se valida que el registro del Saldo exista en Supabase
        objectSaldoEmpleado =
            SaldoEmpleado.fromJson(jsonEncode(record.data).toString());
        if (objectSaldoEmpleado?.saldoCollection.edges != []) {
          if (objectSaldoEmpleado!.saldoCollection.edges.first!.node.saldo >
              monto) {
            final newSaldo =
                objectSaldoEmpleado!.saldoCollection.edges.first!.node.saldo -
                    monto;
            //Se inserta un nuevo registro en la tabla Puntaje Gastado en Supabase
            await supabase.from('puntaje_gastado').insert([
              {
                'id_ticket': ticket,
                'monto': monto,
                'id_saldo_fk':
                    objectSaldoEmpleado!.saldoCollection.edges.first!.node.id,
              },
            ]);
            //Se actualiza el Saldo del Cliente en Supabase
            await supabase.from('saldo').update({'saldo': newSaldo}).eq(
                'id', objectSaldoEmpleado!.saldoCollection.edges.first!.node.id);
            //Se actualiza el Saldo Localmente
            objectSaldoEmpleado!.saldoCollection.edges.first!.node.saldo =
                newSaldo;
            notifyListeners();
            return true;
          } else {
            //El monto a sustraer es mayor que el Saldo actual del Empleado
            return false;
          }
        } else {
          //No existe ningún registro de Saldo del Empleado en Supabase
          return false;
        }
      } else {
        //Fallo en recuperar Saldo del Empleado en Supabase
        return false;
      }
    } catch (e) {
      print("Error en GetSaldoEmpleado: $e");
      return false;
    }
  }

  void clearControllers() {
    puntajeAgregadoController.clear();
    puntajeSustraidoController.clear();
    objectSaldoEmpleado = null;
    listTicketProductoPG.clear();
    objectUsuarioEventoPuntajeGanado = null;
    registroPuntajeGanado = 0;
    registroPuntajeGastado = 0;
    estatusFiltrado = null;
    registroTotal = 0;
    idIterator = 1;
    rows.clear();
  }
}
