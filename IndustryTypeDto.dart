import 'CategoryDto.dart';

class IndustryTypeDto {
  int? id;
  CategoryDto? category;
  String? type;

  IndustryTypeDto({this.id, this.category, this.type});

  IndustryTypeDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] != null
        ? new CategoryDto.fromJson(json['category'])
        : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['type'] = this.type;
    return data;
  }
}
