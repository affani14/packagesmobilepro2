import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import '../models/province.dart';
import '../models/city.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedProvinceId;
  String? selectedCityId;
  List<Province> provinces = [];
  List<City> cities = [];
  List<City> filteredCities = [];
  final String apiKey = '6ace7a67c088ba582776cf7b677692ebcd7e1256d76dd85c16b959782872276e';

  @override
  void initState() {
    super.initState();
    fetchProvinces();
  }

  Future<void> fetchProvinces() async {
    final response = await http.get(Uri.parse("https://api.binderbyte.com/wilayah/provinsi?api_key=$apiKey"));
    if (response.statusCode == 200) {
      List data = (json.decode(response.body) as Map<String, dynamic>)["value"];
      setState(() {
        provinces = data.map((json) => Province.fromJson(json)).toList();
      });
    } else {
      throw Exception("Failed to load provinces");
    }
  }

  Future<void> fetchCities(String provinceId) async {
    final response = await http.get(Uri.parse("https://api.binderbyte.com/wilayah/kabupaten?api_key=$apiKey&id_provinsi=$provinceId"));
    if (response.statusCode == 200) {
      List data = (json.decode(response.body) as Map<String, dynamic>)["value"];
      setState(() {
        cities = data.map((json) => City.fromJson(json)).toList();
        filteredCities = cities;
      });
    } else {
      throw Exception("Failed to load cities");
    }
  }

  void searchCity(String query) {
    setState(() {
      filteredCities = cities
          .where((city) => city.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wilayah Indonesia"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Province"),
            DropdownButton2(
              isExpanded: true,
              hint: Text("Select a province"),
              value: selectedProvinceId,
              items: provinces.map((Province province) {
                return DropdownMenuItem<String>(
                  value: province.id,
                  child: Text(province.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedProvinceId = value as String?;
                  selectedCityId = null;
                  cities = [];
                  filteredCities = [];
                });
                if (selectedProvinceId != null) {
                  fetchCities(selectedProvinceId!);
                }
              },
            ),
            SizedBox(height: 20),
            Text("Select City"),
            TextField(
              onChanged: searchCity,
              decoration: InputDecoration(
                labelText: "Search City",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 10),
            DropdownButton2(
              isExpanded: true,
              hint: Text("Select a city"),
              value: selectedCityId,
              items: filteredCities.map((City city) {
                return DropdownMenuItem<String>(
                  value: city.id,
                  child: Text(city.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCityId = value as String?;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
