import 'package:flutter/material.dart';

import '../../../providers/providers.dart';
import '../../../theme/theme.dart';

class TarjetaJefeArea extends StatefulWidget {
  final String avatarUrl;
  final String nombre;
  final String email;
  final String telefono;
  final String nombreArea;
  final String idUsuario;
  final int cantidadEmpleados;
  dynamic habilitado;
  final bool? laborando;
  final JefesAreaProvider provider;
  final String perfilUsuarioId;
  TarjetaJefeArea({
    Key? key,
    required this.avatarUrl,
    required this.nombre,
    required this.email,
    required this.telefono,
    required this.nombreArea,
    required this.idUsuario,
    required this.cantidadEmpleados,
    required this.habilitado,
    required this.laborando,
    required this.provider,
    required this.perfilUsuarioId,
  }) : super(key: key);

  @override
  State<TarjetaJefeArea> createState() => _TarjetaJefeAreaState();
}

class _TarjetaJefeAreaState extends State<TarjetaJefeArea> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: Colors.grey[300]!),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.avatarUrl),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.person,
                              size: 24,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${widget.nombre}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.email,
                              size: 24,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${widget.email}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              size: 24,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${widget.telefono.toUpperCase()}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.people,
                              size: 24,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${widget.cantidadEmpleados}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              Container(
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'ÁREA',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 5),
                      Text(widget.nombreArea.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black)),
                      Divider(),
                      const Text(
                        'App habilitada',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Switch(
                        activeColor: AppTheme.of(context).primaryColor,
                        value: widget.habilitado,
                        onChanged: (bool state) {
                          setState(() {
                            widget.habilitado = state;
                          });

                          widget.laborando == true
                              ? widget.provider
                                  .cambioSwitch(state, widget.perfilUsuarioId)
                              : widget.provider
                                  .cambioSwitch(false, widget.perfilUsuarioId);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(width: 2, color: Colors.grey[300]!),
              ),
              child: Center(
                child: Text(
                  '#${widget.idUsuario}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
