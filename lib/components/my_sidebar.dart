import 'package:flutter/material.dart';
import 'package:messe/pages/settings_page.dart';
import 'package:messe/pages/about_page.dart';
import 'package:messe/services/auth/auth_service.dart';

class MySidebar extends StatelessWidget {
  const MySidebar({super.key});

  void logout(BuildContext context) async {
    // First, close the drawer
    Navigator.pop(context);
    
    // Sign out from Firebase
    final auth = AuthService();
    await auth.signOut();
    
    // Clear entire navigation stack and go to root
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/', 
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.message,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                ),
              ),

              // home list tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text(
                    "View Chats",
                    style: TextStyle(fontFamily: 'Nothing'),
                  ),
                  leading: const Icon(Icons.sms),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text(
                    "Settings",
                    style: TextStyle(fontFamily: 'Nothing'),
                  ),
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text(
                    "About",
                    style: TextStyle(fontFamily: 'Nothing'),
                  ),
                  leading: const Icon(Icons.star),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              title: const Text(
                "L O G O U T",
                style: TextStyle(fontFamily: 'Nothing'),
              ),
              leading: const Icon(Icons.logout_outlined),
              onTap: () => logout(context), // Pass context to logout
            ),
          ),
        ],
      ),
    );
  }
}