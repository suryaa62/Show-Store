import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nike_shoe_store/customWidgets/imgCarousel.dart';
import 'package:nike_shoe_store/models/product_repositry.dart';
import 'models/product.dart';
import 'customWidgets/buyItemCard.dart';
import 'models/user.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  User user;
  Function onHeartClicked;

  ProductPage(@required this.product, this.user, this.onHeartClicked)
      : assert(product != null);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnim;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400))
          ..forward();
    _offsetAnim = Tween<Offset>(begin: Offset(0.8, 0), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack));
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.black87,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Container(
          padding: EdgeInsets.all(16),
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                alignment: Alignment.topCenter,
                iconSize: 25,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              Icon(
                Icons.sports_handball,
                color: Colors.white,
                size: 30,
              ),
              Icon(
                Icons.search,
                color: Colors.white,
                size: 25,
              )
            ],
          ),
        ));
  }

  Widget _bottomsheet(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(0),
      child: BuyItemCard(
        product: widget.product,
        user: widget.user,
      ),
    );
  }

  Widget productBody(Product product) {
    return Container(
      color: Colors.black87,
      child: ListView(children: [
        imgCarousel(product.name),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 0, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 150,
                child: SlideTransition(
                  position: _offsetAnim,
                  child: Text(
                    product.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              SlideTransition(
                position: _offsetAnim,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 24),
                  child: Text(
                    "Rs " + product.price.toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SlideTransition(
          position: _offsetAnim,
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "AVAILABLE SIZE",
                style: TextStyle(color: Colors.white),
              )),
        ),
        SlideTransition(
          position: _offsetAnim,
          child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 100, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                    product.size.length,
                    (index) => Text(
                          "US " + product.size[index].toString(),
                          style: TextStyle(color: Colors.white),
                        )),
              )),
        ),
        SlideTransition(
          position: _offsetAnim,
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "DESCRIPTION",
                style: TextStyle(color: Colors.white),
              )),
        ),
        Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              product.description,
              style: TextStyle(color: Colors.white),
            )),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: _appBar(context),
      body: productBody(widget.product),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: _bottomsheet,
                    backgroundColor: Color.fromARGB(0, 0, 0, 0),
                  );
                },
                backgroundColor: Colors.black87,
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                )),
            heartButton(
                widget.product,
                widget.user.wishlist.contains(widget.product),
                widget.onHeartClicked)
          ],
        ),
      ),
    );
  }
}

class heartButton extends StatefulWidget {
  Product product;
  bool isHearted;
  Function onHeartClicked;

  heartButton(this.product, this.isHearted, this.onHeartClicked);

  @override
  _heartButtonState createState() => _heartButtonState();
}

class _heartButtonState extends State<heartButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          setState(() {
            widget.onHeartClicked(widget.product);
            widget.isHearted = !widget.isHearted;
          });
        },
        backgroundColor: Colors.black87,
        child: (widget.isHearted)
            ? Icon(
                Icons.favorite,
                color: Colors.red,
              )
            : Icon(Icons.favorite_border));
  }
}
