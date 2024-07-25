import 'package:flutter/material.dart';
import 'package:scholar_chat/const.dart';
import 'package:scholar_chat/models/masseg.dart';

// ignore: must_be_immutable, camel_case_types
class bubelmasseg extends StatelessWidget {
  bubelmasseg({Key? key, required this.masseg}) : super(key: key);
  Masseg masseg;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.only(left: 6, top: 6, bottom: 6),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20)),
          color: Kprimarycolors,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            masseg.masseges,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable, camel_case_types
class bubelmasssendar extends StatelessWidget {
  bubelmasssendar({Key? key, required this.masseg}) : super(key: key);
  Masseg masseg;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.only(left: 6, top: 6, bottom: 6),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          color: Colors.blue,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            masseg.masseges,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
