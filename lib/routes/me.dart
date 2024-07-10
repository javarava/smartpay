import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '/providers/user_provider.dart';
import '/src/widgets.dart';
import '/src/theme.dart';
import '/src/navigation.dart';
import '/src/datastorage.dart';

Map? loggedinUser;
String? userFullName;

class Me extends StatefulWidget {
  const Me({super.key});

  @override
  State<Me> createState() => _MeState();
}

class _MeState extends State<Me> {
  @override
  Widget build(BuildContext context) {
    //Get user data from provider
    loggedinUser = context.watch<UserProvider>().loggedinUser;

    return loggedinUser != null
        ? SafeArea(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      const SliverAppBar(
                        title: Text('Me'),
                        expandedHeight: 46,
                        toolbarHeight: 46,
                        floating: true,
                        snap: true,
                      )
                    ];
                  },
                  body: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 12, 15, 5),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "${displayGreeting()}, ${loggedinUser!['full_name']}!",
                                  style: AppTheme.text18Bold(),
                                  textAlign: TextAlign.left,
                                ),
                              ),

                              const SizedBox(height: 20),

                              //Signout Tab
                              InkWell(
                                child: tabWithIconTitleDesc(
                                  Icons.logout,
                                  'Sign Out',
                                  'Sign out from ${AppTheme.appTitle()}',
                                ),
                                onTap: () {
                                  showSignOutAlertDialog(context);
                                },
                              ),

                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          )
        : Container();
  }

  //Alert Dialog
  showSignOutAlertDialog(
    BuildContext context,
  ) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "No",
        style: AppTheme.text16Bold(),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Yes",
        style: AppTheme.text16Bold(),
      ),
      onPressed: () async {
        try {
          //Remove user from provider
          if (mounted) {
            context.read<UserProvider>().logOut();
          }

          //Write empty files
          writeDetails({});
          writeTokenFile('');

          debugPrint('User signed out!');

          if (mounted) {
            //check if mounted
            if (!context.mounted) return;

            //Close the dialog
            Navigator.of(context, rootNavigator: true).pop();

            goRouter.refresh();

            //Pop and go to home
            context.go('/welcome/signin');
          }
        } catch (e) {
          debugPrint('An error occurred during signout! $e');
        }
      },
    ); // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        'Are you sure?',
        style: AppTheme.text20Bold(),
      ),
      content: Text(
        'Are you sure you want to sign out?',
        style: AppTheme.text16(),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    ); // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
