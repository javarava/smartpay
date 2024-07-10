import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/user_provider.dart';
import '/src/theme.dart';

Map? loggedinUser;

class Loans extends StatefulWidget {
  const Loans({super.key});

  @override
  State<Loans> createState() => _LoansState();
}

class _LoansState extends State<Loans> {
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
                        title: Text('Loans'),
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
                                  "Loans",
                                  style: AppTheme.text28BlueExtraBold(),
                                  textAlign: TextAlign.left,
                                ),
                              ),
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
