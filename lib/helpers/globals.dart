import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dowload_page_apk/models/models.dart';
import 'package:dowload_page_apk/helpers/supabase/queries.dart';
import 'package:dowload_page_apk/theme/theme.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey = GlobalKey<ScaffoldMessengerState>();

const storage = FlutterSecureStorage();

final supabase = Supabase.instance.client;

late final SharedPreferences prefs;

late final Assets assets;

late GraphQLClient sbGQL;

Usuario? currentUser;

Future<void> initGlobals() async {
  prefs = await SharedPreferences.getInstance();

  assets = await SupabaseQueries.getAssets();

  currentUser = await SupabaseQueries.getCurrentUserData();
  if (currentUser == null) return;
  Configuration? config = await SupabaseQueries.getUserTheme();
  if (config == null) return;
  assets.logoBlanco = config.logos.logoBlanco;
  assets.logoColor = config.logos.logoColor;
  AppTheme.initConfiguration(config);
}

PlutoGridScrollbarConfig plutoGridScrollbarConfig(BuildContext context) {
  return PlutoGridScrollbarConfig(
    isAlwaysShown: true,
    scrollbarThickness: 5,
    hoverWidth: 20,
    scrollBarColor: AppTheme.of(context).primaryColor,
  );
}

InputDecoration tFFInputDecoration(BuildContext context, String labelText) {
  return InputDecoration(
    labelText: labelText,
    hintStyle: AppTheme.of(context).bodyText2,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppTheme.of(context).primaryText,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppTheme.of(context).primaryText,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppTheme.of(context).primaryText,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.transparent,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.transparent,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

PlutoGridStyleConfig plutoGridStyleConfig(BuildContext context) {
  return AppTheme.themeMode == ThemeMode.light
      ? PlutoGridStyleConfig(
          gridPopupBorderRadius: BorderRadius.circular(8),
          gridBorderColor: AppTheme.of(context).primaryText,
          gridBorderRadius: BorderRadius.circular(8),
          rowHeight: 60,
          cellTextStyle: AppTheme.of(context).contenidoTablas,
          columnTextStyle: AppTheme.of(context).contenidoTablas,
          enableCellBorderVertical: false,
          borderColor: AppTheme.of(context).primaryBackground,
          checkedColor: AppTheme.themeMode == ThemeMode.light ? const Color(0XFFC7EDDD) : const Color(0XFF4B4B4B),
          enableRowColorAnimation: true,
          iconColor: AppTheme.of(context).primaryColor,
          gridBackgroundColor: AppTheme.of(context).primaryBackground,
          rowColor: AppTheme.of(context).primaryBackground,
          menuBackgroundColor: AppTheme.of(context).primaryBackground,
          activatedColor: AppTheme.of(context).primaryBackground,
        )
      : PlutoGridStyleConfig.dark(
          gridPopupBorderRadius: BorderRadius.circular(8),
          gridBorderColor: AppTheme.of(context).primaryText,
          gridBorderRadius: BorderRadius.circular(8),
          rowHeight: 60,
          cellTextStyle: AppTheme.of(context).contenidoTablas,
          columnTextStyle: AppTheme.of(context).contenidoTablas,
          enableCellBorderVertical: false,
          borderColor: AppTheme.of(context).primaryBackground,
          checkedColor: AppTheme.themeMode == ThemeMode.light ? const Color(0XFFC7EDDD) : const Color(0XFF4B4B4B),
          enableRowColorAnimation: true,
          iconColor: AppTheme.of(context).primaryColor,
          gridBackgroundColor: AppTheme.of(context).primaryBackground,
          rowColor: AppTheme.of(context).primaryBackground,
          menuBackgroundColor: AppTheme.of(context).primaryBackground,
          activatedColor: AppTheme.of(context).primaryBackground,
        );
}
