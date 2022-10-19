import 'package:flutter/material.dart';

import '../../utils/Styles.dart';
import '../../utils/colors.dart';


class MentorPendingRequests extends StatefulWidget {
  const MentorPendingRequests({Key? key}) : super(key: key);

  @override
  State<MentorPendingRequests> createState() => _MentorPendingRequestsState();
}

class _MentorPendingRequestsState extends State<MentorPendingRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Pending Requests',
          style: kDarkTextStyle,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: kDarkPrimaryColor,
          ),
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
      ),
      body: const Center(
        child: Text('No Pending Requests'),
      ),
    );
  }
}
