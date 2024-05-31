class CategoryDto {
  int? id;
  String? categoryName;

  CategoryDto({this.id, this.categoryName});

  CategoryDto.fromJson(Map<String, dynamic> json) {
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
