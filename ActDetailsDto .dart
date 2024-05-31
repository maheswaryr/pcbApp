class ActDetailsDto {
  int? id;
  String? actName;
  String? activeStatus;

  ActDetailsDto({this.id, this.actName, this.activeStatus});

  ActDetailsDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    actName = json['actName'];
    activeStatus = json['activeStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['actName'] = this.actName;
    data['activeStatus'] = this.activeStatus;
    return data;
  }
}
