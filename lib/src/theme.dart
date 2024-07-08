import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

MaterialColor smartpayBlack = const MaterialColor(
  0xFF000000,
  <int, Color>{
    50: Color(0xFFF8F8F8),
    100: Color(0xFFE0E0E0),
    200: Color(0xFFBDBDBD),
    300: Color(0xFF9E9E9E),
    400: Color(0xFF757575),
    500: Color(0xFF616161),
    600: Color(0xFF424242),
    700: Color(0xFF212121),
    800: Color(0xDD000000),
    900: Color(0xFF000000),
  },
);

MaterialColor smartpayBlue = const MaterialColor(
  0xFF000000,
  <int, Color>{
    50: Color(0xFF8BFCEE),
    100: Color(0xFF67F4E7),
    200: Color(0xFF36EADC),
    300: Color(0xFF22D1C8),
    400: Color(0xFF1BBCB8),
    500: Color(0xFF16A8A8),
    600: Color(0xFF129093),
    700: Color(0xFF108089),
    800: Color(0xFF0B727F),
    900: Color(0xFF0A6375),
  },
);

MaterialColor smartpayCream = const MaterialColor(
  0xFF000000,
  <int, Color>{
    50: Color(0xFFFFFDFB),
    100: Color(0xFFFEF9F3),
    200: Color(0xFFFEF5ED),
    300: Color(0xFFFEF1E2),
    400: Color(0xFFFEECD8),
    500: Color(0xFFFEE6CB),
    600: Color(0xFFFEE0C0),
    700: Color(0xFFFEDAB1),
    800: Color(0xFFFED29F),
    900: Color(0xFFFEC88B),
  },
);

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: false,
      primarySwatch: smartpayBlack,
      brightness: Brightness.light,
      //Remove click and tap backgrounds with the 2 lines below
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Inter ',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headlineLarge: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontVariations: [FontVariation('wght', 700.0)],
        ),
        headlineMedium: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontVariations: [FontVariation('wght', 700.0)],
        ),
        headlineSmall: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          /* shadows: <Shadow>[
            Shadow(
              offset: Offset(1.0, 1.0),
              blurRadius: 1.0,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ], */
        ),
        titleLarge: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w900,
          fontSize: 22.0,
        ),
        bodySmall: TextStyle(
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
          color: Colors.black,
        ),
      ).apply(
        bodyColor: Colors.black,
        displayColor: Colors.black,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: smartpayBlack.shade900),
        actionsIconTheme: IconThemeData(
          color: smartpayBlack.shade900,
          size: 28,
        ),
        centerTitle: true,
        elevation: 2,
        toolbarHeight: 48,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: smartpayBlack.shade900,
        unselectedLabelColor: smartpayBlack.shade500,
        indicatorColor: smartpayBlack.shade600,
        dividerColor: smartpayBlack.shade300,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: smartpayBlack.shade800,
      ),
      tooltipTheme: TooltipThemeData(
        padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
        verticalOffset: 5,
        textStyle: const TextStyle(
          fontSize: 10,
          color: Colors.white,
        ),
        decoration: BoxDecoration(
          color: smartpayBlack.shade900.withOpacity(0.5),
          borderRadius: BorderRadius.zero,
        ),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: Colors.white,
        headerBackgroundColor: smartpayBlack.shade900,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      primarySwatch: Colors.grey,
      brightness: Brightness.dark,
      //Remove click and tap backgrounds with the 2 lins below
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      scaffoldBackgroundColor: const Color.fromARGB(249, 39, 39, 39),
      fontFamily: GoogleFonts.inter().fontFamily,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headlineLarge: TextStyle(
          color: Color.fromARGB(255, 217, 21, 7),
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Inter',
          fontVariations: [FontVariation('wght', 700.0)],
        ),
        headlineMedium: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Inter',
          fontVariations: [FontVariation('wght', 700.0)],
        ),
        headlineSmall: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          shadows: <Shadow>[
            Shadow(
              offset: Offset(1.0, 1.0),
              blurRadius: 1.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ],
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 22.0,
          color: Colors.white,
        ),
      ).apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 43, 43, 43),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        actionsIconTheme: IconThemeData(
          color: Color.fromARGB(255, 255, 255, 255),
          size: 28,
        ),
        centerTitle: true,
        elevation: 2,
        toolbarHeight: 48,
        titleTextStyle: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  //------------------ MAINSTYLES ------------------

  static appTitle() {
    return 'SmartPay';
  }

  static buttonNavigationText() {
    return TextStyle(
      fontSize: 11,
      color: Colors.grey[700],
    );
  }

  static buttonNavigationSelectedText() {
    return TextStyle(
      fontSize: 11,
      color: smartpayBlack.shade900,
    );
  }

  static sliverAppBarBackLeading(context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        InkWell(
          child: Container(
            decoration: grey1cir10BoxDecoration(),
            padding: const EdgeInsets.fromLTRB(9, 10, 9, 10),
            child: Icon(
              Icons.chevron_left,
              color: smartpayBlack.shade700,
              //size: 28,
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  //------------------ TEXTSTYLES ------------------

  static text12() {
    return const TextStyle(
      fontSize: 12,
    );
  }

  static text12Inverted() {
    return const TextStyle(
      fontSize: 12,
      color: Colors.white,
    );
  }

  static formDescription() {
    return TextStyle(
      fontSize: 12,
      color: smartpayBlack.shade400,
    );
  }

  static text12Bold() {
    return const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );
  }

  static text12Grey500() {
    return TextStyle(
      fontSize: 12,
      color: Colors.grey[500],
    );
  }

  static text14() {
    return const TextStyle(
      fontSize: 14,
    );
  }

  static text14Bold() {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );
  }

  static text16() {
    return const TextStyle(
      fontSize: 16,
      color: Colors.black,
    );
  }

  static text16GraySpaced() {
    return TextStyle(
      fontSize: 16,
      color: smartpayBlack.shade500,
      height: 1.5,
    );
  }

  static text16Bold() {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  static text16ExtraBold() {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w900,
      color: Colors.black,
    );
  }

  static text16Grey400() {
    return TextStyle(
      fontSize: 16,
      color: smartpayBlack.shade400,
    );
  }

  static text16BlueBold() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: smartpayBlue.shade900,
    );
  }

  static text18() {
    return const TextStyle(
      fontSize: 18,
      color: Colors.black,
    );
  }

  static text18Bold() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  static text18BlueBold() {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: smartpayBlue.shade900,
    );
  }

  static text18ExtraBold() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w900,
      color: Colors.black,
    );
  }

  static text18InvertedBold() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  static text20Bold() {
    return const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  static text28ExtraBold() {
    return const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    );
  }

  static text28BlueExtraBold() {
    return TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: smartpayBlue.shade900,
    );
  }

  static grey1cir10BoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        width: 1,
        color: smartpayBlack.shade200,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(15),
      ),
    );
  }

  //------------------ INPUTS ------------------

  static noInputBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(
        width: 0,
        //color: Colors.white,
        style: BorderStyle.none,
      ),
    );
  }

  //Input decoration
  static smartpayInputDecoration(String hint) {
    return InputDecoration(
      isDense: true,
      hintText: hint,
      border: AppTheme.noInputBorder(),
      enabledBorder: AppTheme.noInputBorder(),
      focusedBorder: AppTheme.smartpayFocusedBorder(),
      errorBorder: AppTheme.errorBorderRed(),
      focusedErrorBorder: AppTheme.errorBorderRed(),
      contentPadding: const EdgeInsets.all(20),
      filled: true,
      fillColor: smartpayBlack.shade50,
      alignLabelWithHint: false,
    );
  }

  //Focused border
  static smartpayFocusedBorder() {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(
        width: 1,
        style: BorderStyle.solid,
        color: smartpayBlue.shade600,
      ),
    );
  }

  //errorBorder
  static errorBorderRed() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(
        width: 1,
        style: BorderStyle.solid,
        color: Colors.red,
      ),
    );
  }

  //Buttons

  static blackButton() {
    return TextButton.styleFrom(
      padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
      foregroundColor: Colors.white,
      backgroundColor: smartpayBlack.shade800,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }

  static blackContainer(Widget widget) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(style: BorderStyle.none),
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        ),
        color: smartpayBlack.shade900,
      ),
      child: widget,
    );
  }

  static outlinedContainer(Widget widget) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          style: BorderStyle.solid,
          color: smartpayBlack.shade100,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        ),
        color: Colors.white,
      ),
      child: widget,
    );
  }

  static outlinedButton() {
    return OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      side: BorderSide(
        width: 2,
        color: smartpayBlack.shade300,
      ),
    );
  }

  //Gradient dividers
  static fadeGradientDivider(Alignment begin, Alignment end) {
    return Container(
      width: double.infinity,
      height: 2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            smartpayBlack.shade100,
            Colors.white,
          ],
          begin: begin,
          end: end,
        ),
      ),
    );
  }
}
