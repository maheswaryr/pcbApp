import 'DistrictSetupDto.dart';

class TalukSetupDto {
  int? id;
  String? talukName;
  DistrictSetupDto? districtId;
  String? activeStatus;

  TalukSetupDto({this.id, this.talukName, this.districtId, this.activeStatus});

  TalukSetupDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    talukName = json['talukName'];
    districtId = json['districtId'] != null
        ? new DistrictSetupDto.fromJson(json['districtId'])
        : null;
    activeStatus = json['activeStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['talukName'] = this.talukName;
    if (this.districtId != null) {
      data['districtId'] = this.districtId!.toJson();
    }
    data['activeStatus'] = this.activeStatus;
    return data;
  }
}
