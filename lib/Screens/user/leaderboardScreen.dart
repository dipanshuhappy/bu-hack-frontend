import 'package:BUPLAY/utils/Widgets/default_scaffold.dart';
import 'package:flutter/material.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({Key? key}) : super(key: key);

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: Container(
        child: Text('LeaderBoardScreen'),
      ),
    );
  }
}
