import 'package:flutter/material.dart';
import 'package:poke_dex/utils/theme_mode_notifier.dart';
import 'package:poke_dex/utils/theme_mode_selection.dart';
import 'package:poke_dex/view/theme_mode_selection_page.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeNotifier>(
      builder: (context, mode, child) => ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.lightbulb),
              title: const Text('Dark/Light Mode'),
              trailing: Text((mode.mode == ThemeMode.system)
                  ? 'System'
                  : (mode.mode == ThemeMode.dark ? 'Dark' : 'Light')),
              onTap: () async {
                final ret = await Navigator.of(context).push<ThemeMode>(
                  MaterialPageRoute(builder: (context) => ThemeModeSelectionPage(mode: mode.mode))
                );
                if (ret != null) {
                  mode.update(ret);
                }
              },
            )
          ],
      ),
    );
  }
}
