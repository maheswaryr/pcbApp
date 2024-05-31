class UserSetupDto {
  int? userId;
  String? employeeId;
  String? userName;
  String? lastName;
  String? titleName;
  String? activeStatus;
  String? activatedDate;
  String? deactivatedDate;
  String? dob;
  String? fathersName;
  String? mobileNo;
  String? emailId;
  String? gender;
  String? userCode;
  String? activeDate;
  String? address;
  String? deactiveDate;
  String? designation;
  String? pfNo;
  String? uname;

  UserSetupDto(
      {this.userId,
      this.employeeId,
      this.userName,
      this.lastName,
      this.titleName,
      this.activeStatus,
      this.activatedDate,
      this.deactivatedDate,
      this.dob,
      this.fathersName,
      this.mobileNo,
      this.emailId,
      this.gender,
      this.userCode,
      this.activeDate,
      this.address,
      this.deactiveDate,
      this.designation,
      this.pfNo,
      this.uname});

  UserSetupDto.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    employeeId = json['employeeId'];
    userName = json['userName'];
    lastName = json['lastName'];
    titleName = json['titleName'];
    activeStatus = json['activeStatus'];
    activatedDate = json['activatedDate'];
    deactivatedDate = json['deactivatedDate'];
    dob = json['dob'];
    fathersName = json['fathersName'];
    mobileNo = json['mobileNo'];
    emailId = json['emailId'];
    gender = json['gender'];
    userCode = json['userCode'];
    activeDate = json['activeDate'];
    address = json['address'];
    deactiveDate = json['deactiveDate'];
    designation = json['designation'];
    pfNo = json['pfNo'];
    uname = json['uname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['employeeId'] = this.employeeId;
    data['userName'] = this.userName;
    data['lastName'] = this.lastName;
    data['titleName'] = this.titleName;
    data['activeStatus'] = this.activeStatus;
    data['activatedDate'] = this.activatedDate;
    data['deactivatedDate'] = this.deactivatedDate;
    data['dob'] = this.dob;
    data['fathersName'] = this.fathersName;
    data['mobileNo'] = this.mobileNo;
    data['emailId'] = this.emailId;
    data['gender'] = this.gender;
    data['userCode'] = this.userCode;
    data['activeDate'] = this.activeDate;
    data['address'] = this.address;
    data['deactiveDate'] = this.deactiveDate;
    data['designation'] = this.designation;
    data['pfNo'] = this.pfNo;
    data['uname'] = this.uname;
    return data;
  }
}
