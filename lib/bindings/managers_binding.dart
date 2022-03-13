import 'package:get/get.dart';
import 'package:streamz/tools/network_manager.dart';
import 'package:streamz/tools/webview_manager.dart';

/// [ManagerBinding] registers all domain specific controllers used across the
/// whole app. All dependencies are registered using the GetX state management
/// (more about the state management here: https://pub.dev/packages/get ).
class ManagerBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => RecentWatchManager());
    // Get.lazyPut(() => BookMarkManager());
    Get.put(WebViewManager());
    Get.put(NetworkManager());
  }
}
