import 'package:flutter/material.dart';
import '/src/widgets.dart';
import '/src/theme.dart';
import '/routes/passwordnew.dart';

Map? loggedinUser;
String? userEmail;
String? userID;

class PasswordRecoveryMethod extends StatefulWidget {
  final String email;
  const PasswordRecoveryMethod(this.email, {super.key});

  @override
  State<PasswordRecoveryMethod> createState() => _PasswordRecoveryMethodState();
}

class _PasswordRecoveryMethodState extends State<PasswordRecoveryMethod> {
  @override
  Widget build(BuildContext context) {
    //Get email from email text file using Provider
    String email = widget.email;

    //User String split to get email doman
    String emailDomain = email.split("@").last;

    //Mask email
    String maskedEmail = "*****@$emailDomain";

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                //title: const Text('Password Recovery'),
                expandedHeight: 46,
                toolbarHeight: 46,
                floating: true,
                snap: true,

                leading: AppTheme.sliverAppBarBackLeading(context),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),

                  const SizedBox(
                    width: 100,
                    height: 100,
                    child: Image(
                      fit: BoxFit.fitWidth,
                      image: AssetImage('assets/icons/identity-icon.png'),
                    ),
                  ),

                  const SizedBox(height: 30),

                  //Rich header text
                  richHeaderTextBlueMiddle(
                    'Verify your identity',
                    null,
                    null,
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Where would you like ${AppTheme.appTitle()} to send your security code?',
                      style: AppTheme.text16Grey400(),
                    ),
                  ),
                  const SizedBox(height: 30),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(style: BorderStyle.none),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      color: smartpayBlack.shade100,
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          child: Icon(
                            Icons.check_circle,
                            size: 30,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email',
                                style: AppTheme.text16Bold(),
                              ),
                              Text(
                                maskedEmail,
                                style: AppTheme.text16GraySpaced(),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          child: Icon(
                            Icons.mail_outline,
                            size: 30,
                            color: smartpayBlack.shade300,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 80),

                  // BUTTON
                  InkWell(
                    child: AppTheme.blackContainer(
                      Text(
                        'Send me email',
                        style: AppTheme.text18InvertedBold(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () async {

                      //PUSH TO PSET NEW PASSWORD
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const SetNewPassword(),
                                  ),
                                );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
