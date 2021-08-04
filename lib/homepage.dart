import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'customWidgets/shoeCard.dart';
import 'models/product_repositry.dart';
import 'models/product.dart';
import 'models/user.dart';
import 'wishlistPage.dart';
import 'billpage.dart';

List<Product> products = ProductsRepository.loadProducts();

class Homepage extends StatefulWidget {
  User user = User();
  Homepage(this.user);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  PageController _pageController;
  List<String> toolbarText = ['Your Bill', 'Products', 'Wishlist'];
  int currentPage = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 1)..addListener(_listner);
  }

  _listner() {
    if (_pageController.page.round() != currentPage) {
      currentPage = _pageController.page.round();
      setState(() {});
    }
  }

  void onHeartClicked(Product product) {
    setState(() {
      if (widget.user.wishlist.contains(product))
        widget.user.wishlist.remove(product);
      else
        widget.user.wishlist.add(product);
    });
  }

  Widget _appBar() {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: Size(double.infinity, 30),
        child: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                toolbarText[currentPage],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              )),
        ),
      ),
      elevation: 0.0,
      backgroundColor: Colors.black87,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      leadingWidth: 100,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: IconButton(
            icon: Icon(Icons.receipt_long),
            onPressed: () {
              _pageController.animateToPage(0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn);
            },
            iconSize: (currentPage == 0) ? 35 : 25,
            color: (currentPage == 0) ? Colors.white : Colors.white60),
      ),
      title: IconButton(
        icon: Icon(Icons.sports_handball_rounded),
        onPressed: () {
          _pageController.animateToPage(1,
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn);
        },
        iconSize: (currentPage == 1) ? 35 : 25,
        color: (currentPage == 1) ? Colors.white : Colors.white60,
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: IconButton(
              icon: Icon(Icons.list_alt_rounded),
              onPressed: () {
                _pageController.animateToPage(2,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn);
              },
              iconSize: (currentPage == 2) ? 35 : 25,
              color: (currentPage == 2) ? Colors.white : Colors.white60),
        )
      ],
    );
  }

  Widget _homebody() {
    return PageView.builder(
      itemBuilder: (context, position) {
        if (position == 0)
          return Billpage(
            user: widget.user,
          );
        if (position == 2)
          return WishlistPage(
              widget.user, widget.user.wishlist, onHeartClicked);
        else
          return Container(
            decoration: BoxDecoration(
              color: Colors.black87,
            ),
            padding: EdgeInsets.all(24),
            child: ListView(
              children: List.generate(products.length, (index) {
                return shoeCard(products[index], widget.user, onHeartClicked);
              }),
            ),
          );
      },
      controller: _pageController,
      itemCount: 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: _homebody(),
    );
  }
}
