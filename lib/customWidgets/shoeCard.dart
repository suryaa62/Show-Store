import 'package:flutter/material.dart';
import 'package:nike_shoe_store/models/product.dart';
import 'package:nike_shoe_store/models/product_repositry.dart';
import 'package:nike_shoe_store/models/user.dart';
import 'package:nike_shoe_store/productpage.dart';

class shoeCard extends StatefulWidget {
  final Product product;
  User user;
  Function onHeartClicked;

  shoeCard(@required this.product, this.user, this.onHeartClicked)
      : assert(product != null);

  @override
  _shoeCardState createState() => _shoeCardState();
}

class _shoeCardState extends State<shoeCard> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(
                    widget.product, widget.user, widget.onHeartClicked),
              ));
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 16),
          height: constraints.maxWidth,
          child: Card(
            color: Color.fromRGBO(245, 245, 245, 1),
            clipBehavior: Clip.hardEdge,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Hero(
                      tag: widget.product.name + "heart",
                      child: IconButton(
                        icon: (widget.user.wishlist.contains(widget.product))
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.black,
                              ),
                        onPressed: () {
                          widget.onHeartClicked(widget.product);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Hero(
                      tag: widget.product.name,
                      child: Image(
                        image: AssetImage("assets/Product_images/" +
                            widget.product.name +
                            "/1.jpg"),
                        fit: BoxFit.fitWidth,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                    title: Text(
                      widget.product.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    subtitle: Text(
                      "Size: " + widget.product.size.join(", "),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    trailing: Text(
                      "Rs " + widget.product.price.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
