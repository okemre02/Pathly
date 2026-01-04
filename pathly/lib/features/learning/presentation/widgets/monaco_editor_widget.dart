import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../core/theme/app_colors.dart';

class MonacoEditorWidget extends StatefulWidget {
  final String initialCode;
  final Function(String) onCodeChanged;

  const MonacoEditorWidget({
    super.key,
    required this.initialCode,
    required this.onCodeChanged,
  });

  @override
  State<MonacoEditorWidget> createState() => _MonacoEditorWidgetState();
}

class _MonacoEditorWidgetState extends State<MonacoEditorWidget> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..addJavaScriptChannel(
        'EditorChannel',
        onMessageReceived: (JavaScriptMessage message) {
          try {
            final data = jsonDecode(message.message);
            if (data['type'] == 'CodeChanged') {
              widget.onCodeChanged(data['payload']);
            } else if (data['type'] == 'EditorReady') {
              // Send initial code when editor is ready
              _controller.runJavaScript(
                "window.setCode(`${widget.initialCode.replaceAll('`', '\\`')}`)",
              );
            }
          } catch (e) {
            debugPrint("Editor Error: $e");
          }
        },
      )
      ..loadFlutterAsset('assets/editor/index.html')
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
      ],
    );
  }
}
