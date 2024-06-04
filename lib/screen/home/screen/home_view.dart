// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color_game/backend/firebase_repositroy/firebase_repository.dart';
import 'package:color_game/backend/game/controller/game_controller.dart';
import 'package:color_game/backend/game/controller/user_controller.dart';
import 'package:color_game/backend/notification/notification_services.dart';
import 'package:color_game/helper/app_configure.dart';
import 'package:color_game/helper/colors.dart';
import 'package:color_game/helper/textstyle.dart';
import 'package:color_game/screen/auth/login.dart';
import 'package:color_game/screen/home/components/game_history.dart';
import 'package:color_game/screen/home/components/investment_tiel.dart';
import 'package:color_game/screen/home/components/my_history.dart';
import 'package:color_game/screen/home/screen/app_update.dart';
import 'package:color_game/screen/home/screen/splash_view.dart';
import 'package:color_game/screen/wallet/deposit_view.dart';
import 'package:color_game/screen/wallet/withdraw_view.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeView extends StatefulWidget {
  bool isSavedUser;
  String uid;
  HomeView({super.key, this.isSavedUser = false, this.uid = ""});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedHistory = "G";
  String news = "";
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var gamecontroller = Provider.of<GameController>(context, listen: false);

    return ResponsiveScreens(
        bgclr: Colors.white,
        child: Scaffold(
            backgroundColor: const Color(0xfff7f8fe),
            appBar: AppBar(
              backgroundColor: AppColor.primaryColor,
              title: const Text("VIP WIN",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () => Share.share(
                        'Checkout this amazing game and earn upto 10% loss commission of your friends your refer code is : ${Provider.of<UserController>(context, listen: false).currentuser!.referCode} and download from here : ${AppConfig.applink}'),
                    icon: const Icon(
                      Icons.share,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Are you sure?"),
                            content: const Text("you want to logout?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel")),
                              ElevatedButton(
                                  onPressed: () async {
                                    gamecontroller.timer!.cancel();
                                    await FirebaseRepository().updateData(
                                        fcloud
                                            .collection("users")
                                            .doc(AppConfig.useruid),
                                        {"fcmToken": ""});
                                    await FirebaseAuth.instance.signOut();

                                    var sp =
                                        await SharedPreferences.getInstance();
                                    sp
                                        .remove(AppConfig().offlineUserDatakey)
                                        .then((value) => Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  const LogInScreen(),
                                            )))
                                        .then((value) => exit(0));
                                  },
                                  child: const Text("Logout"))
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    )),
              ],
            ),
            body: Consumer<UserController>(
              builder: (context, value, child) => value.currentuser == null ||
                      Provider.of<GameController>(context).tableNo == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                        15.h.heightBox,
                        const Text(
                          "Please Wait",
                          style: GetTextTheme.fs_16_Bold,
                        )
                      ],
                    )
                  : AppConfig().currentAppVersion != AppConfig.appVersion
                      ? const AppUpdateView()
                      : SingleChildScrollView(
                          child: Stack(
                            children: [
                              Container(
                                height: 300.h,
                                decoration: const BoxDecoration(
                                  color: AppColor.primaryColor,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    bottomRight: Radius.circular(50),
                                  ),
                                ),
                              ),
                              Positioned(
                                  child: Column(
                                children: [
                                  //wallet section
                                  Container(
                                    height: 170.h,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "$rupeSign${value.depositBalance}.00",
                                                    style:
                                                        GetTextTheme.fs_20_Bold,
                                                  ),
                                                  IconButton(
                                                      onPressed: () async {
                                                        value
                                                            .updateuserbalanceFromFirebase();
                                                      },
                                                      icon: const Icon(
                                                          Icons.refresh))
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                      Icons
                                                          .account_balance_wallet_rounded,
                                                      color:
                                                          AppColor.primaryColor,
                                                      size: 23),
                                                  5.w.widthBox,
                                                  const Text(
                                                    "Wallet Balance",
                                                    style:
                                                        GetTextTheme.fs_14_Bold,
                                                  ),
                                                  10.w.widthBox,
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: .005.sw),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              fixedSize: Size(
                                                                  double
                                                                      .maxFinite,
                                                                  45.h),
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xfff2bd12)),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .push(
                                                                MaterialPageRoute(
                                                          builder: (context) =>
                                                              const WithdrawView(),
                                                        ));
                                                      },
                                                      child:
                                                          const Text("Withdraw",
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white))),
                                                ),
                                                .02.sh.widthBox,
                                                Expanded(
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .push(
                                                                MaterialPageRoute(
                                                          builder: (context) =>
                                                              const DepositView(),
                                                        ));
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              fixedSize: Size(
                                                                  double
                                                                      .maxFinite,
                                                                  45.h),
                                                              backgroundColor:
                                                                  AppColor
                                                                      .primaryColor),
                                                      child: Text(
                                                        "Deposit",
                                                        style: GetTextTheme
                                                            .fs_18_Bold
                                                            .copyWith(
                                                                color: Colors
                                                                    .white),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                  ),
                                  // news section,
                                  2.h.heightBox,
                                  Container(
                                    height: 50.h,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: .005.sw,
                                    ).copyWith(top: 7.h, bottom: 7.h),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Row(
                                      children: [
                                        .01.sw.widthBox,
                                        const Icon(
                                          Icons.audiotrack_rounded,
                                          color: AppColor.primaryColor,
                                        ),
                                        .01.sw.widthBox,
                                        Expanded(
                                          child: VxMarquee(
                                              text: news,
                                              textStyle:
                                                  GetTextTheme.fs_14_Medium),
                                        )
                                      ],
                                    ),
                                  ),
                                  // timing section,
                                  2.h.heightBox,
                                  Container(
                                      height: 90.h,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: .005.sw,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 15,
                                              spreadRadius: .3,
                                              blurStyle: BlurStyle.inner)
                                        ],
                                        // border: Border.all(color: Colors.black)
                                      ),
                                      child: Row(
                                        children: List.generate(4, (index) {
                                          List timer = [1, 3, 5, 10];
                                          return Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: index == 0
                                                    ? const Color(0xffffc1c0)
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.timer_sharp,
                                                    size: 30.r,
                                                    color:
                                                        AppColor.primaryColor,
                                                  ),
                                                  3.h.heightBox,
                                                  Text(
                                                    "Win Go \n ${timer[index]}Min",
                                                    style: GetTextTheme
                                                        .fs_12_Medium,
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                      )),
                                  // table no
                                  7.h.heightBox,
                                  Container(
                                    height: 100.h,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: .005.sw, vertical: 5.h),
                                    decoration: const BoxDecoration(
                                        color: AppColor.primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                          alignment: Alignment.center,
                                          child: Text("Win Go \n 1 Min",
                                              style: GetTextTheme.fs_18_Bold
                                                  .copyWith(
                                                      color: Colors.white)),
                                        )),
                                        const DottedLine(
                                          direction: Axis.vertical,
                                          lineThickness: 1.0,
                                          dashLength: 4.0,
                                          dashColor: Colors.white,
                                          dashGapLength: 6.0,
                                          dashGapColor: Colors.transparent,
                                        ),
                                        Expanded(
                                            child: Container(
                                          margin:
                                              EdgeInsets.only(right: .005.sw),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              const Text(
                                                "Time remaining",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                              Consumer<GameController>(
                                                builder:
                                                    (context, value, child) =>
                                                        Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    "0",
                                                    "0",
                                                    ":",
                                                    value.second == 10
                                                        ? "1"
                                                        : value.second > 10
                                                            ? value.second
                                                                .toString()
                                                                .split("")[0]
                                                            : "0",
                                                    value.second == 10
                                                        ? "0"
                                                        : value.second > 10
                                                            ? value.second
                                                                .toString()
                                                                .split("")[1]
                                                            : value.second
                                                                .toString()
                                                                .split("")[0],
                                                  ]
                                                      .map((e) => Container(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            margin:
                                                                EdgeInsets.all(
                                                                    3),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.r)),
                                                            child: Text(e,
                                                                style: GetTextTheme
                                                                    .fs_16_Bold
                                                                    .copyWith(
                                                                        color: AppColor
                                                                            .primaryColor)),
                                                          ))
                                                      .toList(),
                                                ),
                                              ),
                                              Consumer<GameController>(
                                                builder:
                                                    (context, value, child) =>
                                                        Text(
                                                  value.tableNo.toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                      ],
                                    ),
                                  ),
                                  4.h.heightBox,

                                  //place beat
                                  Container(
                                    height: 250.h,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: .005.sw, vertical: 5.h),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 5,
                                              spreadRadius: 1,
                                              blurStyle: BlurStyle.inner)
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Column(
                                      children: [
                                        // color section
                                        Row(
                                          children: [
                                            {
                                              "Name": "Green",
                                              "Color": const Color(0xff41ad72)
                                            },
                                            {
                                              "Name": "Violet",
                                              "Color": const Color(0xffc47aff)
                                            },
                                            {
                                              "Name": "Red",
                                              "Color": AppColor.primaryColor
                                            }
                                          ]
                                              .map((Map e) => Expanded(
                                                    child: InkWell(
                                                      onTap: () =>
                                                          investmentBottomTable(
                                                              context,
                                                              e["Color"],
                                                              e["Name"]),
                                                      child: Container(
                                                        height: 45.h,
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    .005.sw,
                                                                vertical: 10.h),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius: e[
                                                                            "Name"] ==
                                                                        "Green"
                                                                    ? BorderRadius.only(
                                                                        topRight:
                                                                            Radius.circular(15
                                                                                .r),
                                                                        bottomLeft:
                                                                            Radius.circular(15
                                                                                .r))
                                                                    : e["Name"] ==
                                                                            "Red"
                                                                        ? BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(15.r),
                                                                            bottomRight: Radius.circular(15.r))
                                                                        : BorderRadius.circular(15.r),
                                                                color: e["Color"]),
                                                        child: Text(
                                                          e["Name"],
                                                          style: GetTextTheme
                                                              .fs_18_Medium
                                                              .copyWith(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                        ),

                                        // number section
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              children: [
                                                {
                                                  "Name": "0",
                                                  "Color": AppColor.violetColor,
                                                },
                                                {
                                                  "Name": "1",
                                                  "Color": AppColor.greenColor,
                                                },
                                                {
                                                  "Name": "2",
                                                  "Color":
                                                      AppColor.primaryColor,
                                                },
                                                {
                                                  "Name": "3",
                                                  "Color": AppColor.greenColor,
                                                },
                                                {
                                                  "Name": "4",
                                                  "Color":
                                                      AppColor.primaryColor,
                                                },
                                              ]
                                                  .map((Map e) => Expanded(
                                                        child: InkWell(
                                                          onTap: () =>
                                                              investmentBottomTable(
                                                                  context,
                                                                  e["Color"],
                                                                  e["Name"]),
                                                          child: Container(
                                                            height: 52.h,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: e[
                                                                        "Color"],
                                                                    shape: BoxShape
                                                                        .circle),
                                                            child: Text(
                                                                e["Name"],
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        17)),
                                                          ),
                                                        ),
                                                      ))
                                                  .toList(),
                                            ),
                                            Row(
                                              children: [
                                                {
                                                  "Name": "5",
                                                  "Color": AppColor.greenColor,
                                                },
                                                {
                                                  "Name": "6",
                                                  "Color":
                                                      AppColor.primaryColor,
                                                },
                                                {
                                                  "Name": "7",
                                                  "Color": AppColor.greenColor,
                                                },
                                                {
                                                  "Name": "8",
                                                  "Color":
                                                      AppColor.primaryColor,
                                                },
                                                {
                                                  "Name": "9",
                                                  "Color": AppColor.greenColor,
                                                },
                                              ]
                                                  .map((Map e) => Expanded(
                                                        child: InkWell(
                                                          onTap: () =>
                                                              investmentBottomTable(
                                                                  context,
                                                                  e["Color"],
                                                                  e["Name"]),
                                                          child: Container(
                                                            height: 52.h,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: e[
                                                                        "Color"],
                                                                    shape: BoxShape
                                                                        .circle),
                                                            child: Text(
                                                                e["Name"],
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        17)),
                                                          ),
                                                        ),
                                                      ))
                                                  .toList(),
                                            )
                                          ],
                                        )),

                                        // big small section
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: .005.sw,
                                              vertical: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: InkWell(
                                                onTap: () =>
                                                    investmentBottomTable(
                                                        context,
                                                        const Color(0xffffa82e),
                                                        "Big"),
                                                child: Container(
                                                  height: 45.h,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(20),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    20)),
                                                    color: Color(0xffffa82e),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text("Big",
                                                      style: GetTextTheme
                                                          .fs_24_Medium
                                                          .copyWith(
                                                              color: Colors
                                                                  .white)),
                                                ),
                                              )),
                                              Expanded(
                                                  child: InkWell(
                                                onTap: () =>
                                                    investmentBottomTable(
                                                        context,
                                                        const Color(0xff6ea7f4),
                                                        "Small"),
                                                child: Container(
                                                  height: 45.h,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(20),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    20)),
                                                    color: Color(0xff6ea7f4),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text("Small",
                                                      style: GetTextTheme
                                                          .fs_24_Medium
                                                          .copyWith(
                                                              color: Colors
                                                                  .white)),
                                                ),
                                              )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // history section
                                  10.h.heightBox,
                                  Row(
                                    children: [
                                      "Game history",
                                      "My history",
                                    ]
                                        .map(
                                          (e) => Expanded(
                                              child: InkWell(
                                            radius: 0,
                                            onTap: () {
                                              setState(() {
                                                selectedHistory = e;
                                              });
                                            },
                                            child: Container(
                                                height: 45.h,
                                                margin:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.r),
                                                    color: e.startsWith(
                                                            selectedHistory)
                                                        ? AppColor.primaryColor
                                                        : Colors.grey.shade300),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  e,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: e.startsWith(
                                                              selectedHistory)
                                                          ? Colors.white
                                                          : Colors.black),
                                                )),
                                          )),
                                        )
                                        .toList(),
                                  ),
                                  10.h.heightBox,
                                  selectedHistory.startsWith("G")
                                      ? const GameHistoryView()
                                      : const MyHistory()
                                ],
                              )),
                              Consumer<GameController>(
                                builder: (context, value, child) => value
                                        .loading
                                    ? Container(
                                        height: 1.sh,
                                        padding: EdgeInsets.only(top: .35.sh),
                                        alignment: Alignment.topCenter,
                                        color: Colors.black54,
                                        child: const CircularProgressIndicator(
                                          color: AppColor.primaryColor,
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                            ],
                          ),
                        ),
            )));
  }

  getData() async {
    var gameController = Provider.of<GameController>(context, listen: false);
    var usercontroller = Provider.of<UserController>(context, listen: false);
    if (gameController.timer == null) {
      if (widget.isSavedUser) {
        await usercontroller.updateuserbalanceFromFirebase(uid: widget.uid);
      }
      DocumentSnapshot data =
          await FirebaseRepository().getDocumentData("appconfigure", "details");
      AppConfig.appVersion = data.get("currnetVersion");
      gameController.startTimer(context);
      AppConfig.sizeWin = data.get("sizeWin");
      news = data.get("news");
      AppConfig.colorWin = data.get("colorWin");
      AppConfig.commission = data.get("commission");
      AppConfig.numberWin = data.get("numberWin");
      AppConfig.referCommision = data.get("referCommision");
      AppConfig.applink = data.get("app_link");
      NotificationServices().requestPermision(context);
      showError(AppConfig.appVersion);
      if (mounted) {
        setState(() {});
      }
    }
  }
}
