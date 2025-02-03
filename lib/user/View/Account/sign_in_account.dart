// ignore_for_file: must_be_immutable

import '../../../export_widget.dart';

class SignInAccountView extends StatelessWidget {
  SignInAccountView({super.key});

  var designController = Get.put(DesignController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
          LoginWidgetView(
            ontap: () {
              designController.isLoginView(false);
            },
          ),
          styleSheet.SPACING.addHeight(styleSheet.SPACING.extraLarge),
        ],
      ),
    );
  }
}
