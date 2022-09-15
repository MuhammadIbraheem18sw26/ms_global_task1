import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gs_global_task1/screens/home_page.dart';
import '../models/models.dart';
import 'package:http/http.dart ' as http;

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  String? email;
  String? password;

  LoginScreen({Key? key, this.email, this.password}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  static int? userId;

  Future<void> login(String email, password) async {
    bool? authenticUser = false;
    var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<UserModel> model = userModelFromJson(response.body);
      for (var i = 0; i < model.length; i++) {
        if (model[i].email == email && model[i].username == password) {
          authenticUser = true;
          userId = model[i].id;
          break;
        }
      }
      if (authenticUser!) {
        Get.to(HomePage(), arguments: userId);
      } else {
        Get.snackbar("Error", "Invalid Credentials");
      }
    }
  }

  final Color rwColor = const Color.fromRGBO(228, 50, 40, 1.0);

  final TextStyle focusedStyle = const TextStyle(color: Colors.grey);

  final TextStyle unfocusedStyle = const TextStyle(color: Colors.blue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
                child: Image(
                  image: AssetImage('assets/logo.jpeg'),
                ),
              ),
              const SizedBox(height: 16),
              buildCredentialsField('Email', emailEditingController),
              const SizedBox(height: 16),
              buildCredentialsField("Password", passwordEditingController),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                child: MaterialButton(
                  color: rwColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (emailEditingController.text.isNotEmpty &&
                        passwordEditingController.text.isNotEmpty) {
                      login(emailEditingController.text,
                          passwordEditingController.text);
                    } else if (emailEditingController.text.isEmpty ||
                        passwordEditingController.text.isEmpty) {
                      Get.snackbar("Error", "Credentials cannot be empty");
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCredentialsField(
      String hintText, TextEditingController textController) {
    return TextField(
      controller: textController,
      cursorColor: rwColor,
      decoration: InputDecoration(
        fillColor: Colors.white54,
        filled: true,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(height: 0.5),
      ),
    );
  }
}
