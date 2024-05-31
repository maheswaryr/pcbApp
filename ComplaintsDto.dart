
import 'dart:convert';

import 'DistrictSetupDto.dart';
import 'SeatUserAllotedDto.dart';

ComplaintsDto complaintsDtoFromJson(String str) =>
    ComplaintsDto.fromJson(json.decode(str));

String? complaintsDtoToJson(ComplaintsDto data) => json.encode(data.toJson());

class ComplaintsDto {
  int? id;
  String? petitionerName;
  String? email;
  String? mobileNo;
  String? address;
  String? compId;
  DistrictSetupDto? district;
  String? description;
  String? fileFileName;
  String? industryName;
  String? against;
  String? submittedOn;
  String? acknowledgeStatus;
  SeatUserAllotedDto? assignedTo;
  String? remarks;
  String? inspectionStatus;
  int? inspectionId;

  ComplaintsDto(
      {this.id,
      this.petitionerName,
      this.email,
      this.mobileNo,
      this.address,
      this.compId,
      this.district,
      this.description,
      this.fileFileName,
      this.industryName,
      this.against,
      this.submittedOn,
      this.acknowledgeStatus,
      this.assignedTo,
      this.remarks,
      this.inspectionStatus,
      this.inspectionId});

  ComplaintsDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    petitionerName = json['petitionerName'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    address = json['address'];
    compId = json['compId'];
    district = json['district'] != null
        ? new DistrictSetupDto.fromJson(json['district'])
        : null;
    description = json['description'];
    fileFileName = json['fileFileName'];
    industryName = json['industryName'];
    against = json['against'];
    submittedOn = json['submittedOn'];
    acknowledgeStatus = json['acknowledgeStatus'];
    assignedTo = json['assignedTo'] != null
        ? new SeatUserAllotedDto.fromJson(json['assignedTo'])
        : null;
    remarks = json['remarks'];
    inspectionStatus = json['inspectionStatus'];
    inspectionId = json['inspectionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['petitionerName'] = this.petitionerName;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['address'] = this.address;
    data['compId'] = this.compId;
    if (this.district != null) {
      data['district'] = this.district!.toJson();
    }
    data['description'] = this.description;
    data['fileFileName'] = this.fileFileName;
    data['industryName'] = this.industryName;
    data['against'] = this.against;
    data['submittedOn'] = this.submittedOn;
    data['acknowledgeStatus'] = this.acknowledgeStatus;
    if (this.assignedTo != null) {
      data['assignedTo'] = this.assignedTo!.toJson();
    }
    data['remarks'] = this.remarks;
    data['inspectionStatus'] = this.inspectionStatus;
    data['inspectionId'] = this.inspectionId;
    return data;
  }
}
