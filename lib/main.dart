import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/firebase_options.dart';
import 'package:scholar_chat/pages/Register_page.dart';
import 'package:scholar_chat/pages/chat_paags.dart';
import 'package:scholar_chat/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Chatapp());
}

class Chatapp extends StatelessWidget {
  const Chatapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        RegisterPage.id: (context) => const RegisterPage(),
        LoginPage.id: (context) => const LoginPage(),
        ChatPaags.id: (context) => ChatPaags(),
      },
      initialRoute: 'LoginPage',
    );
  }
}
