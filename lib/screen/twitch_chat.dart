import 'package:fake_football_desktop/components/above_keyboard_widget.dart';
import 'package:fake_football_desktop/components/fake_football_progress_indicator.dart';
import 'package:fake_football_desktop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class TwitchChatWidget extends StatefulWidget {
  static const String route = '/twitchChat/';

  @override
  State<StatefulWidget> createState() => _TwitchChatWidgetState();
}

class _TwitchChatWidgetState extends State<TwitchChatWidget> with AutomaticKeepAliveClientMixin {
  late final WebViewController _controller;
  late bool isLoading;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    isLoading = true;

    _controller = WebViewController()
      ..enableZoom(false)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) => setState(() => isLoading = false),
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) => NavigationDecision.navigate,
        ),
      )
      ..loadRequest(Uri.parse(TWITCH_CHAT_EMBED_URL));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        Visibility(
          visible: !isLoading,
          child: AboveKeyboard(
            child: WebViewWidget(
              controller: _controller, // Replace with your local server URL
            ),
          ),
        ),
        Visibility(
          visible: isLoading,
          child: Positioned.fill(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: const Center(
                child: FakeFootballProgressIndicator(),
              ),
            ),
          ),
        )
      ],
    );
  }
}
