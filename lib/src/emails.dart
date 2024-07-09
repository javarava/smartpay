import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '/src/theme.dart';
import '/src/widgets.dart';

var f = NumberFormat('###,###,##0.00');

// Use the SmtpServer class to configure an SMTP server:
// final smtpServer = SmtpServer('smtp.domain.com');
// See the named arguments of SmtpServer for further configuration
// options.
final smtpServer = SmtpServer(
  'smtp.hostinger.com',
  port: 465,
  name: 'smtp.hostinger.com',
  ssl: true,
  username: 'smartpay@excel-servers01.com',
  password: 'dh&*3jrYR1d',
);

String appEmail = 'smartpay@excel-servers01.com';

//SEND NEW USER TOKEN EMAIL

Future<void> sendNewUserTokenMail(String userEmail, String token) async {
  // Create our message.
  final message = Message()
    ..from = Address(appEmail, AppTheme.appTitle())
    ..recipients.add(userEmail)
    //..ccRecipients.addAll(['cc@example.com'])
    //..bccRecipients.add(Address('bcc@example.com'))
    ..subject = 'Your registation verification code'
    ..text = 'Thank you for signing up on ${AppTheme.appTitle()}'
    ..html = newUserTokenMail(userEmail, token);

  try {
    final sendReport = await send(message, smtpServer);
    debugPrint('Message sent: $sendReport');
  } on MailerException catch (e) {
    debugPrint('Message not sent.');
    for (var p in e.problems) {
      debugPrint('Problem: ${p.code}: ${p.msg}');
    }
  }
  // DONE
}

String newUserTokenMail(userEmail, token) {
  return '''<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
      <head>
        <meta http-equiv="content-type" content="text/html; charset=unicode">
        <title>Your registation verification code</title>
      </head>

      <body style="font-size: 14px; font-family: helvetica, sans-serif; margin: 0px; line-height: 24px; background-color: #fbfbfb;">
        <div style="width: 100%;">
          <div style="border-left: 0px; border-top: 0px; border-right: 0px; border-bottom: 0px; padding-bottom: 0px; padding-top: 10px; padding-left: 0px; padding-right: 0px; background-color: #fbfbfb; width: 100%; margin-left:auto; margin-right:auto;">
            <table
                style="border-top: 0px; border-right: 0px; width: 600px; border-bottom: 0px; border-left: 0px; margin: 0px auto; background-color: #fff;"
                cellspacing="0" cellpadding="0" width="600" align="center">
                <tr>
                    <td
                        style="border-top: #eaeaea 0px solid; border-right: #eaeaea 0px solid; border-bottom: #eaeaea 0px solid; padding-bottom: 10px; padding-top: 15px; border-left: #eaeaea 0px solid; background-color: #fbfbfb;">
                        <table
                            style="border-top: #fff 0px solid; border-right: #fff 0px solid; width: 540px; border-bottom: #fff 0px solid; border-left: #fff 0px solid; margin: 10px auto 5px; background-color: #fbfbfb;"
                            cellspacing="0" cellpadding="0" width="540" align="center" border="0">
                            <tr>
                                <td
                                    style="padding-bottom: 30px; text-align: center; padding-top: 0px; padding-left: 0px; margin: 0px; padding-right: 0px;">
                                    <div style="font-size: 28px; font-weight:bold; color: #000000; margin-bottom: 10px;">Smart<span style="color: #0A6375;">pay</span></div>
                                </td>
                            </tr>
                            <tr>
                                <td
                                    style="border-top: #eaeaea 1px solid; border-right: #eaeaea 1px solid; background: #ffffff; border-bottom: #eaeaea 1px solid; padding-bottom: 0px; padding-top: 30px; padding-left: 20px; padding-right: 20px; border-left: #eaeaea 1px solid;">
                                    <table
                                        style="border-top: #fff 0px solid; border-right: #fff 0px solid; width: 540px; border-bottom: #fff 0px solid; border-left: #fff 0px solid; margin: 0px auto; background-color: #fff;"
                                        cellspacing="0" cellpadding="0" width="540" align="center" border="0">
                                        <tr>
                                            <td style="font-size: 14px; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; line-height: 24px; padding-right: 0px" valign="top">
                                                <h2
                                                    style="font-size: 28px; margin-bottom: 15px; margin-top: 0px; border-bottom: #eaeaea 1px solid; color: #0A6375; padding-bottom: 15px; text-align: left; line-height: 30px;">
                                                    Your registation verification code</h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="font-size: 14px; padding-bottom: 20px; padding-top: 0px; padding-left: 0px; margin: 0px; line-height: 24px; padding-right: 0px;" valign="top">
                                                <p>Dear $userEmail,</p>
                                                <p>Thank you for your registration on the ${AppTheme.appTitle()} app. We are excited to have you onboard.</p>
                                                
                                                <p>Your verification code is :
                                                <hr color: #eee;>
                                                <span style="font-size: 22px; font-weight: bold; text-align: center; width: 100%;display: block;">$token</span>
                                                <hr color: #eee;>
                                                </p>
                                              
                                                <p>Thank you.</p>

                                                <p>${AppTheme.appTitle()} Team</p>
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td
                                                style="font-size: 10px; border-top: 0px; color: #333; padding-bottom: 20px; padding-top: 20px; padding-left: 0px; padding-right: 0px; text-align: center; margin: 0px; line-height: 16px;">
                                                <p>&copy; ${DateTime.now().year}, ${AppTheme.appTitle()}</p>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
          </div>
        </div>
      </body>
    </html>''';
}

