import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/enums.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constants/colors.dart';

class ChargeBalanceScreen extends StatefulWidget {
  final String link;
  const ChargeBalanceScreen({super.key, required this.link});

  @override
  State<ChargeBalanceScreen> createState() => _ChargeBalanceScreenState();
}

class _ChargeBalanceScreenState extends State<ChargeBalanceScreen> {
  late WebViewController webViewController;
  bool loading = false;
  @override
  void initState() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            log('1**');
            log('$progress Loading *********');
            if (progress < 100) {
              loading = true;
            } else {
              loading = false;
            }
            if (context.mounted) {
              setState(() {});
            }
          },
          onUrlChange: (change) {},
          onPageStarted: (String url) async {
            log('2**');

            log('+++++++$url++++++++');
          },
          onPageFinished: (String url) async {
            log('3**');

            log('=======$url===============');
            if (url.contains('success=false')) {
              Navigator.pop(context, false);
              showToast('Faild to pay', ToastState.error);
            }
            if (Platform.isAndroid) {
              if (url.contains('success=true')) {
                if (context.mounted) {
                  showToast('Payment Success', ToastState.success);

                  Navigator.pop(context, true);
                }
              }
            } else {
              if (url.contains('success=true')) {
                if (context.mounted) {
                  showToast('Payment Success', ToastState.success);

                  Navigator.pop(context, true);
                }
              }
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            log(request.url);
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.link));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        toolbarHeight: kToolbarHeight,
        title: const Text('Payment'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: webViewController),
          if (loading)
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
