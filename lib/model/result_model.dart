// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResultHistoryModel {
  String tableno;
  String numberResult;
  String bigsmallResult;
  String colorResult;
  String id;
  ResultHistoryModel({
    required this.tableno,
    required this.numberResult,
    required this.bigsmallResult,
    required this.colorResult,
    required this.id,
  });
}

class ResultModel {
  int zero;
  int one;
  int two;
  int three;
  int four;
  int five;
  int six;
  int seven;
  int eight;
  int nine;
  int big;
  int small;
  int g;
  int v;
  int r;
  ResultModel({
    required this.zero,
    required this.one,
    required this.two,
    required this.three,
    required this.four,
    required this.five,
    required this.six,
    required this.seven,
    required this.eight,
    required this.nine,
    required this.big,
    required this.small,
    required this.g,
    required this.v,
    required this.r,
  });

  factory ResultModel.fromMap(Map<dynamic, dynamic> map) {
    return ResultModel(
      zero: (map["0"] ?? 0) as int,
      one: (map["1"] ?? 0) as int,
      two: (map["2"] ?? 0) as int,
      three: (map["3"] ?? 0) as int,
      four: (map["4"] ?? 0) as int,
      five: (map["5"] ?? 0) as int,
      six: (map["6"] ?? 0) as int,
      seven: (map["7"] ?? 0) as int,
      eight: (map["8"] ?? 0) as int,
      nine: (map["9"] ?? 0) as int,
      big: (map["B"] ?? 0) as int,
      small: (map["S"] ?? 0) as int,
      g: (map["G"] ?? 0) as int,
      v: (map["R"] ?? 0) as int,
      r: (map["V"] ?? 0) as int,
    );
  }
}
