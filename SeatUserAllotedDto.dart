

import 'package:pcbapp/ServiceVO/UserSetupDto.dart';

import 'HierarchySetupDto.dart';

class SeatUserAllotedDto {
  int? allotId;
  HierarchySetupDto? seat;
  UserSetupDto? user;
  String? activeDate;
  String? deactiveDate;
  String? activeStatus;
  String? passwd;
  int? userId;
  String? passwdReset;
  String? verifiedStatus;
  DateTime? verifiedDate;
  int? officeId;
  String? sectionCategory;
  int? hierarchyId;

  SeatUserAllotedDto(
      {this.allotId,
      this.seat,
      this.user,
      this.activeDate,
      this.deactiveDate,
      this.activeStatus,
      this.passwd,
      this.userId,
      this.passwdReset,
      this.verifiedStatus,
      this.verifiedDate,
      this.officeId,
      this.sectionCategory,
      this.hierarchyId});

  SeatUserAllotedDto.fromJson(Map<String, dynamic> json) {
    allotId = json['allotId'];
    seat = json['seat'] != null
        ? new HierarchySetupDto.fromJson(json['seat'])
        : null;
    user = json['user'] != null ? new UserSetupDto.fromJson(json['user']) : null;
    activeDate = json['activeDate'];
    deactiveDate = json['deactiveDate'];
    activeStatus = json['activeStatus'];
    passwd = json['passwd'];
    userId = json['userId'];
    passwdReset = json['passwdReset'];
    verifiedStatus = json['verifiedStatus'];
    verifiedDate = json['verifiedDate'];
    officeId = json['officeId'];
    sectionCategory = json['sectionCategory'];
    hierarchyId = json['hierarchyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allotId'] = this.allotId;
    if (this.seat != null) {
      data['seat'] = this.seat!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['activeDate'] = this.activeDate;
    data['deactiveDate'] = this.deactiveDate;
    data['activeStatus'] = this.activeStatus;
    data['passwd'] = this.passwd;
    data['userId'] = this.userId;
    data['passwdReset'] = this.passwdReset;
    data['verifiedStatus'] = this.verifiedStatus;
    data['verifiedDate'] = this.verifiedDate;
    data['officeId'] = this.officeId;
    data['sectionCategory'] = this.sectionCategory;
    data['hierarchyId'] = this.hierarchyId;
    return data;
  }
}
