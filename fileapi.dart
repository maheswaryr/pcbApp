

import 'dart:convert' as convert;

import 'package:pcbapp/ServiceVO/ComplaintsDto.dart';
import 'package:pcbapp/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ComplaintsDto> fileApi(ComplaintsDto? filetemp1) async {
  String? encodeData = convert.jsonEncode(filetemp1);
  Map<String, String> headers = { 'Content-Type': 'application/json',
      'Accept': 'application/json'};

  var response = await API.saveComplaintDetailsService(encodeData, headers);
  ComplaintsDto? filetemp2;
  try {
    if(response.statusCode == 200) {
      filetemp2 = complaintsDtoFromJson(response.body);
    } else {
      filetemp2 = null;
    }
  } catch (err) {
    print('error');
  }
  return filetemp2!;
}
