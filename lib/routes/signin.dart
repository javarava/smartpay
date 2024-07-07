import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              const SliverAppBar(
                //title: const Text('Inventory'),
                expandedHeight: 46,
                toolbarHeight: 46,
                floating: true,
                snap: true,
              ),
            ];
          },
          body: const Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [SizedBox(height: 40, child: Text('Sign in'))],
            ),
          ),
        ),
      ),
    );
  }
}