//SEND USER REGISTER EMAIL

Future<void> sendNewUserRegisterMail(Map user) async {
  // Create our message.
  final message = Message()
    ..from = Address(appEmail, AppTheme.appTitle())
    ..recipients.add(user['email'])
    //..ccRecipients.addAll(['cc@example.com'])
    //..bccRecipients.add(Address('bcc@example.com'))
    ..subject = 'Welcome to ${AppTheme.appTitle()}'
    ..text = 'We are thrilled to have you on board.'
    ..html = newUserRegisterMail(user);

  try {
    final sendReport = await send(message, smtpServer);
    debugPrint('Message sent: $sendReport');
  } on MailerException catch (e) {
    debugPrint('Message not sent.');
    for (var p in e.problems) {
      debugPrint('Problem: ${p.code}: ${p.msg}');
    }
  }
  // DONE
}

String newUserRegisterMail(Map user) {
  return '''<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
      <head>
        <meta http-equiv="content-type" content="text/html; charset=unicode">
        <title>Welcome to ${AppTheme.appTitle()}</title>
      </head>

      <body style="font-size: 14px; font-family: helvetica, sans-serif; margin: 0px; line-height: 24px; background-color: #fbfbfb;">
        <div style="width: 100%;">
          <div style="border-left: 0px; border-top: 0px; border-right: 0px; border-bottom: 0px; padding-bottom: 0px; padding-top: 10px; padding-left: 0px; padding-right: 0px; background-color: #fbfbfb; width: 100%; margin-left:auto; margin-right:auto;">
            <table
                style="border-top: 0px; border-right: 0px; width: 600px; border-bottom: 0px; border-left: 0px; margin: 0px auto; background-color: #fff;"
                cellspacing="0" cellpadding="0" width="600" align="center">
                <tr>
                    <td
                        style="border-top: #eaeaea 0px solid; border-right: #eaeaea 0px solid; border-bottom: #eaeaea 0px solid; padding-bottom: 10px; padding-top: 15px; border-left: #eaeaea 0px solid; background-color: #fbfbfb;">
                        <table
                            style="border-top: #fff 0px solid; border-right: #fff 0px solid; width: 540px; border-bottom: #fff 0px solid; border-left: #fff 0px solid; margin: 10px auto 5px; background-color: #fbfbfb;"
                            cellspacing="0" cellpadding="0" width="540" align="center" border="0">
                            <tr>
                                <td
                                    style="padding-bottom: 30px; text-align: center; padding-top: 0px; padding-left: 0px; margin: 0px; padding-right: 0px;">
                                    <div style="font-size: 28px; font-weight:bold; color: #000000; margin-bottom: 10px;">Smart<span style="color: #0A6375;">pay</span></div>
                                </td>
                            </tr>
                            <tr>
                                <td
                                    style="border-top: #eaeaea 1px solid; border-right: #eaeaea 1px solid; background: #ffffff; border-bottom: #eaeaea 1px solid; padding-bottom: 0px; padding-top: 30px; padding-left: 20px; padding-right: 20px; border-left: #eaeaea 1px solid;">
                                    <table
                                        style="border-top: #fff 0px solid; border-right: #fff 0px solid; width: 540px; border-bottom: #fff 0px solid; border-left: #fff 0px solid; margin: 0px auto; background-color: #fff;"
                                        cellspacing="0" cellpadding="0" width="540" align="center" border="0">
                                        <tr>
                                            <td style="font-size: 14px; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; line-height: 24px; padding-right: 0px" valign="top">
                                                <h2
                                                    style="font-size: 28px; margin-bottom: 15px; margin-top: 0px; border-bottom: #eaeaea 1px solid; color: #0A6375; padding-bottom: 15px; text-align: left; line-height: 30px;">
                                                    Welcome on board!</h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="font-size: 14px; padding-bottom: 20px; padding-top: 0px; padding-left: 0px; margin: 0px; line-height: 24px; padding-right: 0px;" valign="top">
                                                <p>Dear ${user['fill_name']},</p>
                                                <p>Thank you for registering with ${AppTheme.appTitle()}! We are thrilled to have you on board.</p>
                                                
                                                <p>Your registration was successful, and you can now enjoy all the features and benefits we offer. If you have any questions or need assistance, feel free to reach out to our support team at $appEmail.</p>
                                              
                                                <p>Welcome to the community!</p>

                                                <p>${AppTheme.appTitle()} Team</p>
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td
                                                style="font-size: 10px; border-top: 0px; color: #333; padding-bottom: 20px; padding-top: 20px; padding-left: 0px; padding-right: 0px; text-align: center; margin: 0px; line-height: 16px;">
                                                <p>&copy; ${DateTime.now().year}, ${AppTheme.appTitle()}</p>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
          </div>
        </div>
      </body>
    </html>''';
}
