import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth extends ChangeNotifier {
  String responseid = '';
  String token='';

  //authenticating otp
  Future authOtp(String mobilenum) async {
    var url = 'https://test-otp-api.7474224.xyz/sendotp.php';
    final response = await http.post(Uri.parse(url),
        body: jsonEncode({
          'mobile': mobilenum,
        }));

    if (response.statusCode == 200) {
      final extractedData = jsonDecode(response.body);
      responseid = extractedData['request_id'];
      print(response.body);
    } else {
      throw Exception('error');
    }
  }


/// calling apis for verifying otp
  Future verifyOtp(String otp) async {
    var url = 'https://test-otp-api.7474224.xyz/verifyotp.php';
    final response = await http.post(Uri.parse(url),
        body: jsonEncode({
          'request_id': responseid,
          'code': otp,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      var extracteddata = jsonDecode(response.body);
       token=extracteddata['jwt'];
      return extracteddata;
    } else {
      print('dtstdystd');
      throw Exception('error');
    }
  }
  ///pass the token ,email,name using apis
  Future Register(String name, String email) async {
    var url = 'https://test-otp-api.7474224.xyz/profilesubmit.php';
    final response =
        await http.post(Uri.parse(url), body: jsonEncode({"name": name, 'email': email,'token':token}));
    if (response.statusCode == 200) {
    } else {
      throw Exception('error');
    }
  }
}
