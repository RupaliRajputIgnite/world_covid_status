import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core.dart';

class Api {
  static final Map<String, String> _header = {
    "X-RapidAPI-Key":  "08fa60901amsh37168630b70a793p16cae1jsn9bb5d7e4a262",//RAPID_API_KEY,
    "X-RapidAPI-Host":  "covid-193.p.rapidapi.com"//RAPID_API_HOST,
  };

  static dynamic _returnResponse(http.Response response) {
    try {
      switch (response.statusCode) {
        case 200:
          try {
            var responseJson = json.decode(response.body.toString());
            return responseJson;
          } catch (e) {
            print("error $e");
            return null;
          }

        default:
          return null;
      }
    } catch (e) {}
  }

  static fetchCountries() async {
    try {
      Uri url = Uri.parse(Config.COUNTRY_URL);
      var response = await http.get(url, headers: _header);
      var jsonResponse = _returnResponse(response);
      return CountryList.fromJson(jsonResponse);
    } catch (e) {
      print("errror ${e.toString()}");
    }
  }

  static fetchIsoCode() async {
    try {
      Uri url = Uri.parse(Config.ISO_CODE_URL);
      var response = await http.get(url);
      return _returnResponse(response);
    } catch (e) {
      print("error ${e.toString()}");
    }
  }

  static fetchCountryCovidDetails(String country) async {
    try {
      Uri url = Uri.parse(
        "${Config.COVID_STAT_URL}country=$country",
      );
      print("${Config.COVID_STAT_URL}country=$country");
      var response = await http.get(url, headers: _header);

      var jsonResponse = _returnResponse(response);
      print(jsonResponse);
      print(json.decode(response.body.toString()));

      return CovidStatResponse.fromJson(jsonResponse);
    } catch (e) {
      print("error ${e.toString()}");
    }
  }
}
