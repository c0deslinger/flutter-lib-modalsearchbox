// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:modal_searchbox/modal_searchbox.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  final listCountry = const [
    "Indonesia",
    "Japan",
    "Korea",
    "United States",
    "Germany",
    "Australia",
    "China",
    "India",
    "Thailand",
    "Vietnam"
  ];
  String selectedCountry = "Indonesia";
  List<String> selectedMultipleCountry = [];

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modal Searchbox Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
            child: Column(children: [
          ModalSearchbox(
              padding: const EdgeInsets.all(0),
              label: "Select Country",
              selectedValue: selectedCountry,
              list: listCountry,
              contentPadding: const EdgeInsets.symmetric(vertical: 3),
              onChanged: (v) {
                selectedCountry = v;
              }),
          const SizedBox(height: 16),
          ModalSearchbox(
              padding: const EdgeInsets.all(0),
              label: "Select Multiple Country",
              isMultipleSelect: true,
              selectedMutipleValue: selectedMultipleCountry,
              list: listCountry,
              contentPadding: const EdgeInsets.symmetric(vertical: 5),
              onChanged: (newValue) {
                selectedMultipleCountry = newValue;
              })
        ])),
      ),
    );
  }
}
