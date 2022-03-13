import 'package:get/get.dart';
import 'package:streamz/screen/media_fetch_screen.dart';
import 'package:streamz/screen/no_internet_screen.dart';
import 'package:streamz/screen/streamz_main.dart';
import 'package:streamz/screen/streamz_search.dart';
import 'package:streamz/screen/video_player_screen.dart';
import 'package:streamz/screen/webview_screen.dart';
import 'package:streamz/streamz_home.dart';
import 'package:streamz/tools/streamz_routes.dart';

/// [StreamRoutesMatchers] Gardes une correspondance de toutes
/// les noms de routes et les pages associés
class StreamzRoutesMatchers {
  StreamzRoutesMatchers._();

  static final pages = [
    GetPage(
      name: StreamzRoutes.streamzHome,
      page: () => const StreamzHome(),
    ),
    GetPage(
      name: StreamzRoutes.streamzMain,
      page: () => const StreamzMain(),
    ),
    GetPage(
      name: StreamzRoutes.streamzSearch,
      page: () => const StreamzSearch(),
    ),
    GetPage(
      name: StreamzRoutes.mediaFetchScreen,
      page: () => const MediaFetchScreen(),
    ),
    GetPage(
      name: StreamzRoutes.videoPlayerScreen,
      page: () => const VideoPlayerScreen(),
    ),
    GetPage(
      name: StreamzRoutes.webViewScreen,
      page: () => const WebViewScreen(),
    ),
    GetPage(
      name: StreamzRoutes.noInternetScreen,
      page: () => const NoInternetScreen(),
    ),
  ];
}
