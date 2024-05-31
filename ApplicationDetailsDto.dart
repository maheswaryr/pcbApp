
import 'ActDetailsDto .dart';
import 'EstablishmentDetailsDto.dart';
import 'HierarchySetupDto.dart';
import 'OneTimeRegistrationDto .dart';
import 'SeatUserAllotedDto.dart';
import 'ServiceDetailsDto.dart';

class ApplicationDetailsDto {
  int? id;
  EstablishmentDetailsDto? establishmentId;
  OneTimeRegistrationDto? otrId;
  ActDetailsDto? actId;
  ServiceDetailsDto? serviceId;
  String? initiatedOn;
  HierarchySetupDto? heldBy;
  int? officeId;
  String? status;
  String? submittedOn;
  String? appNo;
  SeatUserAllotedDto? approvedBy;
  String? approvedOn;
  SeatUserAllotedDto? rejectedBy;
  String? rejectedOn;
  String? rejectedRemarks;
  String? certificateNo;
  String? dsStatus;
  int? appRefId;
  String? envClearence;
  String? applicationDate;
  double? fee;
  int? noOfMonth;
  String? assetDate;
  double? assetValue;
  String? encryptedId;

  ApplicationDetailsDto({this.id,
      this.establishmentId,
      this.otrId,
      this.actId,
      this.serviceId,
      this.initiatedOn,
      this.heldBy,
      this.officeId,
      this.status,
      this.submittedOn,
      this.appNo,
      this.approvedBy,
      this.approvedOn,
      this.rejectedBy,
      this.rejectedOn,
      this.rejectedRemarks,
      this.certificateNo,
      this.dsStatus,
      this.appRefId,
      this.envClearence,
      this.applicationDate,
      this.fee,
      this.noOfMonth,
      this.assetDate,
      this.assetValue,
      this.encryptedId});

  ApplicationDetailsDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    establishmentId = json['establishmentId'] != null
        ? new EstablishmentDetailsDto.fromJson(json['establishmentId'])
        : null;
    otrId = json['otrId'] != null
        ? new OneTimeRegistrationDto.fromJson(json['otrId'])
        : null;
    actId = json['actId'] != null
        ? new ActDetailsDto.fromJson(json['actId'])
        : null;
    serviceId = json['serviceId'] != null
        ? new ServiceDetailsDto.fromJson(json['serviceId'])
        : null;
    initiatedOn = json['initiatedOn'];
    heldBy = json['heldBy'] != null
        ? new HierarchySetupDto.fromJson(json['heldBy'])
        : null;
    officeId = json['officeId'];
    status = json['status'];
    submittedOn = json['submittedOn'];
    appNo = json['appNo']; // approvedBy = json['approvedBy'];
    approvedOn = json['approvedOn'];
    rejectedBy = json['rejectedBy'] != null
        ? new SeatUserAllotedDto.fromJson(json['rejectedBy'])
        : null;
    rejectedOn = json['rejectedOn'];
    rejectedRemarks = json['rejectedRemarks'];
    certificateNo = json['certificateNo'];
    dsStatus = json['dsStatus'];
    appRefId = json['appRefId'];
    envClearence = json['envClearence'];
    applicationDate = json['applicationDate'];
    fee = json['fee'];
    noOfMonth = json['noOfMonth'];
    assetDate = json['assetDate'];
    assetValue = json['assetValue'];
    encryptedId = json['encryptedId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.establishmentId != null) {
      data['establishmentId'] = this.establishmentId!.toJson();
    }
    if (this.otrId != null) {
      data['otrId'] = this.otrId!.toJson();
    }
    if (this.actId != null) {
      data['actId'] = this.actId!.toJson();
    }
    if (this.serviceId != null) {
      data['serviceId'] = this.serviceId!.toJson();
    }
    data['initiatedOn'] = this.initiatedOn;
    if (this.heldBy != null) {
      data['heldBy'] = this.heldBy!.toJson();
    }
    data['officeId'] = this.officeId;
    data['status'] = this.status;
    data['submittedOn'] = this.submittedOn;
    data['appNo'] = this.appNo;
    data['approvedBy'] = this.approvedBy;
    data['approvedOn'] = this.approvedOn;
    if (this.rejectedBy != null) {
      data['rejectedBy'] = this.rejectedBy!.toJson();
    }
    data['rejectedOn'] = this.rejectedOn;
    data['rejectedRemarks'] = this.rejectedRemarks;
    data['certificateNo'] = this.certificateNo;
    data['dsStatus'] = this.dsStatus;
    data['appRefId'] = this.appRefId;
    data['envClearence'] = this.envClearence;
    data['applicationDate'] = this.applicationDate;
    data['fee'] = this.fee;
    data['noOfMonth'] = this.noOfMonth;
    data['assetDate'] = this.assetDate;
    data['assetValue'] = this.assetValue;
    data['encryptedId'] = this.encryptedId;
    return data;
  }
}
