import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nike_shoe_store/models/product.dart';
import 'package:nike_shoe_store/models/user.dart';

class BuyItemCard extends StatefulWidget {
  User user;
  final Product product;

  BuyItemCard({@required this.product, this.user}) : assert(product != null);

  @override
  _BuyItemCardState createState() => _BuyItemCardState();
}

class _BuyItemCardState extends State<BuyItemCard> {
  bool showCard = true;
  int selectSizeIndex = -1;

  void onSizeButtonClicked(int index) {
    setState(() {
      selectSizeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 100),
        transitionBuilder: (Widget child, Animation<double> animation) =>
            ScaleTransition(
              alignment: Alignment.topCenter,
              scale: animation,
              child: child,
            ),
        child: showCard
            ? Card(
                color: Color.fromRGBO(245, 245, 245, 1),
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 16, 30, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image(
                              fit: BoxFit.cover,
                              width: 150,
                              height: 100,
                              image: AssetImage("assets/Product_images/" +
                                  widget.product.name +
                                  "/1.jpg")),
                          Container(
                            child: Text(
                              widget.product.name +
                                  "\nRs " +
                                  widget.product.price.toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800),
                            ),
                            width: 100,
                          )
                        ],
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Text(
                        "Select Size",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w800),
                      ),
                      selectShoeSize(widget.product.size, selectSizeIndex,
                          onSizeButtonClicked),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            if (selectSizeIndex != -1) {
                              widget.user.cart.add([
                                widget.product,
                                widget.product.size[selectSizeIndex]
                              ]);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text("Product Added To Cart")));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.red,
                                      content:
                                          Text("Please Select Shoe Size")));
                            }
                            showCard = false;
                          });
                        },
                        backgroundColor: Colors.black87,
                        child: Icon(Icons.shopping_cart_outlined),
                      )
                    ],
                  ),
                ),
              )
            : addCartAnim(product: widget.product));
  }
}

class addCartAnim extends StatefulWidget {
  final Product product;

  addCartAnim({@required this.product}) : assert(product != null);
  @override
  _addCartAnimState createState() => _addCartAnimState();
}

class _addCartAnimState extends State<addCartAnim>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 1500), vsync: this)
          ..forward();
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0.0, 4),
    ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 1, curve: Curves.fastOutSlowIn)));
    _sizeAnimation = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 1, curve: Curves.fastOutSlowIn)))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) Navigator.of(context).pop();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SlideTransition(
            position: _offsetAnimation,
            child: ScaleTransition(
              scale: _sizeAnimation,
              child: FloatingActionButton(
                onPressed: () {},
                child: CircleAvatar(
                  backgroundColor: Color.fromRGBO(245, 245, 245, 1),
                  child: Image(
                      fit: BoxFit.cover,
                      width: 150,
                      height: 100,
                      image: AssetImage("assets/Product_images/" +
                          widget.product.name +
                          "/1.jpg")),
                ),
                backgroundColor: Color.fromRGBO(245, 245, 245, 1),
              ),
            ),
          ),
          FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.black87,
              child: Icon(Icons.shopping_cart_outlined))
        ],
      ),
    );
  }
}

class selectShoeSize extends StatelessWidget {
  List<double> size;
  int isSelected;
  Function onPressed;
  selectShoeSize(this.size, this.isSelected, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
          size.length,
          (index) => OutlinedButton(
                child: Text(
                  "US " + size[index].toString(),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87),
                ),
                onPressed: () {
                  onPressed(index);
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  side: MaterialStateProperty.all(BorderSide(
                      color: (index == isSelected)
                          ? Colors.black87
                          : Color.fromRGBO(0, 0, 0, 0),
                      width: 3)),
                ),
              )),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}
