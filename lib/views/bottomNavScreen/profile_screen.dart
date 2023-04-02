import 'package:flutter/material.dart';
import 'package:untitled8/model/base_model.dart';
import 'package:untitled8/viewModels/auth_view_model.dart';
import 'package:untitled8/views/delete_screen.dart';
import 'package:untitled8/views/notification_screen.dart';
import 'package:untitled8/views/password_reset_screen.dart';
import 'package:untitled8/views/personal_screen.dart';
import 'package:untitled8/widgets/text_widget.dart';

import '../../services/base_view.dart';
import '../../widgets/custom_bottom_nav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
      onModelReady: (model) async {},
      builder: (context, model, child) => Scaffold(
        bottomNavigationBar: CustomBottomNav(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: buildText('Settings', Colors.black, 18, 0),
          centerTitle: true,
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Account Details & Options',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                TextandIconWidget(
                  text: 'Profile',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PersonalScreen()));
                  },
                ),
                const Divider(color: Colors.grey),
                TextandIconWidget(
                  text: 'Notification & Messages',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationScreen()));
                  },
                ),
                const Divider(color: Colors.grey),
                const SizedBox(height: 30),
                const Text(
                  'Account Details & Options',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                TextandIconWidget(
                  text: 'Password Reset',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PasswordResetScreen()));
                  },
                ),
                const Divider(color: Colors.grey),
                TextandIconWidget(
                  text: 'Delete Account',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DeleteScreen()));
                  },
                ),
                const Divider(color: Colors.grey),
                SizedBox(height: 30),
                model.loading
                    ? const CircularProgressIndicator(
                        backgroundColor: Colors.red,
                      )
                    : Center(
                        child: InkWell(
                          child: buildText('Log out', Colors.red, 15, 0),
                          onTap: () => model.logOutUser(),
                        ),
                      ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextandIconWidget extends StatelessWidget {
  final String text;
  Function()? onPressed;
  TextandIconWidget({required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 3, top: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildText(text, Colors.black, 14, 0),
          IconButton(
              onPressed: onPressed, icon: const Icon(Icons.arrow_forward_ios)),
        ],
      ),
    );
  }
}
