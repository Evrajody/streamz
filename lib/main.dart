import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:streamz/https/request_service.dart';
import 'package:streamz/bindings/managers_binding.dart';
import 'package:streamz/tools/streamz_routes_match.dart';

void main(List<String> args) async {
  runApp(const StreamzApp());
}

class StreamzApp extends StatelessWidget {
  const StreamzApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => RequestService.create(),
          dispose: (_, RequestService service) => service.client.dispose(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        initialBinding: ManagerBinding(),
        getPages: StreamzRoutesMatchers.pages,
      ),
    );
  }
}
