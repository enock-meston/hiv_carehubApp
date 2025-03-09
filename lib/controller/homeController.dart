import 'dart:convert';
import 'package:get/get.dart';
import 'package:hiv_carehub/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var countAppointments = 0.obs;
  var countAprovedApp = 0.obs;
  var countMessages = 0.obs;
  var countResults = 0.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getInt('id')?.toString(); // Ensure it's a string

      print('${API.myDash}$userId');
      var response = await http.get(
        Uri.parse('${API.myDash}$userId'),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        countAppointments.value = data['countAppointments'] ?? 0;
        countAprovedApp.value = data['countAprovedApp'] ?? 0;
        countMessages.value = data['countMessages'] ?? 0;
        countResults.value = data['countResults'] ?? 0;
        print("Data Fetched: $data");
      } else {
        Get.snackbar("Error", "Failed to fetch data");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
