import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hiv_carehub/api/api.dart';
import 'package:hiv_carehub/controller/appointment_controller.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'appointment_details_fragment.dart';

class AppointmentFragment extends StatefulWidget {
  const AppointmentFragment({super.key});

  @override
  State<AppointmentFragment> createState() => _AppointmentFragmentState();
}

class _AppointmentFragmentState extends State<AppointmentFragment> {
  final AppointmentController controller = Get.put(AppointmentController());
  bool _isStored = false;
  var titleTxt = TextEditingController();
  final searchController = TextEditingController(); // Search text controller
  String searchQuery = ''; // Store search query

  @override
  void initState() {
    super.initState();
    controller.fetchAppointments();
  }

  Future<void> makeAppointment() async {
    setState(() {
      _isStored = true;
    });
    SharedPreferences spref = await SharedPreferences.getInstance();
    int? id = spref.getInt('id');

    final url = Uri.parse(API.make_appointment);
    final response = await http.post(
      url,
      body: {
        'patientId': id.toString(),
        'title': titleTxt.text.trim(),
      },
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );

    setState(() {
      _isStored = false;
    });
    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      if (responseData['message'] == "successfully") {
        Get.snackbar(
          'Message',
          '${responseData['message']}',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
        controller.fetchAppointments();
      } else {
        print('Server error ${responseData}: ${response.statusCode}');
        Get.snackbar(
          'Message',
          '${responseData['message']}',
          backgroundColor: Colors.red,
          colorText: Colors.black,
          duration: const Duration(seconds: 5),
        );
      }
    } else {
      print('Server error ${responseData}: ${response.statusCode}');
      Get.snackbar(
        'Error',
        ': ${response.statusCode}',
        backgroundColor: Colors.red,
        colorText: Colors.black,
        duration: const Duration(seconds: 5),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: 300,
              height: 40,
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase(); // Update search query
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAppointmentDialog(context);
            },
          ),

        ],
      ),
      body: Obx(() {
        // Check if data is loading
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        // Check if there's an error
        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        // Extract appointments
        final appointments = controller.appointments;

        // Filter appointments based on search query
        final filteredAppointments = appointments.where((appointment) {
          final titleLower = appointment.title.toLowerCase();
          return titleLower.contains(searchQuery);
        }).toList();

        return filteredAppointments.isNotEmpty
            ? ListView.builder(
          itemCount: filteredAppointments.length,
          itemBuilder: (context, index) {
            final appointment = filteredAppointments[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => AppointmentDetailsFragment(appointment: appointment));
              },
              onLongPress: () {
                Get.to(() => AppointmentDetailsFragment(appointment: appointment));
              },
              onHorizontalDragEnd: (details) {
                Get.to(() => AppointmentDetailsFragment(appointment: appointment));
              },
              child: ListTile(
                leading: Icon(Icons.help_center_outlined),
                title: Text(appointment.title),
                subtitle: Text(
                    'Date: ${appointment.createdAt?.toLocal().toString().split(' ')[0]}'),
                trailing: Icon(Icons.arrow_forward),
              ),
            );
          },
        )
            : Center(child: Text('No appointments found'));
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.fetchAppointments();
        },
        child: Icon(Icons.refresh),
        tooltip: 'Refresh',
      ),
    );
  }

  void _showAppointmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('New Appointment'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: titleTxt,
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                // Add more fields as needed
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                // Handle form submission
                makeAppointment();
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
