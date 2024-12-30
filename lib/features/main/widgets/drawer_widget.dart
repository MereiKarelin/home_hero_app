import 'package:auto_route/auto_route.dart';
import 'package:datex/utils/app_router.gr.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Header of the Drawer
            const DrawerHeader(
                child: SizedBox(
              height: 100,
            )),
            // Drawer Menu Items
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Главная'),
              onTap: () {
                // Navigate to Home screen
                // Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            Divider(), // A divider between sections

            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Предстоящие события'),
              onTap: () {
                // Navigate to Notifications screen
                Navigator.pop(context);
                AutoRouter.of(context).push(const UncomingEventsRoute());
              },
            ),
            Divider(), // A divider between sections

            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to Settings screen
                // Navigator.pushReplacementNamed(context, '/settings');
              },
            ),
            Divider(), // A divider between sections

            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help'),
              onTap: () {
                // Navigate to Help screen
                // Navigator.pushReplacementNamed(context, '/help');
              },
            ),
            Divider(), // A divider between sections

            // Logout button
          ],
        ),
      ),
    );
  }
}
