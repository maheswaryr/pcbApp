

import 'package:pcbapp/ServiceVO/IndustryTypeDto.dart';

import 'CategoryDto.dart';
import 'DistrictSetupDto.dart';
import 'OneTimeRegistrationDto .dart';
import 'TalukSetupDto.dart';
import 'VillageSetupDto.dart';

class EstablishmentDetailsDto {
  int? id;
  String? establishmentType;
  String? industryName;
  String? address;
  String? pincode;
  DistrictSetupDto? district;
  TalukSetupDto? taluk;
  VillageSetupDto? village;
  String? surveyNo;
  String? registeredOfficeAddress;
  String? officePincode;
  DistrictSetupDto? officeDisrict;
  CategoryDto? category;
  IndustryTypeDto? industry;
  String? industryStatus;
  String? commissioningMonth;
  int? commissioningYear;
  String? industryLicenseNo;
  double? costOfLand;
  double? costOfBuilding;
  double? costOfPlant;
  double? capitalInvestment;
  String? industryScale;
  String? management;
  String? phoneNo;
  String? faxNo;
  String? email;
  String? cessStatus;
  String? hceType;
  CategoryDto?  hceCategoryId;
  String? hospitalStatus;
  int? noOfBed;
  String? occupierName;
  String? occupierAddress;
  String? occupierDesignation;
  String? nationality;
  String? occupierOfficeAddress;
  String? occupierPincode;
  DistrictSetupDto? occupierDistrict;
  String? occupierPhoneNo;
  String? occupierFaxNo;
  String? occupierMobileNo;
  String? occupierEmail;
  String? otp;
  String? otpTime;
  String? submittedOn;
  DateTime? approvedOn;
  int? approvedBy;
  DateTime? rejectedOn;
  int? rejectedBy;
  String? rejectedReason;
  String? rejectedMobileNo;
  String? rejectedEmail;
  String? status;
  DateTime? lastFailedAttemptOn;
  int? failedAttemptCount;
  int? failedOtpAttemptCount;
  String? addressStatus;
  DateTime? commissioningDate;
  String? otpStatus;
  String? message;
  OneTimeRegistrationDto? regId;
  String? editStatus;
  String? encryptedId;

  EstablishmentDetailsDto(
      {this.id,
      this.establishmentType,
      this.industryName,
      this.address,
      this.pincode,
      this.district,
      this.taluk,
      this.village,
      this.surveyNo,
      this.registeredOfficeAddress,
      this.officePincode,
      this.officeDisrict,
      this.category,
      this.industry,
      this.industryStatus,
      this.commissioningMonth,
      this.commissioningYear,
      this.industryLicenseNo,
      this.costOfLand,
      this.costOfBuilding,
      this.costOfPlant,
      this.capitalInvestment,
      this.industryScale,
      this.management,
      this.phoneNo,
      this.faxNo,
      this.email,
      this.cessStatus,
      this.hceType,
      this.hceCategoryId,
      this.hospitalStatus,
      this.noOfBed,
      this.occupierName,
      this.occupierAddress,
      this.occupierDesignation,
      this.nationality,
      this.occupierOfficeAddress,
      this.occupierPincode,
      this.occupierDistrict,
      this.occupierPhoneNo,
      this.occupierFaxNo,
      this.occupierMobileNo,
      this.occupierEmail,
      this.otp,
      this.otpTime,
      this.submittedOn,
      this.approvedOn,
      this.approvedBy,
      this.rejectedOn,
      this.rejectedBy,
      this.rejectedReason,
      this.rejectedMobileNo,
      this.rejectedEmail,
      this.status,
      this.lastFailedAttemptOn,
      this.failedAttemptCount,
      this.failedOtpAttemptCount,
      this.addressStatus,
      this.commissioningDate,
      this.otpStatus,
      this.message,
      this.regId,
      this.editStatus,
      this.encryptedId});

  EstablishmentDetailsDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    establishmentType = json['establishmentType'];
    industryName = json['industryName'];
    address = json['address'];
    pincode = json['pincode'];
    district = json['district'] != null
        ? new DistrictSetupDto.fromJson(json['district'])
        : null;
    taluk = json['taluk'] != null
        ? new TalukSetupDto.fromJson(json['taluk'])
        : null;
    village = json['village'] != null
        ? new VillageSetupDto.fromJson(json['village'])
        : null;
    surveyNo = json['surveyNo'];
    registeredOfficeAddress = json['registeredOfficeAddress'];
    officePincode = json['officePincode'];
    officeDisrict = json['officeDisrict'] != null
        ? new DistrictSetupDto.fromJson(json['officeDisrict'])
        : null;
    category = json['category'] != null
        ? new CategoryDto.fromJson(json['category'])
        : null;
    industry = json['industry'] != null
        ? new IndustryTypeDto.fromJson(json['industry'])
        : null;
    industryStatus = json['industryStatus'];
    commissioningMonth = json['commissioningMonth'];
    commissioningYear = json['commissioningYear'];
    industryLicenseNo = json['industryLicenseNo'];
    costOfLand = json['costOfLand'];
    costOfBuilding = json['costOfBuilding'];
    costOfPlant = json['costOfPlant'];
    capitalInvestment = json['capitalInvestment'];
    industryScale = json['industryScale'];
    management = json['management'];
    phoneNo = json['phoneNo'];
    faxNo = json['faxNo'];
    email = json['email'];
    cessStatus = json['cessStatus'];
    hceType = json['hceType'];
   // hceCategoryId = json['hceCategoryId'];
    hospitalStatus = json['hospitalStatus'];
    noOfBed = json['noOfBed'];
    occupierName = json['occupierName'];
    occupierAddress = json['occupierAddress'];
    occupierDesignation = json['occupierDesignation'];
    nationality = json['nationality'];
    occupierOfficeAddress = json['occupierOfficeAddress'];
    occupierPincode = json['occupierPincode'];
    occupierDistrict = json['occupierDistrict'] != null
        ? new DistrictSetupDto.fromJson(json['occupierDistrict'])
        : null;
    occupierPhoneNo = json['occupierPhoneNo'];
    occupierFaxNo = json['occupierFaxNo'];
    occupierMobileNo = json['occupierMobileNo'];
    occupierEmail = json['occupierEmail'];
    otp = json['otp'];
    otpTime = json['otpTime'];
    submittedOn = json['submittedOn'];
    approvedOn = json['approvedOn'];
    approvedBy = json['approvedBy'];
    rejectedOn = json['rejectedOn'];
    rejectedBy = json['rejectedBy'];
    rejectedReason = json['rejectedReason'];
    rejectedMobileNo = json['rejectedMobileNo'];
    rejectedEmail = json['rejectedEmail'];
    status = json['status'];
    lastFailedAttemptOn = json['lastFailedAttemptOn'];
    failedAttemptCount = json['failedAttemptCount'];
    failedOtpAttemptCount = json['failedOtpAttemptCount'];
    addressStatus = json['addressStatus'];
    commissioningDate = json['commissioningDate'];
    otpStatus = json['otpStatus'];
    message = json['message'];
    regId = json['regId'] != null
        ? new OneTimeRegistrationDto.fromJson(json['regId'])
        : null;
    editStatus = json['editStatus'];
    encryptedId = json['encryptedId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['establishmentType'] = this.establishmentType;
    data['industryName'] = this.industryName;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    if (this.district != null) {
      data['district'] = this.district!.toJson();
    }
    if (this.taluk != null) {
      data['taluk'] = this.taluk!.toJson();
    }
    if (this.village != null) {
      data['village'] = this.village!.toJson();
    }
    data['surveyNo'] = this.surveyNo;
    data['registeredOfficeAddress'] = this.registeredOfficeAddress;
    data['officePincode'] = this.officePincode;
    if (this.officeDisrict != null) {
      data['officeDisrict'] = this.officeDisrict!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.industry != null) {
      data['industry'] = this.industry!.toJson();
    }
    data['industryStatus'] = this.industryStatus;
    data['commissioningMonth'] = this.commissioningMonth;
    data['commissioningYear'] = this.commissioningYear;
    data['industryLicenseNo'] = this.industryLicenseNo;
    data['costOfLand'] = this.costOfLand;
    data['costOfBuilding'] = this.costOfBuilding;
    data['costOfPlant'] = this.costOfPlant;
    data['capitalInvestment'] = this.capitalInvestment;
    data['industryScale'] = this.industryScale;
    data['management'] = this.management;
    data['phoneNo'] = this.phoneNo;
    data['faxNo'] = this.faxNo;
    data['email'] = this.email;
    data['cessStatus'] = this.cessStatus;
    data['hceType'] = this.hceType;
   // data['hceCategoryId'] = this.hceCategoryId;
    data['hospitalStatus'] = this.hospitalStatus;
    data['noOfBed'] = this.noOfBed;
    data['occupierName'] = this.occupierName;
    data['occupierAddress'] = this.occupierAddress;
    data['occupierDesignation'] = this.occupierDesignation;
    data['nationality'] = this.nationality;
    data['occupierOfficeAddress'] = this.occupierOfficeAddress;
    data['occupierPincode'] = this.occupierPincode;
    if (this.occupierDistrict != null) {
      data['occupierDistrict'] = this.occupierDistrict!.toJson();
    }
    data['occupierPhoneNo'] = this.occupierPhoneNo;
    data['occupierFaxNo'] = this.occupierFaxNo;
    data['occupierMobileNo'] = this.occupierMobileNo;
    data['occupierEmail'] = this.occupierEmail;
    data['otp'] = this.otp;
    data['otpTime'] = this.otpTime;
    data['submittedOn'] = this.submittedOn;
    data['approvedOn'] = this.approvedOn;
    data['approvedBy'] = this.approvedBy;
    data['rejectedOn'] = this.rejectedOn;
    data['rejectedBy'] = this.rejectedBy;
    data['rejectedReason'] = this.rejectedReason;
    data['rejectedMobileNo'] = this.rejectedMobileNo;
    data['rejectedEmail'] = this.rejectedEmail;
    data['status'] = this.status;
    data['lastFailedAttemptOn'] = this.lastFailedAttemptOn;
    data['failedAttemptCount'] = this.failedAttemptCount;
    data['failedOtpAttemptCount'] = this.failedOtpAttemptCount;
    data['addressStatus'] = this.addressStatus;
    data['commissioningDate'] = this.commissioningDate;
    data['otpStatus'] = this.otpStatus;
    data['message'] = this.message;
    if (this.regId != null) {
      data['regId'] = this.regId!.toJson();
    }
    data['editStatus'] = this.editStatus;
    data['encryptedId'] = this.encryptedId;
    return data;
  }
}
