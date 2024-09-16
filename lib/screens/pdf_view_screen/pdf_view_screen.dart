import 'package:erp_copy/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PdfViewerScreen extends StatelessWidget {
  final String filePath;

  const PdfViewerScreen({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    final fullUrl = '${ApiService.base}/$filePath';

    return Scaffold(
      appBar: AppBar(
        title: const Text('View PDF'),
        backgroundColor: const Color.fromARGB(255, 68, 168, 71),
      ),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(fullUrl)),
      ),
    );
  }
}
