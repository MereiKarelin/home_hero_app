import 'package:datex/features/core/d_text_style.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DWebViewModal extends StatefulWidget {
  final String url;
  final String text;

  const DWebViewModal({super.key, required this.url, required this.text});

  @override
  State<DWebViewModal> createState() => _DWebViewModalState();
}

class _DWebViewModalState extends State<DWebViewModal> {
  WebViewController? _webViewController;
  @override
  void initState() {
    _webViewController = WebViewController();
    _webViewController?.loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              // Верхняя панель с крестиком
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(widget.text, style: DTextStyle.boldBlackText),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const Divider(height: 1),
              // WebView
              Expanded(child: _webViewController != null ? WebViewWidget(controller: _webViewController!) : const SizedBox()
                  //  WebView(
                  //   initialUrl: url,
                  //   javascriptMode: JavascriptMode.unrestricted,
                  // ),
                  ),
            ],
          ),
        );
      },
    );
  }
}
