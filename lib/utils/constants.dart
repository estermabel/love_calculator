import 'package:dio/dio.dart';

class Constants {
  static String kBaseUrl = "https://love-calculator.p.rapidapi.com/";

  static String kApiKey = "bcd15b7346mshe40da8dad1ab385p1b99ebjsn720e5c3d3c90";

  static Options kOptions = Options(
    headers: {
      "X-RapidAPI-Key": "bcd15b7346mshe40da8dad1ab385p1b99ebjsn720e5c3d3c90",
      "X-RapidAPI-Host": "love-calculator.p.rapidapi.com"
    },
  );
}
