import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/user_provider.dart';
import '/src/theme.dart';

Map? loggedinUser;
String? userID;
String? userFullName;

String? userPin;
String? userToken;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //Get user data from provider
    loggedinUser = context.watch<UserProvider>().loggedinUser;
    userToken = context.watch<UserProvider>().secretToken;

    return loggedinUser != null
        ? SafeArea(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      const SliverAppBar(
                        title: Text('Home'),
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
                                  "Hi, ${loggedinUser!['full_name']}!",
                                  style: AppTheme.text18Bold(),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              const SizedBox(height: 200),
                              Container(
                                  alignment: const Alignment(0, 0),
                                  child: Text(
                                    'Secret Token: \n\n$userToken',
                                    style: AppTheme.text16BlueBold(),
                                  )),
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
}
