import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:streamz/https/anime_service.dart';
import 'package:streamz/tools/streamz_constants.dart';
import 'package:streamz/tools/streamz_routes.dart';
import 'package:streamz/tools/webview_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../tools/webview_manager.dart';

class MediaFetchScreen extends StatefulWidget {
  const MediaFetchScreen({Key? key}) : super(key: key);

  @override
  State<MediaFetchScreen> createState() => _MediaFetchScreenState();
}

class _MediaFetchScreenState extends State<MediaFetchScreen> {
  final GlobalKey webViewKey = GlobalKey();
  WebViewController? _webViewController;
  final webViewManagerController = Get.find<WebViewManager>();
  // final _random = Random();
  var hasError = false.obs;
  Map<String, String> resolutions = {};
  final animeUrl = Get.arguments['animeUrl'];
  late final String mediaUrl;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    fetchVideoFile();
  }

  Future<void> fetchVideoFile() async {
    if (webViewManagerController.isWebView) {
      var mediaUrl =
          await AnimeService().fetchIframeEmbedded(animeUrl).catchError((_) {
        Get.dialog(AlertDialog(
          backgroundColor: erieBlack,
          content: const Text('An Error Occurred'),
        ));
        Get.back();
      });
      if (!mounted) return;
      await Get.offNamed(StreamzRoutes.webViewScreen, arguments: {
        'mediaUrl': 'https:' + mediaUrl,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0,
            child: webViewManagerController.isWebView
                ? const SizedBox()
                : FutureBuilder<String>(
                    future: AnimeService().fetchIframeEmbedded(animeUrl),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return SizedBox.fromSize(
                          size: Size(MediaQuery.of(context).size.width / 1.5,
                              MediaQuery.of(context).size.height / 1.5),
                          child: WebView(
                            initialUrl: 'https:${snapshot.data}',
                            javascriptMode: JavascriptMode.unrestricted,
                            allowsInlineMediaPlayback: true,
                            onWebViewCreated: (controller) async {
                              _webViewController = controller;
                            },
                            onPageFinished: (_) async {
                              mediaUrl = snapshot.data!;
                              // Ads Block
                              for (var i = 0; i < 8; i++) {
                                await _webViewController!
                                    .runJavascriptReturningResult(
                                        "document.getElementsByTagName('iframe')[$i].style.display='none';");
                                await _webViewController!
                                    .runJavascriptReturningResult(
                                        "document.getElementsByClassName('jw-icon jw-icon-display jw-button-color jw-reset')[0].click();");
                              }
                              // Fetching VidStreaming Url
                              String rawUrl = await _webViewController!
                                  .runJavascriptReturningResult(
                                      "document.getElementsByClassName('jw-video jw-reset')[0].attributes.src.value;");
                              if (rawUrl == 'null') {
                                hasError.value = true;
                              } else {
                                String url = rawUrl.split('"').toList()[1];

                                await _webViewController!
                                    .runJavascriptReturningResult(
                                        "if(document.getElementsByClassName('jw-icon jw-icon-display jw-button-color jw-reset')[0].ariaLabel == 'Play'){document.getElementsByClassName('jw-icon jw-icon-display jw-button-color jw-reset')[0].click();}");
                                String resolutionCount = await _webViewController!
                                    .runJavascriptReturningResult(
                                        "document.getElementsByClassName('jw-reset jw-settings-submenu-items')[1].getElementsByClassName('jw-reset-text jw-settings-content-item')['length'];");
                                for (var j = 0;
                                    j < double.parse(resolutionCount) - 1;
                                    j++) {
                                  String rawResolution = await _webViewController!
                                      .runJavascriptReturningResult(
                                          "document.getElementsByClassName('jw-reset jw-settings-submenu-items')[1].getElementsByClassName('jw-reset-text jw-settings-content-item')[$j].textContent;");
                                  String resolution = rawResolution
                                      .replaceFirst('"', ' ')
                                      .trim()
                                      .replaceFirst('"', ' ')
                                      .trim();
                                  String quality = resolution.split(' P')[0];
                                  resolutions.putIfAbsent(
                                      resolution,
                                      () => url.replaceFirst(
                                          RegExp(r'(.)[0-9]+(p.mp4)'),
                                          '.${quality}p.mp4'));
                                }
                                await Get.offNamed(
                                    StreamzRoutes.videoPlayerScreen,
                                    arguments: {
                                      'url': url,
                                      'resolutions': resolutions,
                                    });
                              }
                            },
                            navigationDelegate: (NavigationRequest request) {
                              return NavigationDecision.prevent;
                            },
                            backgroundColor: const Color(0x00000000),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
          ),
          Container(
            decoration: BoxDecoration(color: erieBlack),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                // Image.asset(
                //   'assets/gif/anime${1 + _random.nextInt(25)}.gif',
                //   width: 350,
                //   height: 200,
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .10,
                ),
                Text(
                  'En cours de chargement ...',
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                Obx(
                  () => Visibility(
                    visible: hasError.value,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'Loading too slow ?',
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: hasError.value,
                    child: MaterialButton(
                      onPressed: hasError.value
                          ? () {
                              Get.offNamed(StreamzRoutes.webViewScreen,
                                  arguments: {
                                    'mediaUrl': 'https:' + mediaUrl,
                                  });
                            }
                          : null,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: erieBlack,
                      child: const Text('Continue with WebView Player'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
