class Productdata {
  int? _id;
  String? _title;
  int? _price;
  String? _description;
  Category? _category;
  List<String>? _images;

  Productdata(
      {int? id,
      String? title,
      int? price,
      String? description,
      Category? category,
      List<String>? images}) {
    if (id != null) {
      this._id = id;
    }
    if (title != null) {
      this._title = title;
    }
    if (price != null) {
      this._price = price;
    }
    if (description != null) {
      this._description = description;
    }
    if (category != null) {
      this._category = category;
    }
    if (images != null) {
      this._images = images;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get title => _title;
  set title(String? title) => _title = title;
  int? get price => _price;
  set price(int? price) => _price = price;
  String? get description => _description;
  set description(String? description) => _description = description;
  Category? get category => _category;
  set category(Category? category) => _category = category;
  List<String>? get images => _images;
  set images(List<String>? images) => _images = images;

  Productdata.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _price = json['price'];
    _description = json['description'];
    _category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    _images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    data['price'] = this._price;
    data['description'] = this._description;
    if (this._category != null) {
      data['category'] = this._category!.toJson();
    }
    data['images'] = this._images;
    return data;
  }
}

class Category {
  int? _id;
  String? _name;
  String? _image;

  Category({int? id, String? name, String? image}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (image != null) {
      this._image = image;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get image => _image;
  set image(String? image) => _image = image;

  Category.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['image'] = this._image;
    return data;
  }
}
