import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

void  main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  List<Map<String, dynamic>> dataList = [
    {
      "country": "Brazil",
      "id": 1,
    },
    {
      "country": "Brazil",
      "id": 2,
    },
    {
      "country": "Brazil",
      "id": 3,
    },
    {
      "country": "Brazil",
      "id": 4,
    },
    {
      "country": "Brazil",
      "id": 5,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dropdown"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: DropdownSearch<Map<String, dynamic>>(
          mode : Mode.BOTTOM_SHEET,
          items: dataList,
          onChanged: (value) => print(value?["id"] ?? null),
          selectedItem: {
            "country" : "Canada",
            "id": 3,
          },
          showClearButton: true,
          showSearchBox: true,
          popupItemBuilder: (context, item, isSelected) => ListTile(
            textColor: Colors.red,
            title: Text(item["country"].toString()),
          ),
          dropdownBuilder: (context, selectedItem) => Text(selectedItem?["country"].toString() ?? "Belum pilih negara"),
        ),
      ),
    );
  }
}