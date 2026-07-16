// ignore_for_file: file_names, prefer_const_constructors, unused_element, prefer_interpolation_to_compose_strings, avoid_print, use_build_context_synchronously, use_key_in_widget_constructors, must_be_immutable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:tagxiuser/pages/NavigatorPages/walletpage.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../functions/functions.dart';

class InstaMojoScreen extends StatefulWidget {
  // InstaMojoScreen({
  //   required amount,

  // });

  String amount = '';
  String name = '';
  String phone = '';
  String email = '';

  @override
  State<InstaMojoScreen> createState() => _InstaMojoScreenState();
}

class _InstaMojoScreenState extends State<InstaMojoScreen> {
  WebViewController? controller;
  String selectedUrl = '';
  //String id = '';
  bool isLoading = true;

  String apiKey = '96aab3b8a064553557bc3fbb20de7d98';
  String keyToken = 'e977ed1633e48dd59a4e50d809b9d7d2';
  // String apiKey = 'test_b678a7048c8a9e5f69663c2e4fa';
  // String keyToken = 'test_41af76995b230611b2c3b72b8cc';

  Future createRequest() async {
    Map<String, String> body = {
      "amount": addMoney.toString(), //amount to be paid
      "purpose": "Ride",
      "buyer_name": userDetails['name'],
      "email": userDetails['email'],
      "phone": userDetails['mobile'],
      "allow_repeated_payments": "true",
      "send_email": "false",
      "send_sms": "false",
      "redirect_url": "https://admin.nextdriveindia.com/",
      "webhook": "https://admin.nextdriveindia.com/",
    };

    var resp = await http.post(
        //'https://www.instamojo.com/api/1.1/payment-requests/'
        //'https://test.instamojo.com/api/1.1/payment-requests/'
        Uri.parse('https://www.instamojo.com/api/1.1/payment-requests/'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "X-Api-Key": apiKey,
          "X-Auth-Token": keyToken
        },
        body: body);
    var res = json.decode(resp.body);
    if (res['success'] == true) {
      print(res);
      setState(() {
        isLoading = false;
        selectedUrl = res['payment_request']['longurl'];
        //id = res['payment_request']['id'];
      });
    } else {
      print(res);
      Fluttertoast.showToast(msg: res['message']['amount'][0].toString());
    }
  }

  _checkPaymentStatus(String id) async {
    var response = await http.get(
        //https://www.instamojo.com/api/1.1/payments/$id/
        //https://test.instamojo.com/api/1.1/payments/$id/
        Uri.parse("https://www.instamojo.com/api/1.1/payments/$id/"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "X-Api-Key": apiKey,
          "X-Auth-Token": keyToken
        });
    var realResponse = json.decode(response.body);
    print('payment res : $realResponse');
    if (realResponse['success'] == true) {
      if (realResponse["payment"]['status'] == 'Credit') {
        print('successfull');
        print(realResponse);
        addMoneyRazorpay(addMoney, realResponse['payment']['payment_id']);
        Fluttertoast.showToast(msg: 'Payment successfull');
        Navigator.of(context).pop();
      } else {
        print('peding');
        Fluttertoast.showToast(msg: 'Payment panding');
        Navigator.of(context).pop();
      }
    } else {
      print("PAYMENT STATUS FAILED");
      Fluttertoast.showToast(msg: 'Payment failed');
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    createRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : InAppWebView(
              initialUrlRequest:
                  URLRequest(url: Uri.parse('$selectedUrl?embed=form')),
              onUpdateVisitedHistory: (context, uri, istrue) {
                String url = uri.toString();
                print(uri);
                if (mounted) {
                  //https://test.instamojo.com/order/status/
                  if (url.contains('https://admin.nextdriveindia.com/')) {
                    String paymentRequestId =
                        uri!.queryParameters['payment_id']!;
                    print("value is: " + paymentRequestId);
                    _checkPaymentStatus(paymentRequestId);
                  }
                }
              },
            ),
    ));
  }
}
