import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuScreen extends StatelessWidget {
  final AwesomeDrawerBarController drawerController;
  const MenuScreen(this.drawerController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Menu',
                style: GoogleFonts.kameron(
                  textStyle: const TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
            const SizedBox(height: 40),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
              title: Text(
                'Home',
                style: GoogleFonts.kameron(
                  textStyle: const TextStyle(color: Colors.white),
                ),
              ),
              onTap: () {
                Get.toNamed('/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: Text(
                'Profile',
                style: GoogleFonts.kameron(
                  textStyle: const TextStyle(color: Colors.white),
                ),
              ),
              onTap: () {
                Get.toNamed('/profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: Text(
                'Settings',
                style: GoogleFonts.kameron(
                  textStyle: const TextStyle(color: Colors.white),
                ),
              ),
              onTap: () {
                Get.toNamed('/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: Text(
                'Logout',
                style: GoogleFonts.kameron(
                  textStyle: const TextStyle(color: Colors.white),
                ),
              ),
              onTap: () {
                Get.offAllNamed('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
