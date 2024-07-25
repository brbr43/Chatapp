// ignore_for_file: file_names

// ignore: unused_import
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/const.dart';
import 'package:scholar_chat/pages/chat_paags.dart';
import 'package:scholar_chat/widgate/custom_textfield.dart';
import 'package:scholar_chat/widgate/loigin_widgate.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

  GlobalKey<FormState> fromkey = GlobalKey();
  bool lodingstate = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: lodingstate,
      child: Scaffold(
        backgroundColor: Kprimarycolors,
        body: Form(
          key: fromkey,
          child: ListView(
            children: [
              const SizedBox(
                height: 75,
              ),
              Image.asset(
                'assets/images/scholar.png',
                height: 100,
              ),
              const Center(
                child: Text(
                  'Welcome to my chat app',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontFamily: 'Pacifico'),
                ),
              ),
              const SizedBox(
                height: 75,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(9.0),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LoiginWidgate(
                  onChanged: (data) {
                    email = data;
                  },
                  text1: 'email',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LoiginWidgate(
                    obscur: true,
                    onChanged: (data) {
                      password = data;
                    },
                    text1: 'password'),
              ),
              CustomTextfield(
                onTab: () async {
                  if (fromkey.currentState!.validate()) {
                    lodingstate = true;
                    setState(() {});
                    if (email != null && password != null) {
                      try {
                        var auth = FirebaseAuth.instance;
                        // ignore: unused_local_variable
                        await reigsteruser(auth);

                        Navigator.pushNamed(context, ChatPaags.id);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to register user: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } else {
                      // ignore: avoid_print
                      print('Email and password must not be null');
                    }
                  }
                  lodingstate = false;
                  setState(() {});
                },
                text2: 'Sign UP',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Do you have an account?',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      ' Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showsnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registration successful!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> reigsteruser(FirebaseAuth auth) async {
    // ignore: unused_local_variable
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
