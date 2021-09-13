import 'package:flutter/material.dart';

class CitySearchScreen extends StatelessWidget {
  const CitySearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('City Search Screen'),
      ),
    );
  }
}
