import 'package:fe_attendance_app/features/main_feature/screens/profile/widgets/appbar_profile.dart';
import 'package:fe_attendance_app/utils/constants/text_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreen();
}

class _AccountInfoScreen extends State<AccountInfoScreen> {
  late final FirebaseAuth auth;

  @override
  void initState() {
    super.initState();

    auth = FirebaseAuth.instance;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                const TAppBar(
                  title: AppTexts.myProfileTitle,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 30.0, right: 10.0, top: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Full Name',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 40,
                            child: Text(
                              'Tên người dùng: ${auth.currentUser?.displayName ?? 'N/A'}',
                              style: const TextStyle(fontSize: 18),
                              softWrap: true,
                            ),
                            
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Email Address',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 40,
                            child: Text(
                              'Tên người dùng: ${auth.currentUser?.email ?? 'N/A'}',
                              style: const TextStyle(fontSize: 18),
                              softWrap: true,
                            ),
                          ),
                          
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
