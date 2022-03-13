import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:streamz/tools/streamz_constants.dart';

class StreamzSearch extends StatefulWidget {
  const StreamzSearch({Key? key}) : super(key: key);

  @override
  State<StreamzSearch> createState() => _StreamzSearchState();
}

class _StreamzSearchState extends State<StreamzSearch> {
  final TextEditingController searchcontroller = TextEditingController();
  final _formSeachKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: erieBlack,
        title: TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          key: _formSeachKey,
          controller: searchcontroller,
        ),
      ),
      backgroundColor: erieBlack,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox(height: 45),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        // Display the correct icon depending on the state of the player.
        child: const Icon(
          Icons.play_arrow,
        ),
      ),
    );
  }
}
