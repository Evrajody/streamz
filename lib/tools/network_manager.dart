import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';

//Classe de gestion de la connectivité de l'apllication à internet

class NetworkManager extends GetxController {
  final Connectivity _connectmanager = Connectivity();
  bool _userIsOnline = false;

  bool get userIsOnline => _userIsOnline;

  @override
  void onInit() {
    super.onInit();
    _startMonitoring();
  }

  // Cette fonction indique l'etat de la connection de l'utilisateur
  Future<void> checkConnection() async {
    final connectivityResult = await _connectmanager.checkConnectivity();
    _onNetworkStateUpdated(connectivityResult);
  }

  void _onNetworkStateUpdated(ConnectivityResult connectivityResult) {
    _userIsOnline =
        (connectivityResult == ConnectivityResult.none ? false : true);
    update();
  }

  /// Monitoring de l'etat de la connection de l'utilisateur !!
  Future<void> _startMonitoring() async {
    _connectmanager.onConnectivityChanged.listen(_onNetworkStateUpdated);
    await checkConnection();
  }
}
