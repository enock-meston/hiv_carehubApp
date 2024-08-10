import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hiv_carehub/screens/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class ProfileFragment extends StatefulWidget {
  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  String _names = '';
  String _displayPhone = '';

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _names = prefs.getString('names') ?? 'Unknown';
      _displayPhone = prefs.getString('phone_number') ?? 'Unknown';
    });
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAll(LoginFragment());
  }

  void _confirmLogout() {
    Get.defaultDialog(
      title: "Gusohoka",
      middleText: "Uzi neza ko ushaka gusohoka?",
      textCancel: "Oya",
      textConfirm: "Yego",
      confirmTextColor: Colors.white,
      onConfirm: () {
        logout();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Umwirrondoro'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Stack(alignment: Alignment.center, children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('images/logo.png'),
              ),
            ]),
            SizedBox(height: 10),
            Text(
              _names,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              _displayPhone,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            ProfileMenuItem(
              icon: Icons.edit,
              text: 'Guhindura Umwirondoro',
              onTap: () {},
            ),
            ProfileMenuItem(
              icon: Icons.logout,
              text: 'Sohoka',
              onTap: () {
                _confirmLogout();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  ProfileMenuItem(
      {required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
