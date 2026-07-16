import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';

class YourWebView extends StatefulWidget {
  final String title;
  final String url;

  const YourWebView({required this.title, required this.url});

  @override
  _YourWebViewState createState() => _YourWebViewState();
}

class _YourWebViewState extends State<YourWebView> {
  bool isLoading = false;
  InAppWebViewController? _webViewController;
  late String outputData = ''; // Initialize with an empty string
  Future<bool?> _showExitConfirmationSheet() async {
    var media = MediaQuery.of(context).size;
    return await showModalBottomSheet<bool>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          height: media.height / 2.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Go Back?',
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              SizedBox(
                  height: media.height / 10,
                  child: Image.asset(
                    'assets/images/cabzoo_logo_tr.png',
                    fit: BoxFit.contain,
                  )),
              Text('this Transaction is not yet Complete',
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              SizedBox(
                height: media.width * 0.1,
                width: media.width * 0.85,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    Navigator.of(context).pop();
                  },
                  child: Text('CANCEL PAYMENT',
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                ),
              ),
              SizedBox(
                height: media.width * 0.1,
                width: media.width * 0.85,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffd8ad38)),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('CONTINUE PAYMENT',
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<bool> _onBackPress() async {
    final result = await _showExitConfirmationSheet();

    if (result != null && result) {
      return true; // Allow app exit
    }
    return false; // Don't exit the app
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.title,
          style: GoogleFonts.roboto(
              fontSize: media.width * 0.05, fontWeight: FontWeight.w600),
        ),
      ),
      body: WillPopScope(
        onWillPop: _onBackPress,
        child: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                ),
              ),
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
              onLoadStart: (controller, url) {
                setState(() {
                  isLoading = true;
                });
              },
              onLoadStop: (controller, url) {
                setState(() {
                  isLoading = false;
                });

                // After the page has loaded, execute JavaScript to get the output data
                _webViewController
                    ?.evaluateJavascript(
                  source: 'yourJavaScriptCode();',
                )
                    .then((result) {
                  // Handle the result here
                  setState(() {
                    outputData = result ?? ''; // Ensure result is not null
                  });
                });
              },
            ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            // You can display or use the fetched outputData as needed
            if (!isLoading && outputData.isNotEmpty)
              Center(
                child: Text('Output Data: $outputData'),
              ),
          ],
        ),
      ),
    );
  }
}
