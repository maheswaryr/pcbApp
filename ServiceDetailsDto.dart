import 'ActDetailsDto .dart';

class ServiceDetailsDto {
  int? id;
  ActDetailsDto? actId;
  String? serviceName;
  String? hoa;
  String? activeStatus;

  ServiceDetailsDto(
      {this.id, this.actId, this.serviceName, this.hoa, this.activeStatus});

  ServiceDetailsDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    actId = json['actId'] != null
        ? new ActDetailsDto.fromJson(json['actId'])
        : null;
    serviceName = json['serviceName'];
    hoa = json['hoa'];
    activeStatus = json['activeStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.actId != null) {
      data['actId'] = this.actId!.toJson();
    }
    data['serviceName'] = this.serviceName;
    data['hoa'] = this.hoa;
    data['activeStatus'] = this.activeStatus;
    return data;
  }
}
