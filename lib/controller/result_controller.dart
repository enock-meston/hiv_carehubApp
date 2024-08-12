import 'package:get/get.dart';
import 'package:hiv_carehub/api/api.dart';
import 'package:hiv_carehub/model/result_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ResultController extends GetxController {
  // Observable list to store results
  var results = <ResultModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  // Fetch results from the API
  Future<void> fetchResults() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    int? id = spref.getInt('id');
    final url = API.Myresult;

    try {
      isLoading(true);
      final response = await http.get(Uri.parse(url+id.toString()));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        results.value = data.map((json) => ResultModel.fromJson(json)).toList();
      } else {
        errorMessage('Failed to load results');
      }
    } catch (e) {
      errorMessage('An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}
