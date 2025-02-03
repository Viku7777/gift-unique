// ignore_for_file: unused_fiel
import 'package:url_launcher/url_launcher.dart';
import '../../../../export_widget.dart';
import 'dart:html' as html;

class BottomWidgetView extends StatelessWidget {
  BottomWidgetView({super.key});

  final RxBool _isUsefulLink = RxBool(true);
  final RxBool _isContactLink = RxBool(true);
  var adminController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Do you want to be amount the first to know about sale time?",
          style: styleSheet.TEXT_CONDENSED.FS_REGULAR_18,
          textAlign: TextAlign.center,
        ).paddingSymmetric(horizontal: styleSheet.SPACING.extraLarge),
        styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
        CustomTextfieldView(
          hintText: "Enter your email here",
        ).paddingSymmetric(horizontal: styleSheet.SPACING.large),
        styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
        Container(
          color: styleSheet.COLORS.SECONDARY,
          child: Obx(() => Column(
                children: [
                  styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
                  Image.asset(
                    AppConfig.appLogo,
                    width: styleSheet.SPACING.widthsmall,
                  ),
                  // Useful Links Start Form Here
                  styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          if (_isUsefulLink.value) {
                            _isUsefulLink(false);
                          } else {
                            _isUsefulLink(true);
                          }
                        },
                        child: Text(
                          "USEFUL LINKS",
                          style: styleSheet.TEXT_CONDENSED.FS_SEMI_BOLD_20
                              .copyWith(color: styleSheet.COLORS.BLACK_COLOR),
                        ),
                      ),
                      Icon(
                          _isUsefulLink.value == false
                              ? Icons.keyboard_arrow_down_rounded
                              : Icons.keyboard_arrow_up_rounded,
                          color: styleSheet.COLORS.BLACK_COLOR),
                    ],
                  ),

                  if (_isUsefulLink.value)
                    Column(
                      children: [
                        styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
                        CustomTxtBtnView(
                            txt: "Privacy Policy",
                            onTap: () async {
                              html.window
                                  .open("https://shorturl.at/LtbC8", "_blank");
                            }),
                        CustomTxtBtnView(
                            txt: "Terms & Conditions",
                            onTap: () async {
                              html.window
                                  .open("https://shorturl.at/LtbC8", "_blank");
                            }),
                      ],
                    ),

                  // Contact Links Start Form Here
                  styleSheet.SPACING.addHeight(styleSheet.SPACING.large),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          if (_isContactLink.value) {
                            _isContactLink(false);
                          } else {
                            _isContactLink(true);
                          }
                        },
                        child: Text(
                          "CONTACTS LINKS",
                          style: styleSheet.TEXT_CONDENSED.FS_SEMI_BOLD_20
                              .copyWith(color: styleSheet.COLORS.BLACK_COLOR),
                        ),
                      ),
                      Icon(
                          _isContactLink.value == false
                              ? Icons.keyboard_arrow_down_rounded
                              : Icons.keyboard_arrow_up_rounded,
                          color: styleSheet.COLORS.BLACK_COLOR),
                    ],
                  ),

                  if (_isContactLink.value)
                    Column(
                      children: [
                        styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
                        CustomTxtBtnView(
                            txt:
                                "Phone: +91${adminController.admindata.number}",
                            onTap: () {}),
                        CustomTxtBtnView(
                            txt: "Email: LoveGifts@gmail.com", onTap: () {}),
                        CustomTxtBtnView(
                            txt: "Address: 461, Central Avenue, Nagpur (MH)",
                            onTap: () {}),
                      ],
                    ),
                  styleSheet.SPACING.addHeight(styleSheet.SPACING.large),

                  Container(
                    height: 25,
                    color: styleSheet.COLORS.BLACK_COLOR,
                  )
                ],
              )),
        ),

        // styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
      ],
    );
  }
}
