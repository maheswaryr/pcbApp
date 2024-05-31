class OneTimeRegistrationDto {
  int? id;
  String? firstName;
  String? lastName;
  String? gender;
  String? dob;
  String? email;
  String? mobileNo;
  String? address;
  String? password;
  String? passResetStatus;
  String? otp;
  String? otpTime;
  String? submittedOn;
  String? status;
  DateTime? approvedOn;
  int? approvedBy;
  DateTime? rejectedOn;
  int? rejectedBy;
  String? rejectedReason;
  String? rejectedEmail;
  String? rejectedMobile;
  int? failedOtpAttemptCount;
  String? otpStatus;
  String? message;
  String? newPassword;
  String? confirmPassword;
  String? captcha;
  String? userType;

  OneTimeRegistrationDto(
      {this.id,
      this.firstName,
      this.lastName,
      this.gender,
      this.dob,
      this.email,
      this.mobileNo,
      this.address,
      this.password,
      this.passResetStatus,
      this.otp,
      this.otpTime,
      this.submittedOn,
      this.status,
      this.approvedOn,
      this.approvedBy,
      this.rejectedOn,
      this.rejectedBy,
      this.rejectedReason,
      this.rejectedEmail,
      this.rejectedMobile,
      this.failedOtpAttemptCount,
      this.otpStatus,
      this.message,
      this.newPassword,
      this.confirmPassword,
      this.captcha,
      this.userType});

  OneTimeRegistrationDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    dob = json['dob'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    address = json['address'];
    password = json['password'];
    passResetStatus = json['passResetStatus'];
    otp = json['otp'];
    otpTime = json['otpTime'];
    submittedOn = json['submittedOn'];
    status = json['status'];
    approvedOn = json['approvedOn'];
    approvedBy = json['approvedBy'];
    rejectedOn = json['rejectedOn'];
    rejectedBy = json['rejectedBy'];
    rejectedReason = json['rejectedReason'];
    rejectedEmail = json['rejectedEmail'];
    rejectedMobile = json['rejectedMobile'];
    failedOtpAttemptCount = json['failedOtpAttemptCount'];
    otpStatus = json['otpStatus'];
    message = json['message'];
    newPassword = json['newPassword'];
    confirmPassword = json['confirmPassword'];
    captcha = json['captcha'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['address'] = this.address;
    data['password'] = this.password;
    data['passResetStatus'] = this.passResetStatus;
    data['otp'] = this.otp;
    data['otpTime'] = this.otpTime;
    data['submittedOn'] = this.submittedOn;
    data['status'] = this.status;
    data['approvedOn'] = this.approvedOn;
    data['approvedBy'] = this.approvedBy;
    data['rejectedOn'] = this.rejectedOn;
    data['rejectedBy'] = this.rejectedBy;
    data['rejectedReason'] = this.rejectedReason;
    data['rejectedEmail'] = this.rejectedEmail;
    data['rejectedMobile'] = this.rejectedMobile;
    data['failedOtpAttemptCount'] = this.failedOtpAttemptCount;
    data['otpStatus'] = this.otpStatus;
    data['message'] = this.message;
    data['newPassword'] = this.newPassword;
    data['confirmPassword'] = this.confirmPassword;
    data['captcha'] = this.captcha;
    data['userType'] = this.userType;
    return data;
  }
}
