class MessageModel {
  String? title;
  String? subTitle;
  String? image;

  MessageModel({this.title, this.subTitle, this.image});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        title: json['title'], subTitle: json['subtitle'], image: json['image']);
  }
}
