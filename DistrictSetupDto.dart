import 'StateSetupDto.dart';

class DistrictSetupDto {
  int? id;
  String? districtName;
  StateSetupDto? stateId;
  String? activeStatus;

  DistrictSetupDto(
      {this.id, this.districtName, this.stateId, this.activeStatus});

  DistrictSetupDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtName = json['districtName'];
    stateId = json['stateId'] != null
        ? new StateSetupDto.fromJson(json['stateId'])
        : null;
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
