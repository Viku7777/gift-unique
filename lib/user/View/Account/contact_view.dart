import 'package:flutter/material.dart';
import 'package:color_game/export_widget.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    var adminController = Get.find<ProductController>();

    return Scaffold(
      appBar: customAppbar(),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: [
              Container(
                width: Get.width,
                clipBehavior: Clip.antiAlias,
                height: 220,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(styleSheet.SHAPES.RADIUS_MEDIUM)),
                child: Image.network(
                  "https://www.google.com/maps/vt/data=_Psxh3HuWEnSEtIYjgxwwL_Assh0wdZuTbx5h-c473_Muk5bJo3U6cEJZSS2oadA0oCKSVGt1N2kfLl8W4OhAQstQI74fbswJ5Sor2BfjIUOPyYnIReml3GIJ5QlX2xr9yEs-5vAjWHSqEMX9CwO6Xs8GgoskR3J9vphBjBMDt30awMcjyTfHqP73MaszPNBIxLCGt9mok2oolfHApIkC6WvwoZ36R0cjamxZO6F40vqnBk7zI6xCAPxFmBy0PAfVtxdA_yYL63957ZSLe_5w-atF3e9C-5NnyZTYji6b7sOh5y2wPDAOA",
                  fit: BoxFit.cover,
                ),
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.extraLarge),
              SvgPicture.asset(
                styleSheet.ICONS.CALL_SVG,
                height: 40,
                width: 40,
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
              Text(
                "Phone",
                style: styleSheet.TEXT_Rubik.FS_MEDIUM_15,
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
              Text(
                "+91 ${adminController.admindata.number}",
                style: styleSheet.TEXT_Rubik.FS_REGULAR_14,
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
              SvgPicture.asset(
                styleSheet.ICONS.EMAIL_SVG,
                height: 40,
                width: 40,
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
              Text(
                "Email",
                style: styleSheet.TEXT_Rubik.FS_MEDIUM_15,
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
              Text(
                "LoveGifts@gmail.com",
                style: styleSheet.TEXT_Rubik.FS_REGULAR_14,
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
              SvgPicture.asset(
                styleSheet.ICONS.LOCATION_SVG,
                height: 40,
                width: 40,
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
              Text(
                "Location",
                style: styleSheet.TEXT_Rubik.FS_MEDIUM_15,
              ),
              styleSheet.SPACING.addHeight(styleSheet.SPACING.small),
              Text(
                "Address: 461, Central Avenue, Nagpur (MH)",
                style: styleSheet.TEXT_Rubik.FS_REGULAR_14,
              ),
            ],
          ).paddingAll(styleSheet.SPACING.medium),
          styleSheet.SPACING.addHeight(styleSheet.SPACING.extraLarge),

          // BOTTOM WIDGET START FROM HERE
          BottomWidgetView()
        ],
      ),
    );
  }
}
