import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

/// The current route state. To change the current route, call obtain the state
/// using `WebViewStateScope.of(context)` and call `go()`:
///
/// ```
/// WebViewStateScope.of(context).go('/book/2');
/// ```
class WebViewState extends ChangeNotifier {
  late final WebViewController _controller;
  WebViewController get controller => _controller;
  // ignore: unused_field
  late JavaScriptMessage _message;

  WebViewState(String url) {
    _message = const JavaScriptMessage(message: '');

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
							Page resource error:
								code: ${error.errorCode}
								description: ${error.description}
								errorType: ${error.errorType}
								isForMainFrame: ${error.isForMainFrame}
					''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          _handleMessageReceived(message);
        },
      )
      ..setBackgroundColor(Colors.white)
      ..loadRequest(Uri.parse(url))
      ..enableZoom(false);

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  void _handleMessageReceived(JavaScriptMessage message) {
    _message = message;
    notifyListeners();
  }

  Future<void> redirect(String route) async {
    _controller.loadRequest(Uri.parse('https://app.kaldesmart.com$route'));
    // notifyListeners();
  }
}

/// Provides the current [WebViewState] to descendant widgets in the tree.
class WebViewStateScope extends InheritedNotifier<WebViewState> {
  const WebViewStateScope({
    required super.notifier,
    required super.child,
    super.key,
  });

  static WebViewState of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<WebViewStateScope>()!
      .notifier!;
}
