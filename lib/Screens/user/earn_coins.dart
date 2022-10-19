import 'package:BUPLAY/Screens/user/request_coins.dart';
import 'package:flutter/material.dart';
import '../../utils/Styles.dart';
import '../../utils/colors.dart';

class EarnCoinsDashBoard extends StatefulWidget {
  const EarnCoinsDashBoard({Key? key}) : super(key: key);

  @override
  State<EarnCoinsDashBoard> createState() => _EarnCoinsDashBoardState();
}

class _EarnCoinsDashBoardState extends State<EarnCoinsDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: kDarkPrimaryColor,
          ),
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
        title: const Text(
          'Earn Coins',
          style: TextStyle(
            color: kDarkPrimaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              FieldBox(
                  label: 'Request Coins from mentor',
                  onChanged: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RequestCoins()))),
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              Text(
                'More Coming Soon....',
                style: kLightTextStyle.copyWith(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FieldBox extends StatelessWidget {
  Function onChanged;
  final String label;
  FieldBox({
    Key? key,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 70,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: kDarkSecondaryColor,
        ),
        child: Row(
          children: [
            Text(
              label,
              style: kLightTextStyle,
            ),
            const SizedBox(width: 20),
            Icon(Icons.add, color: primaryColor),
          ],
        ),
      ),
    );
  }
}
