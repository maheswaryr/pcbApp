import 'package:pcbapp/ServiceVO/ComplaintsDto.dart';
import 'dart:convert' as convert;
import 'package:pcbapp/api/api.dart';

Future<ComplaintsDto> trackApi(ComplaintsDto tracktemp1) async {
  String? encodeData = convert.jsonEncode(tracktemp1);

  Map<String, String> headers = {'Content-Type': 'application/json',
      'Accept': 'application/json'};

    var response = await API.trackComplaintService(encodeData, headers);

    ComplaintsDto? tracktemp2;
    try {
      tracktemp2 = ComplaintsDto.fromJson(convert.jsonDecode(response.body));
    } catch (err) {
      print(err);
    }
    return tracktemp2!;
}
