import 'package:pcbapp/ServiceVO/TalukSetupDto.dart';

class VillageSetupDto {
  int? id;
  String? villageName;
  TalukSetupDto? taluk;
  String? activeStatus;

  VillageSetupDto({this.id, this.villageName, this.taluk, this.activeStatus});

  VillageSetupDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    villageName = json['villageName'];
    taluk = json['taluk'] != null
        ? new TalukSetupDto.fromJson(json['taluk'])
        : null;
    activeStatus = json['activeStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['villageName'] = this.villageName;
    if (this.taluk != null) {
      data['taluk'] = this.taluk!.toJson();
    }
    data['activeStatus'] = this.activeStatus;
    return data;
  }
}
