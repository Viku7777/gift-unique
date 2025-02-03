class ReviewModel {
  String? title;
  double? rating;
  String? image;
  String? description;

  ReviewModel({this.title, this.rating, this.image, this.description});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    rating = json['rating'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['rating'] = rating;
    data['image'] = image;
    data['description'] = description;
    return data;
  }
}
