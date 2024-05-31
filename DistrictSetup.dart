import 'package:pcbapp/ServiceVO/StateSetupDto.dart';

class DistrictSetup {
  int? id;
  String? districtName;
  StateSetupDto? stateId;
  String? activeStatus;

  DistrictSetup({this.id, this.districtName, this.stateId, this.activeStatus});

  DistrictSetup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtName = json['districtName'];
    stateId =
    json['stateId'] != null ? new StateSetupDto.fromJson(json['stateId']) : null;
    activeStatus = json['activeStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['districtName'] = this.districtName;
    if (this.stateId != null) {
      data['stateId'] = this.stateId!.toJson();
    }
    data['activeStatus'] = this.activeStatus;
    return data;
  }
}
