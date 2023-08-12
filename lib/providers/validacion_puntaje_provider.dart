import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dowload_page_apk/models/modelos_pantallas/image_data.dart';
import 'package:dowload_page_apk/models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:http/http.dart' as http;

import 'package:dowload_page_apk/functions/date_format.dart';
import 'package:dowload_page_apk/helpers/globals.dart';

class ValidacionPuntajeProvider extends ChangeNotifier {
  final busquedaController = TextEditingController();

  List<PuntajeSolicitado> puntajesSolicitados = [];
  PlutoGridStateManager? stateManager;
  List<PlutoRow> rows = [];
  String orden = "usuario_evento_id";

  TextEditingController motivosRechazo = TextEditingController();

  final myChannel = supabase.channel('validacion_puntaje');

  ValidacionPuntajeProvider() {
    suscripcionRealTime();
  }

  Future<void> suscripcionRealTime() async {
    myChannel.on(
        RealtimeListenTypes.postgresChanges,
        ChannelFilter(
          event: 'insert',
          schema: 'public',
          table: 'usuario_evento',
        ), (payload, [ref]) async {
      await getValidacionPuntaje();
    }).subscribe();
  }

  Future<void> getValidacionPuntaje() async {
    try {
      var res = await supabase.rpc('validacion_puntaje',
          params: {'busqueda': busquedaController.text});

      //TODO: agregar orden por fecha y busqueda a la funcion
      // final res = await query.order(orden, ascending: true);

      if (res == null) {
        log('Error en getValidacionPuntaje()');
        return;
      }

      if (res['puntajesSolicitados'] == null) {
        rows.clear();
        return;
      }

      puntajesSolicitados = (res['puntajesSolicitados'] as List<dynamic>)
          .map((elem) => PuntajeSolicitado.fromJson(jsonEncode(elem)))
          .toList();

      rows.clear();

      for (PuntajeSolicitado puntajeSolicitado in puntajesSolicitados) {
        rows.add(
          PlutoRow(
            cells: {
              'id': PlutoCell(value: puntajeSolicitado.puntajeSolicitadoId),
              'usuario':
                  PlutoCell(value: puntajeSolicitado.usuario.nombreCompleto),
              'area': PlutoCell(value: puntajeSolicitado.usuario.area),
              'jefe_de_area':
                  PlutoCell(value: puntajeSolicitado.usuario.jefeDeArea),
              'evento': PlutoCell(value: puntajeSolicitado.evento.nombre),
              'fecha':
                  PlutoCell(value: dateFormat(puntajeSolicitado.evento.fecha)),
              'puntaje': PlutoCell(value: puntajeSolicitado.evento.puntos),
              'acciones':
                  PlutoCell(value: puntajeSolicitado.puntajeSolicitadoId),
            },
          ),
        );
      }

      if (stateManager != null) stateManager!.notifyListeners();

      notifyListeners();
    } catch (e) {
      log('Error en validacion_nc_provider.dart - $e');
    }
  }

  Future<void> getPreviewImage(String imageUrlString) async {
    final ImageData? image = await downloadImage(imageUrlString);
    if (image == null) return;
    //Calcular medidas de imagen
    //manejar un tamano maximo y reducir tamano
    //
    //height > width es vertical
    //height < width es horizontal
  }

  Future<ImageData?> downloadImage(String imageUrlString) async {
    try {
      var imageUrl = Uri.parse(imageUrlString);
      http.Response response = await http.get(imageUrl);
      Uint8List originalUint8List = response.bodyBytes;
      ui.Image originalUiImage = await decodeImageFromList(originalUint8List);
      ByteData? originalByteData = await originalUiImage.toByteData();
      print(
          'original image ByteData size is ${originalByteData!.lengthInBytes}');
      return ImageData(
        height: originalUiImage.height,
        width: originalUiImage.width,
        size: originalByteData.lengthInBytes,
        image: originalUint8List,
      );
    } catch (e) {
      log('Error en getPreviewImage() - $e');
      return null;
    }
  }

  Future<Uint8List?> resizeImage(ImageData imageData) async {
    var codec = await ui.instantiateImageCodec(
      imageData.image,
      targetHeight: 200,
      targetWidth: 200,
    );
    var frameInfo = await codec.getNextFrame();
    ui.Image targetUiImage = frameInfo.image;

    ByteData? targetByteData =
        await targetUiImage.toByteData(format: ui.ImageByteFormat.png);

    print('target image ByteData size is ${targetByteData?.lengthInBytes}');
    Uint8List? targetlUint8List = targetByteData?.buffer.asUint8List();

    return targetlUint8List;
  }

  Future<bool> aceptarPuntaje(PuntajeSolicitado puntajeSolicitado) async {
    try {
      //obtener el saldo del usuario
      final res = await supabase.from('saldo').select('id, saldo').eq(
            'id_usuario_fk',
            puntajeSolicitado.usuario.id,
          );

      if (res == null || (res as List).isEmpty) return false;

      final int saldoId = res[0]['id'];
      final saldo = res[0]['saldo'];

      //insertar registro en puntos ganados
      await supabase.from('puntaje_ganado').insert({
        'monto': puntajeSolicitado.evento.puntos,
        'id_saldo_fk': saldoId,
        'id_usuario_evento_fk': puntajeSolicitado.puntajeSolicitadoId,
      });

      //Actualizar saldo de usuario
      await supabase.from('saldo').update(
          {'saldo': saldo + puntajeSolicitado.evento.puntos}).eq('id', saldoId);

      //Actualizar estatus en usuario_evento a aceptado
      await supabase.from('usuario_evento').update({'estatus_fk': 3}).eq(
        'usuario_evento_id',
        puntajeSolicitado.puntajeSolicitadoId,
      );
      return true;
    } catch (e) {
      log('Error en validacion_puntaje_provider.dart - aceptarPuntaje() - $e');
      return false;
    }
  }

  Future<bool> rechazarPuntaje(PuntajeSolicitado puntajeSolicitado) async {
    try {
      //Actualizar estatus en usuario_evento a rechazado
      await supabase.from('usuario_evento').update({'estatus_fk': 2}).eq(
        'usuario_evento_id',
        puntajeSolicitado.puntajeSolicitadoId,
      );
      return true;
    } catch (e) {
      log('Error en validacion_puntaje_provider.dart - rechazarPuntaje() - $e');
      return false;
    }
  }

  @override
  void dispose() {
    busquedaController.dispose();

    if (stateManager != null) stateManager!.dispose();

    super.dispose();
  }
}
