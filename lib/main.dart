import 'package:care_connect/profiles/doc_profile.dart';
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
    return const MaterialApp(
      home: DocProfiles(),
    );
  }
}
