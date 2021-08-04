import 'package:flutter/material.dart';
import 'package:nike_shoe_store/models/product.dart';

class imgCarousel extends StatefulWidget {
  final String productName;

  imgCarousel(@required this.productName) : assert(productName != null);

  @override
  _imgCarouselState createState() => _imgCarouselState();
}

class _imgCarouselState extends State<imgCarousel> {
  final PageController controller = PageController(initialPage: 0);
  int indexCircle = 0;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        indexCircle = controller.page.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            PageView(
              scrollDirection: Axis.horizontal,
              controller: controller,
              children: List.generate(3, (index) {
                return (index == 0)
                    ? Hero(
                        tag: widget.productName,
                        child: Image(
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            image: AssetImage("assets/Product_images/" +
                                widget.productName +
                                "/${index + 1}.jpg")),
                      )
                    : Image(
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        image: AssetImage("assets/Product_images/" +
                            widget.productName +
                            "/${index + 1}.png"));
              }),
            ),
            circleIndex(index: indexCircle),
          ],
        ));
  }
}

class circleIndex extends StatelessWidget {
  final int index;
  const circleIndex({this.index}) : assert(index != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (index == 0)
                  ? Icon(
                      Icons.circle,
                      color: Colors.black87,
                      size: 12,
                    )
                  : Icon(
                      Icons.circle,
                      color: Colors.black38,
                      size: 10,
                    ),
              (index == 1)
                  ? Icon(
                      Icons.circle,
                      color: Colors.black87,
                      size: 12,
                    )
                  : Icon(
                      Icons.circle,
                      color: Colors.black38,
                      size: 10,
                    ),
              (index == 2)
                  ? Icon(
                      Icons.circle,
                      color: Colors.black87,
                      size: 12,
                    )
                  : Icon(
                      Icons.circle,
                      color: Colors.black38,
                      size: 10,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
