import 'package:flutter/cupertino.dart';
import '../home/views/home_screen.dart';
import '../profile/views/profile_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: CupertinoColors.black,
        inactiveColor: CupertinoColors.systemGrey,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(CupertinoIcons.home, size: 24),
                    SizedBox(height: 2),
                    Text(
                      'Home',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
            ),
          ),
           BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(CupertinoIcons.person, size: 24),
                    SizedBox(height: 2),
                    Text(
                      'Profile',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
            ),
          ),
        
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return const HomeScreen();
          case 1:
            return const ProfileScreen();
          default:
            return const Center(child: Text("Unknown Tab"));
        }
      },
    );
  }
}
