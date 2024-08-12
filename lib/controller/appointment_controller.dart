// lib/controllers/appointment_controller.dart

import 'package:get/get.dart';
import 'package:hiv_carehub/api/api.dart';
import 'package:hiv_carehub/model/appointment_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentController extends GetxController {
  var appointments = <AppointmentModel>[].obs; // Change to list of appointments
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAppointments(); // Update method name to reflect handling multiple appointments
  }

  Future<void> fetchAppointments() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    int? id = spref.getInt('id');

    isLoading.value = true;
    try {
      var url = API.appointment + id.toString();
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        List<dynamic> dataList = jsonResponse['data'];
        if (dataList.isNotEmpty) {
          appointments.value = dataList.map((item) => AppointmentModel.fromJson(item)).toList();
        }
        // print('$jsonResponse');
      } else {
        errorMessage.value = 'Failed to load appointments';
        print('Failed to load appointments');
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      print('Error in catch: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
