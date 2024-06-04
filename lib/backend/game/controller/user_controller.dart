import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color_game/backend/firebase_repositroy/firebase_repository.dart';
import 'package:color_game/helper/app_configure.dart';
import 'package:color_game/model/usermodel.dart';
import 'package:flutter/foundation.dart';
import 'package:velocity_x/velocity_x.dart';

class UserController extends ChangeNotifier {
  FirebaseRepository firebaseRepository = FirebaseRepository();
  // bool isNewUpdateFound = AppConfig().currentAppVersion == AppConfig.appVersion;
  updateFcmToken(String token) async {
    currentuser!.fcmToken = token;
    await fcloud
        .collection("users")
        .doc(AppConfig.useruid)
        .update({"fcmToken": token});
  }

  UserModel? currentuser;
  int depositBalance = 0;
  updateUser(UserModel userdata) async {
    currentuser = userdata;
    AppConfig.useruid = userdata.uid!;
    depositBalance = userdata.depositBalance!;
    AppConfig.referByUID = userdata.userReferByexist ?? "";
    notifyListeners();
  }

  updateuserbalanceFromFirebase({String uid = ""}) async {
    DocumentSnapshot data = await FirebaseRepository()
        .getDocumentData("users", uid.isEmptyOrNull ? AppConfig.useruid : uid);
    UserModel user = UserModel.fromMap(data.data() as Map<String, dynamic>);
    currentuser = user;
    AppConfig.useruid = user.uid!;
    AppConfig.referByUID = user.userReferByexist ?? "";
    depositBalance = user.depositBalance!;
    notifyListeners();
  }

  updateWalletBalance(int balance) async {
    depositBalance += balance;
    notifyListeners();
    await fcloud
        .collection("users")
        .doc(AppConfig.useruid)
        .update({"depositBalance": FieldValue.increment(balance)});
  }
}

showError(String error) {
  if (kDebugMode) {
    print(
        " ---------------------------------------------------- $error  ----------------------------------------------------");
  }
}
