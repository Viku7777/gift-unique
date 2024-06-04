// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String name;
  String email;
  String password;
  int? totalwithdraw;
  int? totaldeposit;
  int? depositBalance;
  String? referby;
  String referCode;
  String? fcmToken;
  String? uid;
  String? userReferByexist;
  UserModel({
    required this.name,
    required this.email,
    required this.password,
    this.totalwithdraw,
    this.totaldeposit,
    this.depositBalance,
    this.referby,
    required this.referCode,
    this.fcmToken,
    this.uid,
    this.userReferByexist,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'totalwithdraw': totalwithdraw ?? 0,
      'totaldeposit': totaldeposit ?? 0,
      'depositBalance': depositBalance ?? 0,
      'referby': referby ?? "no_refer",
      'referCode': referCode,
      'fcmToken': fcmToken ?? "",
      "uid": uid ?? "",
      "userReferByexist": userReferByexist ?? "not_updated",
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: (map["name"] ?? '') as String,
      email: (map["email"] ?? '') as String,
      password: (map["password"] ?? '') as String,
      totalwithdraw: (map["totalwithdraw"] ?? 0) as int,
      totaldeposit: (map["totaldeposit"] ?? 0) as int,
      depositBalance: (map["depositBalance"] ?? 0) as int,
      referby: (map["referby"] ?? '') as String,
      referCode: (map["referCode"] ?? '') as String,
      fcmToken: (map["fcmToken"] ?? '') as String,
      uid: (map["uid"] ?? '') as String,
      userReferByexist: (map["userReferByexist"] ?? 'not_updated') as String,
    );
  }
}
