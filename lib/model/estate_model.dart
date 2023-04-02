class Property {
  List<EstateModel>? data;

  Property({this.data});
  Property.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <EstateModel>[];
      json['data'].forEach((v) {
        data!.add(EstateModel.fromJson(v));
      });
    }
  }
}

class EstateModel {
  String? address;
  String? image;
  String? monthlyReturn;
  String? purchaseDate;
  int? availablePercentage;
  int? purchasePrice;
  String? totalReturn;
  String? type;
  String? percentageReturn;
  String? amountLeft;
  List<EarningModel>? earningModel;
  List<ImagesModel>? images;

  EstateModel(
      {this.address,
      this.image,
      this.monthlyReturn,
      this.purchaseDate,
      this.purchasePrice,
      this.availablePercentage,
      this.totalReturn,
      this.type,
      this.percentageReturn,
      this.earningModel,
      this.images,
      this.amountLeft});

  factory EstateModel.fromJson(Map<String, dynamic> json) {
    return EstateModel(
      address: json['address'],
      image: json['image'],
      monthlyReturn: json['monthlyReturn'],
      purchaseDate: json['purchaseDate'],
      availablePercentage: json['availablePercentage'],
      purchasePrice: json['purchasePrice'],
      totalReturn: json['totalReturn'],
      type: json['type'],
      percentageReturn: json['percentageReturn'],
      earningModel: json['earn'].cast<EarningModel>(),
      amountLeft: json['amountLeft'],
      //images: json['images'].cast<ImagesModel>(),
      images: List<ImagesModel>.from(
          json["images"].map((x) => ImagesModel.fromJson(x))),
    );
  }
}

class EarningModel {
  String? date;
  String? earning;
  String? value;

  EarningModel({this.date, this.earning, this.value});

  factory EarningModel.fromJson(Map<String, dynamic> json) {
    return EarningModel(
        date: json['date'], earning: json['earning'], value: json['value']);
  }
}

class ImagesModel {
  String? image;

  ImagesModel({this.image});

  factory ImagesModel.fromJson(Map<String, dynamic> json) {
    return ImagesModel(image: json['image']);
  }
}
