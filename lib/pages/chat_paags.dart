import 'package:flutter/material.dart';
import 'package:scholar_chat/componnts/bubelmasseg.dart';
import 'package:scholar_chat/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/models/masseg.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class ChatPaags extends StatelessWidget {
  static String id = 'Chatapp';
  CollectionReference masseges =
      FirebaseFirestore.instance.collection('masseg');

  TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: masseges.orderBy('CreatatAT', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Masseg> massegslist = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            var data = snapshot.data!.docs[i].data() as Map<String, dynamic>;
            massegslist.add(Masseg.fromjason(data));
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Kprimarycolors,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/scholar.png',
                      height: 50,
                    ),
                  ),
                  const Text('Cathapp')
                ],
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('assets/images/chat.jpg'), // مسار صورة الخلفية
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: massegslist.length,
                      itemBuilder: (context, index) {
                        return massegslist[index].id == email
                            ? bubelmasseg(masseg: massegslist[index])
                            : bubelmasssendar(masseg: massegslist[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        masseges.add({
                          'masseges': data,
                          'CreatatAT': DateTime.now(),
                          'id': email,
                        });

                        controller.clear();
                        _controller.animateTo(
                          0,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 500),
                        );
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'send a masseg',
                        hintStyle: const TextStyle(color: Colors.white),
                        suffix: Icon(
                          Icons.send,
                          color: Kprimarycolors,
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('loading.....'));
        }
      },
    );
  }
}
