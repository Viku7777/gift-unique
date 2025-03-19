import 'package:color_game/user/View/Dashboard/Widgets/new_product_cart.dart';
import 'package:color_game/user/View/Dashboard/new_product_details_view.dart';
import 'package:color_game/user/View/Dashboard/product_details_view.dart';
import 'package:color_game/export_widget.dart';

//
class CustomerPuchasedView extends StatefulWidget {
  const CustomerPuchasedView({super.key});

  @override
  State<CustomerPuchasedView> createState() => _CustomerPuchasedViewState();
}

class _CustomerPuchasedViewState extends State<CustomerPuchasedView> {
  var productController = Get.find<ProductController>();

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: false,
        aspectRatio: 1.2,
        viewportFraction: 0.7,
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      items: productController.allProducts.map((pr) {
        return GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewProductDetailsView(productModel: pr),
          )),
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: styleSheet.SPACING.small,
                  vertical: styleSheet.SPACING.small),
              child: NewProductCardView(product: pr)),
        );
      }).toList(),
    );
  }
}

// 