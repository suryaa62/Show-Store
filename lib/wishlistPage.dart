import 'package:flutter/material.dart';
import 'package:nike_shoe_store/models/product.dart';
import 'package:nike_shoe_store/productpage.dart';
import 'models/user.dart';
import 'customWidgets/shoeCard.dart';

class WishlistPage extends StatefulWidget {
  Set<Product> wishlist;
  Function onHeartClicked;
  User user;

  WishlistPage(this.user, this.wishlist, this.onHeartClicked);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 1000), vsync: this)
          ..forward();
  }

  Animation<Offset> itemAnimOffset(int index) {
    return Tween<Offset>(
      begin: Offset(2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(index / widget.wishlist.length, 1,
            curve: Curves.fastOutSlowIn)));
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Widget empty = Container(
      color: Colors.black87,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.list_alt_rounded,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            "Your Wishlist Is Empty",
            style: TextStyle(color: Colors.grey, fontSize: 20),
          )
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return (widget.user.wishlist.isNotEmpty)
        ? Container(
            decoration: BoxDecoration(
              color: Colors.black87,
            ),
            padding: EdgeInsets.all(24),
            child: ListView.builder(
                itemCount: widget.wishlist.length,
                itemBuilder: (BuildContext context, int index) {
                  return SlideTransition(
                    position: itemAnimOffset(index),
                    child: Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        widget.onHeartClicked(widget.wishlist.elementAt(index));
                      },
                      background: dismissBackground(),
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            // border: Border.all(color: Colors.red),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage(
                                        widget.wishlist.elementAt(index),
                                        widget.user,
                                        widget.onHeartClicked)));
                          },
                          tileColor: Color.fromRGBO(245, 245, 245, 1),
                          trailing: IconButton(
                              icon: Icon(
                                Icons.favorite_outlined,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                widget.onHeartClicked(
                                    widget.wishlist.elementAt(index));
                              }),
                          title: Text(widget.wishlist.elementAt(index).name),
                          subtitle: Text("Rs " +
                              widget.wishlist
                                  .elementAt(index)
                                  .price
                                  .toString()),
                          leading: Hero(
                            tag: widget.wishlist.elementAt(index).name,
                            child: Image(
                              width: 70,
                              fit: BoxFit.cover,
                              image: AssetImage("assets/Product_images/" +
                                  widget.wishlist.elementAt(index).name +
                                  "/1.jpg"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }))
        : empty;
  }
}

// ignore: camel_case_types
class dismissBackground extends StatefulWidget {
  @override
  _dismissBackgroundState createState() => _dismissBackgroundState();
}

class _dismissBackgroundState extends State<dismissBackground> {
  List<Color> colors = [Colors.red, Colors.black12];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () => 1).then((value) {
      setState(() {
        colors = colors.reversed.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 1000),
        onEnd: () {
          setState(() {
            // print("called 1");
            colors = colors.reversed.toList();
          });
        },
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: colors),
            // border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(16))));
  }
}
