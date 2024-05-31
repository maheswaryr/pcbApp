class HierarchySetupDto {
  int? hierarchyId;
  int? parentHierarchy;
  String? hierarchyName;
  String? hierarchyCode;
  String? activeStatus;
  String? category;
  String? allotStatus;
  String? leaf;
  int? groupId;
  int? post;
  int? hierarchyLevel;
  String? hierarchyTree;

  HierarchySetupDto(
      {this.hierarchyId,
      this.parentHierarchy,
      this.hierarchyName,
      this.hierarchyCode,
      this.activeStatus,
      this.category,
      this.allotStatus,
      this.leaf,
      this.groupId,
      this.post,
      this.hierarchyLevel,
      this.hierarchyTree});

  HierarchySetupDto.fromJson(Map<String, dynamic> json) {
    hierarchyId = json['hierarchyId'];
    parentHierarchy = json['parentHierarchy'];
    hierarchyName = json['hierarchyName'];
    hierarchyCode = json['hierarchyCode'];
    activeStatus = json['activeStatus'];
    category = json['category'];
    allotStatus = json['allotStatus'];
    leaf = json['leaf'];
    groupId = json['groupId'];
    post = json['post'];
    hierarchyLevel = json['hierarchyLevel'];
    hierarchyTree = json['hierarchyTree'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hierarchyId'] = this.hierarchyId;
    data['parentHierarchy'] = this.parentHierarchy;
    data['hierarchyName'] = this.hierarchyName;
    data['hierarchyCode'] = this.hierarchyCode;
    data['activeStatus'] = this.activeStatus;
    data['category'] = this.category;
    data['allotStatus'] = this.allotStatus;
    data['leaf'] = this.leaf;
    data['groupId'] = this.groupId;
    data['post'] = this.post;
    data['hierarchyLevel'] = this.hierarchyLevel;
    data['hierarchyTree'] = this.hierarchyTree;
    return data;
  }
}
