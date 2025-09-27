import 'dart:io';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'package:ececompanion/models/notification.dart' as notifications;

class WebViewContainer extends StatefulWidget {
  final String url;
  final String title;

  const WebViewContainer({Key? key, required this.url, required this.title}) : super(key: key);

  @override
  _WebViewContainerState createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  bool isLoading = true;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white
            ),
            Opacity(
              opacity: isLoading ? 0: 1,
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    useShouldOverrideUrlLoading: true,
                    useOnDownloadStart: true,
                  ),
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                },
                onProgressChanged: (controller, progress) {
                  setState(() {
                    this.progress = progress / 100;
                    if (this.progress >= 0.5) {
                      isLoading = false;
                    }
                  });
                },
                onLoadStop: (InAppWebViewController controller, Uri? url) {
                  setState(() {
                    isLoading = false;
                  });
                },
                onDownloadStartRequest: (controller, urlRequest) async {
                  final url = urlRequest.url.toString();
                  _showDownloadConfirmationDialog(url, widget.title);
                },
              ),
            ),
            if (isLoading)
              Center(
                child: Lottie.asset(
                  'json/loadinglottie.json',
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ),
      ),
    );
  }
  void _showDownloadConfirmationDialog(String url, String titleName) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration:  Duration(seconds: 3),
        backgroundColor: Colors.white,
        content: Text("Download Started", style: TextStyle(color: Colors.black)),
      ),
    );

    // Start the download process after showing the Snackbar
    _downloadFile(url, titleName);
  }

  Future<void> _downloadFile(String url, String titleName) async {
    try {
      // Get the Downloads directory path
      final downloadsDir = io.Directory('/storage/emulated/0/Download');

      // Ensure the Downloads directory exists
      if (!downloadsDir.existsSync()) {
        downloadsDir.createSync(recursive: true);
      }

      // Extract the file name from the URL or use a default name
      String fileName = '${titleName}.pdf';

      // Define the initial file path
      String filePath = '${downloadsDir.path}/$fileName';
      File file = File(filePath);

      // If the file already exists, generate a unique name by appending a number
      int fileCount = 1;
      while (file.existsSync()) {
        filePath = '${downloadsDir.path}/${fileName.split('.').first}($fileCount).${fileName.split('.').last}';
        file = File(filePath);
        fileCount++;
      }

      // Download the file
      final response = await HttpClient().getUrl(Uri.parse(url));
      final fileStream = await response.close();
      await fileStream.pipe(file.openWrite());

      // Show a notification after download is completed
      notifications.showNotification(fileName,filePath);

    } catch (e) {
      Get.snackbar(
        backgroundColor: Colors.white,
        "Download Failed",
        "Failed to download file: Try Again",
      );
    }
  }
}