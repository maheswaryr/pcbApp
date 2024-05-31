import 'dart:io';


import 'package:pcbapp/ServiceVO/ApplicationDetailsDto.dart';
import 'package:pcbapp/ServiceVO/DistrictSetupDto.dart';
import 'package:pcbapp/ServiceVO/SeatUserAllotedDto.dart';

import 'ActDetailsDto .dart';

class InspectionDetailsDto {
  int? id;
  ApplicationDetailsDto? applicationId;
  String? inspectionNumber;
  SeatUserAllotedDto? initiatedBy;
  String? initiatedOn;
  String? inspectionDate;
  SeatUserAllotedDto? verifiedBy;
  String? verifiedOn;
  SeatUserAllotedDto? approvedBy;
  String? approvedOn;
  String? remarks;
  String? effort;
  String? findings;
  String? actionTaken;
  String? fileFileName;
  String? status;
  SeatUserAllotedDto? closedBy;
  int? sequenceNo;
  DistrictSetupDto? district;
  ActDetailsDto? consentType;
  int? establishmentId;
  String? draftReport;
  SeatUserAllotedDto? draftReportApprovedBy;
  String? draftReportApprovedOn;
  String? draftApproveStatus;
  String? timeFrom;
  String? timeTo;
  SeatUserAllotedDto? heldBy;
  // String? revisedStatus;
  String? gisLatitude;
  String? gisLongitude;
  File? file;
  String? fileContentType;

  InspectionDetailsDto({
      this.id,
      this.applicationId,
      this.inspectionNumber,
      this.initiatedBy,
      this.initiatedOn,
      this.inspectionDate,
      this.verifiedBy,
      this.verifiedOn,
      this.approvedBy,
      this.approvedOn,
      this.remarks,
      this.effort,
      this.findings,
      this.actionTaken,
      this.fileFileName,
      this.status,
      this.closedBy,
      this.sequenceNo,
      this.district,
      this.consentType,
      this.establishmentId,
      this.draftReport,
      this.draftReportApprovedBy,
      this.draftReportApprovedOn,
      this.draftApproveStatus,
      this.timeFrom,
      this.timeTo,
      this.heldBy,
      // this.revisedStatus,
      this.gisLatitude,
      this.gisLongitude,
      this.file,
      this.fileContentType,
  });

  InspectionDetailsDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    applicationId = json['applicationId'] != null
        ? new ApplicationDetailsDto.fromJson(json['applicationId'])
        : null;
    inspectionNumber = json['inspectionNumber'];
    initiatedBy = json['initiatedBy'] != null
        ? new SeatUserAllotedDto.fromJson(json['initiatedBy'])
        : null;
    initiatedOn = json['initiatedOn'];
    inspectionDate = json['inspectionDate'];
    verifiedBy = json['verifiedBy'] != null
        ? new SeatUserAllotedDto.fromJson(json['verifiedBy'])
        : null;
    verifiedOn = json['verifiedOn'];
    approvedBy = json['approvedBy'] != null
        ? new SeatUserAllotedDto.fromJson(json['approvedBy'])
        : null;
    approvedOn = json['approvedOn'];
    remarks = json['remarks'];
    effort = json['effort'];
    findings = json['findings'];
    actionTaken = json['actionTaken'];
    fileFileName = json['fileFileName'];
    status = json['status'];
    closedBy = json['closedBy'] != null
        ? new SeatUserAllotedDto.fromJson(json['closedBy'])
        : null;
    sequenceNo = json['sequenceNo'];
    district = json['district'] != null
        ? new DistrictSetupDto.fromJson(json['district'])
        : null;
    consentType = json['consentType'] != null
        ? new ActDetailsDto.fromJson(json['consentType'])
        : null;
    establishmentId = json['establishmentId'];
    draftReport = json['draftReport'];
    draftReportApprovedBy = json['draftReportApprovedBy'] != null ? new SeatUserAllotedDto.fromJson(json['draftReportApprovedBy'])
        : null;
    draftReportApprovedOn = json['draftReportApprovedOn'];
    draftApproveStatus = json['draftApproveStatus'];
    timeFrom = json['timeFrom'];
    timeTo = json['timeTo'];
    heldBy = json['heldBy']!=null?SeatUserAllotedDto.fromJson(json['heldBy']):null;
    // revisedStatus = json['revisedStatus'];
    gisLatitude = json['gisLatitude'];
    gisLongitude = json['gisLongitude'];
    file = json['file'];
    fileContentType = json['fileContentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.applicationId != null) {
      data['applicationId'] = this.applicationId!.toJson();
    }
    data['inspectionNumber'] = this.inspectionNumber;
    if (this.initiatedBy != null) {
      data['initiatedBy'] = this.initiatedBy;
    }
    data['initiatedOn'] = this.initiatedOn;
    data['inspectionDate'] = this.inspectionDate;
    if (this.verifiedBy != null) {
      data['verifiedBy'] = this.verifiedBy;
    }
    data['verifiedOn'] = this.verifiedOn;
    if (this.approvedBy != null) {
      data['approvedBy'] = this.approvedBy;
    }
    data['approvedOn'] = this.approvedOn;
    data['remarks'] = this.remarks;
    data['effort'] = this.effort;
    data['findings'] = this.findings;
    data['actionTaken'] = this.actionTaken;
    data['fileFileName'] = this.fileFileName;
    data['status'] = this.status;
    if (this.closedBy != null) {
      data['closedBy'] = this.closedBy;
    }
    data['sequenceNo'] = this.sequenceNo;
    if (this.district != null) {
      data['district'] = this.district;
    }
    if (this.consentType != null) {
      data['consentType'] = this.consentType;
    }
    data['establishmentId'] = this.establishmentId;
    data['draftReport'] = this.draftReport;
    if (this.draftReportApprovedBy != null) {
      data['draftReportApprovedBy'] = this.draftReportApprovedBy;
    }
    data['draftReportApprovedOn'] = this.draftReportApprovedOn;
    data['draftApproveStatus'] = this.draftApproveStatus;
    data['timeFrom'] = this.timeFrom;
    data['timeTo'] = this.timeTo;
    if(this.heldBy!=null){
      data['heldBy'] = this.heldBy;
    }
    // data['revisedStatus'] = this.revisedStatus;
    data['gisLatitude'] = this.gisLatitude;
    data['gisLongitude'] = this.gisLongitude;
    data['file'] = this.file;
    data['fileContentType)'] = this.fileContentType;
    return data;
  }
}
