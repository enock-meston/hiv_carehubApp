import 'package:flutter/material.dart';
import 'package:hiv_carehub/controller/homeController.dart';
import 'package:get/get.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.fetchData(); // Fetch data when the screen is first created
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeController.fetchData(); // Refresh data whenever the screen is revisited
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (homeController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            children: <Widget>[
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  leading: Icon(
                    Icons.calendar_today,
                    size: 50,
                    color: Colors.blue,
                  ),
                  title: Text(
                    '${homeController.countAppointments.value}', // Now inside Obx()
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'My Appointments',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  leading: Icon(
                    Icons.calendar_today,
                    size: 50,
                    color: Colors.blue,
                  ),
                  title: Text(
                    '${homeController.countAprovedApp.value}', // Now inside Obx()
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Approved Appointments',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  leading: Icon(
                    Icons.message,
                    size: 50,
                    color: Colors.blue,
                  ),
                  title: Text(
                    '${homeController.countMessages.value}', // Now inside Obx()
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'My Messages',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  leading: Icon(
                    Icons.insert_chart,
                    size: 50,
                    color: Colors.blue,
                  ),
                  title: Text(
                    '${homeController.countResults.value}', // Now inside Obx()
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'My Results',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
