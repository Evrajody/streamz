import 'package:flutter/material.dart';

class StreamzDownload extends StatefulWidget {
  const StreamzDownload({Key? key}) : super(key: key);

  @override
  State<StreamzDownload> createState() => _StreamzDownloadState();
}

class _StreamzDownloadState extends State<StreamzDownload> {
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: const Center(
        child: Text("Download"),
      ),
    );
  }
}
