// ignore_for_file: use_build_context_synchronously

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color_game/backend/auth/repository.dart';
import 'package:color_game/backend/firebase_repositroy/firebase_repository.dart';
import 'package:color_game/backend/game/controller/user_controller.dart';
import 'package:color_game/backend/offline_data/offline_Data.dart';
import 'package:color_game/helper/app_configure.dart';
import 'package:color_game/helper/widgets.dart';
import 'package:color_game/model/usermodel.dart';
import 'package:color_game/screen/home/screen/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthController extends ChangeNotifier {
  bool loading = false;
  updateLoading() {
    loading = !loading;
    notifyListeners();
  }

  FirebaseRepository firebaseRepository = FirebaseRepository();
  AuthRepository authRepository = AuthRepository();

  Future<void> signupController(UserModel user, BuildContext context) async {
    updateLoading();
    try {
      UserCredential userCredential =
          await authRepository.createAccount(user.email, user.password);
      user.uid = userCredential.user!.uid;
      await firebaseRepository.putData(
          fcloud.collection("users").doc(user.uid), user.toMap());
      if (user.referby != "not_found") {
        QuerySnapshot snapshot = await fcloud
            .collection("users")
            .where("referCode", isEqualTo: user.referby)
            .get();
        if (snapshot.docs.isNotEmpty) {
          String uid = snapshot.docs.first.get("uid");
          await FirebaseRepository().updateData(
              fcloud.collection("users").doc(user.uid),
              {"userReferByexist": uid});
          AppConfig.referByUID = uid;
        }
      }
      user.depositBalance = 0;
      Provider.of<UserController>(context, listen: false).updateUser(user);
      updateLoading();
      await OfflineData()
          .setOfflineData(AppConfig().offlineUserDatakey, user.uid!)
          .then((value) => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => HomeView(),
              ),
              (route) => false));
    } catch (e) {
      updateLoading();
      AppHelperWidgets.showSnackbar(context, AnimatedSnackBarType.error,
          "Something Went Wrong!!", e.toString());
    }
  }

  Future<void> loginController(
      String email, String password, BuildContext context) async {
    updateLoading();
    try {
      UserCredential userCredential =
          await authRepository.login(email, password);

      DocumentSnapshot data = await firebaseRepository.getDocumentData(
          "users", userCredential.user!.uid);
      UserModel user = UserModel.fromMap(data.data() as Map<String, dynamic>);
      Provider.of<UserController>(context, listen: false).updateUser(user);
      updateLoading();
      await OfflineData()
          .setOfflineData(
              AppConfig().offlineUserDatakey, userCredential.user!.uid)
          .then((value) => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => HomeView(),
              ),
              (route) => false));
    } catch (e) {
      updateLoading();
      AppHelperWidgets.showSnackbar(context, AnimatedSnackBarType.error,
          "Something Went Wrong!!", e.toString());
    }
  }

  Future<void> forgotPassword(String email, BuildContext context) async {
    updateLoading();

    try {
      await authRepository.forgotPassword(email);
      updateLoading();
      AppHelperWidgets.showSnackbar(context, AnimatedSnackBarType.success,
          "Congratulations", "Password reset link sent to Your email");
    } catch (e) {
      updateLoading();
      AppHelperWidgets.showSnackbar(context, AnimatedSnackBarType.error,
          "Something Went Wrong!!", e.toString());
    }
  }
}
