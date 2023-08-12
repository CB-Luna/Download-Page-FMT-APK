import 'dart:convert';

import 'package:dowload_page_apk/models/modelos_pantallas/home.dart';

import 'package:flutter/material.dart';
import 'package:dowload_page_apk/helpers/globals.dart';

class HomeProvider extends ChangeNotifier {
  //----------------------------------------------
  HomeProvider() {
    getHome();
    /* subscripcionRealTime(); */
  }

  Home? homeData;

  Future<void> getHome() async {
    try {
      if (currentUser!.rol.rolId == 1) {
        final res = await supabase
            .from(
              'pantalla_home_view',
            )
            .select('*');

        homeData = res.toList().map((res) => Home.fromMap(res)).first;
        notifyListeners();
      } else if (currentUser!.rol.rolId == 3) {
        final res = await supabase.rpc('marcadores_home', params: {
          'jefearea': currentUser?.id,
        });

        homeData = Home.fromJson(jsonEncode(res));
        notifyListeners();
      }
    } catch (e) {
      print("Error en getHomeNative: $e");
    }
  }

  Future<void> getHomeJefe() async {
    try {
      final res = await supabase
          .from(
            'pantalla_home_view',
          )
          .select('*');

      homeData = res.toList().map((res) => Home.fromMap(res)).first;

      notifyListeners();
    } catch (e) {
      print("Error en getHomeNative: $e");
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////
  getNombreMes(mesNumero) {
    switch (mesNumero) {
      case "1":
        return 'Enero';
      case "2":
        return 'Febrero';

      case "3":
        return 'Marzo';

      case "4":
        return 'Abril';

      case "5":
        return 'Mayo';

      case "6":
        return 'Junio';

      case "7":
        return 'Julio';

      case "8":
        return 'Agosto';

      case "9":
        return 'Septiembre';

      case "10":
        return 'Octubre';

      case "11":
        return 'Noviembre';

      case "12":
        return 'Diciembre';

      default:
        return 'Enero';
    }
  }
}
