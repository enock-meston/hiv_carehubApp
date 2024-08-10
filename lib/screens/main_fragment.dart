import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiv_carehub/screens/appointment_fragment.dart';
import 'package:hiv_carehub/screens/home_fragment.dart';
import 'package:hiv_carehub/screens/lab_results_fragment.dart';
import 'package:hiv_carehub/screens/profile_fragment.dart';

import 'chat_fragment.dart';


class MainFragment extends StatefulWidget {
  @override
  State<MainFragment> createState() => _MainFragmentState();
}

class _MainFragmentState extends State<MainFragment> {

  int currentIndex = 0;

  final screens = [
    //screens
    HomeFragment(),
    AppointmentFragment(),
    ChatFragment(),
    LabResultsFragment(),
    ProfileFragment(),
  ];

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: screens,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 201, 201, 201),
        selectedItemColor: const Color.fromARGB(255, 220, 1, 1),
        unselectedItemColor: const Color.fromARGB(255, 13, 13, 13),
        iconSize: 30,
        onTap: (index) {
          // Set the selected index and animate to the corresponding page
          setState(() {
            currentIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_center_outlined),
            label: "Appointments",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital_outlined),
            label: "Lab Results",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
