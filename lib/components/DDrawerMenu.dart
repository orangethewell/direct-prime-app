import 'package:flutter/material.dart';

class DDrawerMenu extends StatelessWidget {
  const DDrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: 1000,
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 42,
                  backgroundImage: NetworkImage("https://media.istockphoto.com/id/910563528/pt/foto/handsome-man.jpg?s=1024x1024&w=is&k=20&c=TESzB4KaNtKBmi8BwfqOUppgUlwr2pM28YCQZqGbUH0=")
                ),
                SizedBox(height: 12),
                Text('Rivaldo Jesus', style: TextStyle(fontSize: 28, color: Theme.of(context).colorScheme.onPrimary)),
                Text('Espírito Santo', style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary)),
                SizedBox(height: 12),
              ],
            ),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            child: Wrap(
              runSpacing: 16,
              children: [
                ListTile(
                  leading: const Icon(Icons.home_outlined),
                  title: Text('Início'),
                  onTap: () {
                    // Navigate to Home screen
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.moped_outlined),
                  title: Text('Meus Jobs'),
                  onTap: () {
                    // Navigate to About screen
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: Text('Configurações'),
                  onTap: () {
                    // Navigate to Settings screen
                  },
                ),
              ],
            ),
          )
  
      ],
      ),
    );
  }
}