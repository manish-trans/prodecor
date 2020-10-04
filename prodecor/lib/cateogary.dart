class Cateogary {
  String success;
  String responseMsg;
  List<Category> category;

  Cateogary({this.success, this.responseMsg, this.category});

  Cateogary.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    responseMsg = json['response_msg'];
    if (json['category'] != null) {
      category = new List<Category>();
      json['category'].forEach((v) {
        category.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['response_msg'] = this.responseMsg;
    if (this.category != null) {
      data['category'] = this.category.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String displayName;
  String id;
  String name;
  String count;

  Category({this.displayName, this.id, this.name, this.count});

  Category.fromJson(Map<String, dynamic> json) {
    displayName = json['display_name'];
    id = json['id'];
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['display_name'] = this.displayName;
    data['id'] = this.id;
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}
