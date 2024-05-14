import 'package:fido/auth_view.dart';
import 'package:fido/in_app_webview.dart';
// import 'package:fido/in_app_webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart'
    hide CustomTabsShareState;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_web_browser/flutter_web_browser.dart';

class MyChromeSafariBrowser extends ChromeSafariBrowser {
  @override
  void onOpened() {
    print("ChromeSafari browser opened");
  }

  @override
  void onCompletedInitialLoad() {
    print("ChromeSafari browser initial load completed");
  }

  @override
  void onClosed() {
    print("ChromeSafari browser closed");
  }
}

class MyInAppBrowser extends InAppBrowser {
  @override
  Future onBrowserCreated() async {
    print("Browser Created!");
  }

  @override
  Future onLoadStart(url) async {
    print("Started $url");
  }

  @override
  Future onLoadStop(url) async {
    print("Stopped $url");
  }

  @override
  void onLoadError(url, code, message) {
    print("Can't load $url.. Error: $message");
  }

  @override
  void onProgressChanged(progress) {
    print("Progress: $progress");
  }

  @override
  void onExit() {
    print("Browser closed!");
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  // final MyInAppBrowser browser = new MyInAppBrowser();
  final ChromeSafariBrowser browser = new MyChromeSafariBrowser();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // var options = InAppBrowserClassOptions(
  //     crossPlatform: InAppBrowserOptions(hideUrlBar: false),
  //     inAppWebViewGroupOptions: InAppWebViewGroupOptions(
  //         crossPlatform: InAppWebViewOptions(javaScriptEnabled: true)));

  // InAppWebViewController? webView;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Expanded(
            //   child: InAppWebView(
            //     initialUrlRequest: URLRequest(
            //       url: Uri.parse('https://webauthn.io'),
            //     ),
            //     onWebViewCreated: (controller) {
            //       webView = controller;
            //     },
            //   ),
            // ),
            // Expanded(
            //   child: InAppBrowserView(),
            // ),
            ElevatedButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AuthView();
                  },
                );
              },
              child: const Text('WebView Popup'),
            ),
            ElevatedButton(
              onPressed: () async {
                // showDialog(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return const AuthView();
                //   },
                // );
                // widget.browser.openUrlRequest(
                //     urlRequest: URLRequest(url: Uri.parse("https://webauthn.io")),
                //     options: options);

                // FlutterWebBrowser.events().listen((event) {
                //   print(event.toString());
                // });

                // FlutterWebBrowser.openWebPage(
                //   url: "https://webauthn.io/",
                //   customTabsOptions: const CustomTabsOptions(
                //     colorScheme: CustomTabsColorScheme.dark,
                //     toolbarColor: Colors.deepPurple,
                //     secondaryToolbarColor: Colors.green,
                //     navigationBarColor: Colors.amber,
                //     shareState: CustomTabsShareState.on,
                //     instantAppsEnabled: true,
                //     showTitle: true,
                //     urlBarHidingEnabled: true,
                //   ),
                //   safariVCOptions: const SafariViewControllerOptions(
                //     barCollapsingEnabled: true,
                //     preferredBarTintColor: Colors.green,
                //     preferredControlTintColor: Colors.amber,
                //     dismissButtonStyle:
                //         SafariViewControllerDismissButtonStyle.close,
                //     modalPresentationCapturesStatusBarAppearance: true,
                //   ),
                // );

                await widget.browser.open(
                  url: Uri.parse("https://webauthn.io/"),
                  options: ChromeSafariBrowserClassOptions(
                    android: AndroidChromeCustomTabsOptions(
                      shareState: CustomTabsShareState.SHARE_STATE_ON,
                      enableUrlBarHiding: true,
                    ),
                    ios: IOSSafariOptions(
                      barCollapsingEnabled: true,
                    ),
                  ),
                );
              },
              child: const Text('Tabs'),
            ),
            Visibility(
              visible: false,
              child: ElevatedButton(
                  onPressed: () async {
                    CookieManager cookieManager = CookieManager.instance();

                    // set the expiration date for the cookie in milliseconds
                    final expiresDate = DateTime.now()
                        .add(Duration(days: 3))
                        .millisecondsSinceEpoch;
                    final url = Uri.parse("https://webauthn.io/");

                    // set the cookie
                    // await cookieManager.setCookie(
                    //   url: url,
                    //   name: "myCookie",
                    //   value: "myValue",
                    //   expiresDate: expiresDate,
                    //   isSecure: true,
                    // );

                    // get cookies
                    List<Cookie> cookies =
                        await cookieManager.getCookies(url: url);
                    print(cookies);

                    // get a cookie
                    Cookie? cookie = await cookieManager.getCookie(
                        url: url, name: "myCookie");
                    print(cookie);
                  },
                  child: Text('Get Data')),
            ),
            ElevatedButton(
              onPressed: () async {
                await widget.browser.open(
                  url: Uri.parse(
                      "https://ipqualityscore.com/device-fingerprinting"),
                  options: ChromeSafariBrowserClassOptions(
                    android: AndroidChromeCustomTabsOptions(
                      shareState: CustomTabsShareState.SHARE_STATE_ON,
                      enableUrlBarHiding: true,
                    ),
                    ios: IOSSafariOptions(
                      barCollapsingEnabled: true,
                    ),
                  ),
                );
              },
              child: const Text('Tabs'),
            ),
          ],
        ),
      ),
    );
  }
}
