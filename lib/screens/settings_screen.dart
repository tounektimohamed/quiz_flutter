import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quiz_ala/screens/theme_provider.dart'; // Importez ThemeProvider

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localizationProvider = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: const Icon(Icons.dark_mode, color: Colors.blueAccent),
                title: const Text('Mode sombre'),
                trailing: Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                  activeColor: Colors.blueAccent,
                ),
              ),
            ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.5),
            const SizedBox(height: 10),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: const Icon(Icons.language, color: Colors.blueAccent),
                title: const Text('Langue'),
                trailing: Consumer<LocalizationProvider>(
                  builder: (context, localizationProvider, child) {
                    return DropdownButton<String>(
                      value: localizationProvider.locale.languageCode,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          localizationProvider.setLocale(Locale(newValue));
                        }
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 'fr',
                          child: Text('Français'),
                        ),
                        DropdownMenuItem(
                          value: 'en',
                          child: Text('English'),
                        ),
                        DropdownMenuItem(
                          value: 'ar',
                          child: Text('العربية'),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.5),
          ],
        ),
      ),
    );
  }
}



class LocalizationProvider with ChangeNotifier {
  Locale _locale = const Locale('fr');

  Locale get locale => _locale;

  void setLocale(Locale newLocale) {
    if (_locale != newLocale) {
      _locale = newLocale;
      notifyListeners();
    }
  }
}