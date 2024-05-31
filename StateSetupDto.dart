class StateSetupDto {
  int? id;
  int? countryId;
  String? stateName;
  String? stateType;
  String? activeStatus;

  StateSetupDto(
      {this.id,
      this.countryId,
      this.stateName,
      this.stateType,
      this.activeStatus});

  StateSetupDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['countryId'];
    stateName = json['stateName'];
    stateType = json['stateType'];
    activeStatus = json['activeStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['countryId'] = this.countryId;
    data['stateName'] = this.stateName;
    data['stateType'] = this.stateType;
    data['activeStatus'] = this.activeStatus;
    return data;
  }
}
