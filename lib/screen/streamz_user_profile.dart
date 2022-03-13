import 'package:flutter/material.dart';

class StreamzUserProfile extends StatefulWidget {
  const StreamzUserProfile({Key? key}) : super(key: key);

  @override
  State<StreamzUserProfile> createState() => _StreamzUserProfileState();
}

class _StreamzUserProfileState extends State<StreamzUserProfile> {
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: const Center(
        child: Text("Profile"),
      ),
    );
  }
}
