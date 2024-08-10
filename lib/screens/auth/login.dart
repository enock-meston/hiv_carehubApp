import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hiv_carehub/api/api.dart';
import 'package:hiv_carehub/controller/login_controller.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main_fragment.dart';

class LoginFragment extends StatefulWidget {
  @override
  State<LoginFragment> createState() => _LoginFragmentState();
}

class _LoginFragmentState extends State<LoginFragment> {
  final LoginController loginController = Get.put(LoginController());
  var formKey = GlobalKey<FormState>();
  //text field controllers
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  bool _isLoading = false; // Flag to track registration status

  Future<void> loginMethod() async {
    SharedPreferences sPreferences = await SharedPreferences.getInstance();
    setState(() {
      _isLoading = true;
    });
    var phoneTxt = phoneController.text;
    var passwordTxt = passwordController.text;
    try {
      var url = Uri.parse(API.login);
      var response = await http.post(url, body: {
        "phone": phoneTxt,
        "password": passwordTxt,
      });
      print("response.body: ${response.body}");
      var data1 = jsonDecode(response.body);
      var message1 = data1['message'];
      // print('message 1:'+ message1);
      if (message1.contains('Invalid credentials')) {
        Get.snackbar("Message", "Invalid credentials!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      } else if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var id = await sPreferences.setInt("id", data['patient']['id']);
        var names =
            await sPreferences.setString("names", data['patient']['names']);
        var phone = await sPreferences.setString(
            "phone_number", data['patient']['phone']);
        var status =
            await sPreferences.setString("status", data['patient']['status']);
        String? stringValue = sPreferences.getString('names');
        int? ids = sPreferences.getInt('id');

        print('Retrieved String: $stringValue');
        Get.snackbar("Message", "Login Successfully!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        Get.offAll(() => MainFragment());
        //end check if your subscription
      } else {
        print("response.body in else: ${response.body}");
      }
      // Future.delayed(Duration(seconds: 3), () {
      //   // After registration completes
      //   setState(() {
      //     _isLoading = false; // Set flag to false when registration completes
      //   });
      // });
    }on SocketException catch (e) {
      if (e.osError?.message == 'Network is unreachable') {
        print('Network is unreachable');
        Get.snackbar("Message", "Network is unreachable");
        // Display this message in your UI or log it
      } else {
        Get.snackbar("Message", 'SocketException occurred: ${e.message}');
        print('SocketException occurred: ${e.message}');
      }
    }  catch (e) {
      print('=====$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text("Login"),
          ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/logo.png'),
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Color.fromARGB(255, 203, 2, 26),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(() {
                    return TextFormField(
                      controller: passwordController,
                      obscureText: !loginController.isPasswordVisible.value,
                      decoration: InputDecoration(
                        labelText: 'password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.visibility),
                          onPressed: () {
                            loginController.togglePasswordVisibility();
                          },
                        ),
                        border: OutlineInputBorder(),
                      ),
                    );
                  }),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      // Handle login
                      if (formKey.currentState!.validate()) {
                        // print("validated!");
                        loginMethod();
                        // Get.offAll(() => MainFragment());
                        // loading dialog if login is processing
                        //loading dialog if login is processing
                        // Get.defaultDialog(
                        //   title: "Kwinjira",
                        //   content: CircularProgressIndicator(),
                        //   barrierDismissible: false,
                        // );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 203, 2, 26),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
