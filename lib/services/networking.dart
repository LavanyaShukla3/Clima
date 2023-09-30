import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class Networking{
  Networking(this.url);
  final String url;

  Future getData() async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = response.body;
        return jsonDecode(data);
      }else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}