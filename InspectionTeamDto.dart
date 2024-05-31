import 'package:pcbapp/ServiceVO/InspectionDetailsDto.dart';
import 'package:pcbapp/ServiceVO/SeatUserAllotedDto.dart';

class InspectionTeamDto {
  int? id;
  InspectionDetailsDto? inspectionId;
  SeatUserAllotedDto? allotId;

  InspectionTeamDto({this.id, this.inspectionId, this.allotId});

  InspectionTeamDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inspectionId = json['inspectionId'] != null ? new InspectionDetailsDto.fromJson(json['inspectionId']) : null;
    allotId = json['allotId'] != null ? new SeatUserAllotedDto.fromJson(json['allotId']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.inspectionId != null) {
      data['inspectionId'] = this.inspectionId!.toJson();
    }
    if (this.allotId != null) {
      data['allotId'] = this.allotId!.toJson();
    }
    return data;
  }
}
