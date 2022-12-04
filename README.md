# modal_searchbox
Plugin to create TextField with search box and modal / bottomsheet as selector

## Usage
To use this plugin, add ```modal_searchbox``` as a [dependency in your pubspec.yaml](https://flutter.io/platform-plugins/).

### Example
```dart
import 'package:modal_searchbox/modal_searchbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  String selectedCountry = "Indonesia";
  List<String> selectedSkill = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modal Searchbox Demo'),
      ),
      body: Center(
        child: Stack(
                children: [
                    CustomDropdownBox(
                        padding: const EdgeInsets.all(0),
                        label: "Select Country",
                        labelTextstyle: AppTextSyle.heading5,
                        selectedValue: selectedCountry,
                        list: const ["Indonesia", "Japan", "Korea"],
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 3),
                        onChanged: (v) {
                            selectedCountry = v;
                        }
                    ),
                    CustomDropdownBox(
                        padding: const EdgeInsets.all(0),
                        label: "Select Skill",
                        isMultipleSelect: true,
                        selectedMutipleValue: selectedSkill,
                        list: ["Programming", "Design", "DevOps"],
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 5),
                        onChanged: (newValue) {
                            selectedSkill = newValue;
                        }
                    )
                ]
            )
        ),
    );
  }
}
```
