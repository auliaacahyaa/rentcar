import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeModeData extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  bool get isDarkModeActive => _themeMode == ThemeMode.dark;
  void changeTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkModeActive = false;

  void changeTheme(bool value) {
    setState(() {
      isDarkModeActive = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          Builder(
            builder: (context) {
              return ListTile(
                leading: Icon(
                  context.watch<ThemeModeData>().isDarkModeActive
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                title: Text("Title"),
                trailing: Switch(
                  value: context.watch<ThemeModeData>().isDarkModeActive,
                  onChanged: (bool value) {
                    Provider.of<ThemeModeData>(context, listen: false)
                        .changeTheme(
                      value ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                ),
                onTap: () {
                  Provider.of<ThemeModeData>(context, listen: false)
                      .changeTheme(
                    Provider.of<ThemeModeData>(context, listen: false)
                            .isDarkModeActive
                        ? ThemeMode.light
                        : ThemeMode.dark,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}