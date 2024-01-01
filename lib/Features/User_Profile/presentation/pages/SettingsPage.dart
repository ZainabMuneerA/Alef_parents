import 'package:alef_parents/core/app_theme.dart';
import 'package:alef_parents/framework/services/auth/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/app_bar.dart';
import '../../../../generated/l10n.dart';
import '../../../../main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = false;
  String currentLanguage = isArabic() ? 'عربي' : 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(
          showBackButton: true,
          title: "Settings",
        ),
      ),
      body: SafeArea(
        child: Container(
          height: 350,
          //290,
          margin: const EdgeInsets.all(30),
          // padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                title: Text(S.of(context).notification),
                trailing: CupertinoSwitch(
                  value: notificationsEnabled,
                  onChanged: (value) async {
                    setState(() {
                      notificationsEnabled = value;
                    });
                  },
                  activeColor: const Color.fromARGB(255, 224, 224, 228),
                  thumbColor: notificationsEnabled
                      ? primaryColor
                      : CupertinoColors.white,
                  trackColor: const Color.fromARGB(255, 225, 225, 233),
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              ListTile(
                title: Text(S.of(context).current_lang),
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: backgroundColor, // color for the tag
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    currentLanguage,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                onTap: () {
                  if (currentLanguage == 'English') {
                    _changeLanguage('ar'); // Switch to Arabic
                  } else {
                    _changeLanguage('en'); // Switch to English
                  }
                },
              ),
              const Divider(
                color: Colors.grey,
              ),
              ListTile(
                title: Text(S.of(context).about_us),
                trailing: const Icon(Icons.arrow_forward_ios),
                iconColor: primaryColor, // Use Icon widget to specify the icon
                onTap: () {
                  Navigator.pushNamed(context, '/about-us');
                },
              ),
              const Divider(
                color: Colors.grey,
              ),
              ListTile(
                title: Text(S.of(context).contact_us),
                trailing: const Icon(Icons.arrow_forward_ios),
                iconColor: primaryColor, // Use Icon widget to specify the icon
                onTap: () {
                  // Handle Contact Us tap
                  Navigator.pushNamed(context, '/contact-us');
                },
              ),
              const Divider(
                color: Colors.grey,
              ),
              ListTile(
                title: Text(S.of(context).log_out),
                trailing: const Icon(Icons.logout_rounded),
                iconColor: primaryColor, // Use Icon widget to specify the icon
                onTap: () {
                  //log out
                  Auth auth = Auth();
                  auth.signOut();
                  // Handle Contact Us tap
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeLanguage(String languageCode) async {
    await setLocale(languageCode);
    setState(() {
      if (languageCode == 'ar') {
        S.load(Locale(languageCode));
        currentLanguage = 'عربي';
      } else {
        S.load(Locale(languageCode));
        currentLanguage = 'English';
      }
    });
  }
}
