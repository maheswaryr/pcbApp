class HceCategoryDto {
  int? id;
  String? categoryName;

  HceCategoryDto({this.id, this.categoryName});

  HceCategoryDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryName'] = this.categoryName;
    return data;
  }
}
