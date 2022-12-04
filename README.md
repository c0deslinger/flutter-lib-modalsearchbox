# modal_searchbox
Plugin to create TextField with search box and modal / bottomsheet as selector

## Usage
To use this plugin, add ```modal_searchbox``` as a [dependency in your pubspec.yaml](https://flutter.io/platform-plugins/).

### Demo
<p float="left">
<img src="https://user-images.githubusercontent.com/40958185/205479437-72917ced-5193-4cb3-a937-a08e6a0cabda.gif" width=20% height=20% /> <img src="https://user-images.githubusercontent.com/40958185/205479424-037a6aac-4c52-4047-b4cf-c85706548ff4.gif" width=20% height=20% />
</p>

### Example
```dart
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

```
