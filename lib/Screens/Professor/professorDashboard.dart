import 'package:BUPLAY/Screens/Professor/SearchStudentView.dart';
import 'package:BUPLAY/Screens/Professor/mentor_requests.dart';
import 'package:BUPLAY/Screens/Professor/professorFunctions.dart';
import 'package:BUPLAY/Screens/user/transaction_history_screen.dart';
import 'package:BUPLAY/models/staff_details.dart';
import 'package:BUPLAY/services/staffCoins_http.dart';
import 'package:BUPLAY/services/staff_http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/Styles.dart';
import '../../utils/colors.dart';
import '../../utils/global_variables.dart';

class ProfessorDashboard extends StatefulWidget {
  const ProfessorDashboard({Key? key}) : super(key: key);

  @override
  State<ProfessorDashboard> createState() => _ProfessorDashboardState();
}

class _ProfessorDashboardState extends ProfessorFunctions {
  final _enrollEnteredController = TextEditingController();
  String _staffId = "";
  String _sigmaCoin = "";

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _staffId = prefs.getString(PREFERENCE_PROFESSOR_EMAIL)!;
        StaffCoinHttp.getStaffCoinDetails(
                prefs.getString(PREFERENCE_PROFESSOR_EMAIL)!)
            .then((value) => setState(() {
                  _sigmaCoin = value.sigmaCoin.toString();
                }));
      });
      print("$_sigmaCoin this is simga coin");
    });

    print("this is sigma coin $_sigmaCoin");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Professor Dashboard',
          style: kDarkTextStyle,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: kDarkPrimaryColor,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MentorPendingRequests(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: FutureBuilder<StaffDetails>(
                        future: StaffDetailsHttp.getStaffDetail(_staffId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ProfessorDetail(
                              id: _staffId,
                              name:
                                  "${snapshot.data?.first_name} ${snapshot.data?.last_name}",
                              email: snapshot.data?.bennett_email ?? "",
                              department:
                                  snapshot.data?.department_code ?? "error",
                              coin: _sigmaCoin,
                            );
                          } else if (snapshot.hasError) {
                            print("${snapshot.error} this is error");
                            return const Text("error");
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                    onTap: () => addNewDialog(context),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.17,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.upload,
                              color: kDarkPrimaryColor,
                              size: 50,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Add Coins Based On Quiz results(Upload Excel Sheet)',
                              textAlign: TextAlign.center,
                              style: kDarkTextStyle.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                            const SearchStudentView()))
                            .then((value) {
                          initState();
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.17,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.search,
                              color: kDarkPrimaryColor,
                              size: 50,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Allot Coins to Individual Students (search students)',
                              textAlign: TextAlign.center,
                              style: kDarkTextStyle.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              'Sigma transaction History',
              style: kLightTextStyle,
            ),
            const SizedBox(height: 10,),
            Expanded(
                child: TransactionList(
              id: _staffId,
              coin: "sigma",
              time_period: "week",
              userType: "sender_id",
            ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfessorDetail extends StatelessWidget {
  String id;
  String name;
  String email;
  String department;
  String coin;
  ProfessorDetail(
      {Key? key,
      required this.id,
      required this.name,
      required this.email,
      required this.department,
      required this.coin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: kNeutralColor,
          radius: 60,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: kDarkTextStyle,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              email,
              style: kDarkTextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              "Department: $department",
              style: kDarkTextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              "Sigma Coins",
              style: kDarkTextStyle.copyWith(
                  fontWeight: FontWeight.w500, fontSize: 16),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: kNeutralColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/sigmaCoin.png',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "$coin",
                        style: kDarkTextStyle.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
