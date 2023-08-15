import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'package:dowload_page_apk/internationalization/internationalization.dart';
import 'package:dowload_page_apk/router/router.dart';
import 'package:dowload_page_apk/helpers/constants.dart';
import 'package:dowload_page_apk/providers/providers.dart';
import 'package:dowload_page_apk/helpers/globals.dart';
import 'package:dowload_page_apk/theme/theme.dart';

import 'helpers/supabase/queries.dart';
import 'models/modelos_pantallas/configuration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: anonKey,
  );

  await initGlobals();

  await initHiveForFlutter();
  final defaultHeaders = ({
    "apikey": anonKey,
  });
  final HttpLink httpLink =
      HttpLink(supabaseGraphqlURL, defaultHeaders: defaultHeaders);
  final AuthLink authLink = AuthLink(getToken: () async => 'Bearer $anonKey');
  final Link link = authLink.concat(httpLink);
  ValueNotifier<GraphQLClient> client = ValueNotifier(sbGQL =
      GraphQLClient(link: link, cache: GraphQLCache(store: HiveStore())));

  Configuration? conf =
      await SupabaseQueries.getDefaultTheme(int.parse(themeId));

  //obtener tema
  AppTheme.initConfiguration(conf);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => VisualStateProvider(context),
        ),
        ChangeNotifierProvider(
          create: (_) => UserState(),
        ),
        ChangeNotifierProvider(
          create: (_) => UsuariosProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('es');
  ThemeMode _themeMode = AppTheme.themeMode;

  void setLocale(Locale value) => setState(() => _locale = value);
  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        AppTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return Portal(
      child: MaterialApp.router(
        title: 'Download FMT APK',
        debugShowCheckedModeBanner: false,
        locale: _locale,
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en', 'US')],
        theme: ThemeData(
          brightness: Brightness.light,
          dividerColor: Colors.grey,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          dividerColor: Colors.grey,
        ),
        themeMode: _themeMode,
        routerConfig: router,
      ),
    );
  }
}
