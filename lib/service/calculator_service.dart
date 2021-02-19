import 'package:flutter/material.dart';
import 'package:love_calculator/model/Results.dart';
import 'package:love_calculator/service/config/api_service.dart';

class CalculatorService {
  final APIService _service;

  String _getPercentageBaseUrl = "/getPercentage";

  CalculatorService(this._service);

  Future<Results> getResults(
      {@required String fname, @required String sname}) async {
    String _getPercentageFinalUrl =
        "$_getPercentageBaseUrl?fname=$fname&sname=$sname";
    final response = await _service
        .doRequest(RequestConfig(_getPercentageFinalUrl, HttpMethod.get));

    var _results = Results.fromJson(response);
    return _results;
  }
}
