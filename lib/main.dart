import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:quiz_ala/screens/home_screen.dart';
import 'package:quiz_ala/screens/settings_screen.dart';
import 'package:quiz_ala/services/notification_service.dart';
import 'package:quiz_ala/screens/theme_provider.dart';
import 'package:quiz_ala/localization/localization.dart'; // Importez Localization

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialiser le service de notifications
  final notificationService = NotificationService();
  await notificationService.init();

 runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Quiz App',
      theme: themeProvider.getTheme(), // Utiliser le thème actuel
      home: const HomeScreen(),
      localizationsDelegates: const [
        AppLocalizationsDelegate(), // Fournir Localization
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: Localization.supportedLocales,
    );
  }
}