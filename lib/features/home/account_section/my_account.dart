import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/core/common/constants/common_constants.dart';

import '../../../common/helper/navigation_helper.dart';

class MyAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text("Profile", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              CustomNavigationHelper.router.push(CustomNavigationHelper.cartPath);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Profile Section
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                // User Avatar
                CircleAvatar(
                  radius: 50,
                ),
                SizedBox(height: 12),

                // Name
                Text(
                  "Guest User",
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
                ),

                // Email
                Text(
                  "$number",
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Menu Options
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  buildMenuItem(Icons.person, "Edit Profile", () {}),
                  buildMenuItem(Icons.history, "My Orders", () {}),
                  buildMenuItem(Icons.logout, "Logout", () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('otpVerified', false);
                    CustomNavigationHelper.router.go(CustomNavigationHelper.loginPath);
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Menu Tile Widget
  Widget buildMenuItem(IconData icon, String text, VoidCallback onTap) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.only(bottom: 12),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(text, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
        trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
