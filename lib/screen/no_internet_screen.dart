import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:streamz/tools/network_manager.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wifi_off_rounded,
            size: 100,
            color: Colors.white,
          ),
          const SizedBox(height: 3),
          Text(
            'Oops !',
            style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(height: 15),
          Text(
            'There is no internet connection',
            style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            'Please check your internet connection',
            style: GoogleFonts.poppins(fontSize: 15, color: Colors.white),
          ),
          const SizedBox(height: 15),
          MaterialButton(
            textColor: Colors.white,
            onPressed: _onTryAgainPressed,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            color: Colors.grey,
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  void _onTryAgainPressed() {
    Get.find<NetworkManager>().checkConnection();
  }
}
