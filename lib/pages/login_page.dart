import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/const.dart';
import 'package:scholar_chat/pages/chat_paags.dart';
import 'package:scholar_chat/widgate/custom_textfield.dart';
import 'package:scholar_chat/widgate/loigin_widgate.dart';
import 'Register_page.dart';

class LoginPage extends StatefulWidget {
  static String id = 'LoginPage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool loadingState = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loadingState,
      child: Scaffold(
        backgroundColor: Kprimarycolors,
        body: Form(
          key: formKey,
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
                      'Login',
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
                  text1: 'Email',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LoiginWidgate(
                  obscur: true,
                  onChanged: (data) {
                    password = data;
                  },
                  text1: 'Password',
                ),
              ),
              CustomTextfield(
                onTab: () async {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      loadingState = true;
                    });

                    if (email != null && password != null) {
                      try {
                        var auth = FirebaseAuth.instance;
                        // Perform the login
                        await loginUser(auth);

                        Navigator.pushNamed(context, ChatPaags.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        String message;
                        if (e.code == 'user-not-found') {
                          message = 'No user found for that email.';
                        } else if (e.code == 'wrong-password') {
                          message = 'Wrong password provided for that user.';
                        } else {
                          message = 'Failed to log in: ${e.message}';
                        }
                        showSnackbar(context, message, Colors.red);
                      } catch (e) {
                        showSnackbar(
                            context, 'Failed to log in: $e', Colors.red);
                      }
                    } else {
                      // ignore: avoid_print
                      print('Email and password must not be null');
                    }

                    setState(() {
                      loadingState = false;
                    });
                  }
                },
                text2: 'Log in',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don’t have any account?',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RegisterPage.id);
                    },
                    child: const Text(
                      ' Sign Up',
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

  Future<void> loginUser(FirebaseAuth auth) async {
    await auth.signInWithEmailAndPassword(email: email!, password: password!);
  }

  void showSnackbar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
