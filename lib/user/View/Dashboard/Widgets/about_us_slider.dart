
import '../../../../export_widget.dart';

class AboutUsSliderView extends StatefulWidget {
  const AboutUsSliderView({super.key});

  @override
  State<AboutUsSliderView> createState() => _AboutUsSliderViewState();
}

class _AboutUsSliderViewState extends State<AboutUsSliderView> {
  int _currentIndex = 0;

  // List of review data (could be dynamic or fetched from a backend).
  final List<Map<String, String>> reviews = [
    {
      'name': 'Mohit Soni',
      'title': 'Civil Engineer',
      'image':
          'https://cdn.shopify.com/s/files/1/0484/7940/4212/files/mohamad-khosravi-Ll6ggwPpKIo-unsplash_480x480.jpg?v=1619363028',
      'review':
          'For the quality of the gifts, I was surprised at how affordable everything was. Giftz Unique offers the perfect balance of quality and price – I found exactly...',
      'location': 'Raipur, India'
    },
    {
      'name': 'Priya Sharma',
      'title': 'Software Engineer',
      'image':
          'https://avatars.mds.yandex.net/get-shedevrum/12961523/0e487339e92711eea8167acfd41307a6/orig',
      'review':
          'Giftz Unique truly delivers! The products were of excellent quality, and the price was unbeatable. Couldn’t be happier with my purchase.',
      'location': 'Mumbai, India'
    },
    {
      'name': 'Rahul Verma',
      'title': 'Designer',
      'image':
          'https://plus.unsplash.com/premium_photo-1661346366791-8e30b8b1e05a?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Z2VudGxlbWFufGVufDB8fDB8fHww',
      'review':
          'Amazing gifts for every occasion. The prices are surprisingly low for such premium quality items!',
      'location': 'Delhi, India'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        styleSheet.SPACING.addHeight(styleSheet.SPACING.large),
        Text(
          "What People Say About Us",
          style: styleSheet.TEXT_CONDENSED.FS_MEDIUM_26,
        ),
        styleSheet.SPACING.addHeight(styleSheet.SPACING.large),

        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: false,
            aspectRatio: 1.1,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: reviews.map((review) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Circular Image
                CircleAvatar(
                  radius: 75,
                  backgroundImage: NetworkImage(review['image']!),
                ),
                styleSheet.SPACING.addHeight(styleSheet.SPACING.small),

                // Name & Title
                Text(
                  review['name']!,
                  style: styleSheet.TEXT_Rubik.FS_MEDIUM_16,
                ),
                Text(
                  review['title']!,
                  style: styleSheet.TEXT_Rubik.FS_REGULAR_14.copyWith(
                      fontStyle: FontStyle.italic,
                      color: styleSheet.COLORS.TXT_GREY),
                ),
                styleSheet.SPACING.addHeight(styleSheet.SPACING.small),

                // Review Text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    review['review']!,
                    textAlign: TextAlign.center,
                    style: styleSheet.TEXT_Rubik.FS_REGULAR_14.copyWith(
                      wordSpacing: 6,
                    ),
                  ),
                ),
                styleSheet.SPACING.addHeight(styleSheet.SPACING.small),

                // Rating
                const Icon(Icons.star, color: Colors.amber),
                styleSheet.SPACING.addHeight(styleSheet.SPACING.small),

                // Location
                Text(
                  review['location']!,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            );
          }).toList(),
        ),

        styleSheet.SPACING.addHeight(styleSheet.SPACING.small),

        // Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: reviews.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => setState(() {
                _currentIndex = entry.key;
              }),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key
                      ? Colors.black
                      : Colors.grey.withOpacity(0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
