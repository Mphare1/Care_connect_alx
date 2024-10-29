import 'package:care_connect/doctor/doc_availbility.dart';
import 'package:care_connect/doctor/home_doc.dart';
import 'package:care_connect/home_patience.dart';
import 'package:care_connect/landing_screen.dart';
import 'package:care_connect/loginform.dart';
import 'package:care_connect/profiles/doc_profile.dart';
import 'package:care_connect/registration.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CareConnect());
}

class CareConnect extends StatefulWidget {
  const CareConnect({super.key});

  @override
  State<CareConnect> createState() => _CareConnectState();
}

class _CareConnectState extends State<CareConnect> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
