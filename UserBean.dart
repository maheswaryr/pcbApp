class UserBean {
  String? seatName;
  String? empCode;
  String? empName;
  String? userOffice;
  String? userSection;
  String? category;
  String? officeCategory;
  String? parentGroupId;
  String? groupId;
  String? groupName;
  String? parentSeatId;
  String? userName;
  String? lastName;
  String? titleName;
  int? seatUserAllottedId;
  String? password;
  int? seatId;
  int? userId;
  String? passwdReset;
  int? officeId;
  int? post;
  String? firstName;
  String? email;
  String? mobileNo;
  String? roleName;
  String? address;
  String? userType;
  int? districtId;

  UserBean(
      {this.seatName,
        this.empCode,
        this.empName,
        this.userOffice,
        this.userSection,
        this.category,
        this.officeCategory,
        this.parentGroupId,
        this.groupId,
        this.groupName,
        this.parentSeatId,
        this.userName,
        this.lastName,
        this.titleName,
        this.seatUserAllottedId,
        this.password,
        this.seatId,
        this.userId,
        this.passwdReset,
        this.officeId,
        this.post,
        this.firstName,
        this.email,
        this.mobileNo,
        this.roleName,
        this.address,
        this.userType,
        this.districtId});

  UserBean.fromJson(Map<String, dynamic> json) {
    seatName = json['seatName'];
    empCode = json['empCode'];
    empName = json['empName'];
    userOffice = json['userOffice'];
    userSection = json['userSection'];
    category = json['category'];
    officeCategory = json['officeCategory'];
    parentGroupId = json['parentGroupId'];
    groupId = json['groupId'];
    groupName = json['groupName'];
    parentSeatId = json['parentSeatId'];
    userName = json['userName'];
    lastName = json['lastName'];
    titleName = json['titleName'];
    seatUserAllottedId = json['seatUserAllottedId'];
    password = json['password'];
    seatId = json['seatId'];
    userId = json['userId'];
    passwdReset = json['passwdReset'];
    officeId = json['officeId'];
    post = json['post'];
    firstName = json['firstName'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    roleName = json['roleName'];
    address = json['address'];
    userType = json['userType'];
    districtId = json['districtId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seatName'] = this.seatName;
    data['empCode'] = this.empCode;
    data['empName'] = this.empName;
    data['userOffice'] = this.userOffice;
    data['userSection'] = this.userSection;
    data['category'] = this.category;
    data['officeCategory'] = this.officeCategory;
    data['parentGroupId'] = this.parentGroupId;
    data['groupId'] = this.groupId;
    data['groupName'] = this.groupName;
    data['parentSeatId'] = this.parentSeatId;
    data['userName'] = this.userName;
    data['lastName'] = this.lastName;
    data['titleName'] = this.titleName;
    data['seatUserAllottedId'] = this.seatUserAllottedId;
    data['password'] = this.password;
    data['seatId'] = this.seatId;
    data['userId'] = this.userId;
    data['passwdReset'] = this.passwdReset;
    data['officeId'] = this.officeId;
    data['post'] = this.post;
    data['firstName'] = this.firstName;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['roleName'] = this.roleName;
    data['address'] = this.address;
    data['userType'] = this.userType;
    data['districtId'] = this.districtId;
    return data;
  }
}
