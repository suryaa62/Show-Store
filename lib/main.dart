import 'package:flutter/material.dart';
import 'package:nike_shoe_store/loginPage.dart';
import 'package:nike_shoe_store/registerPage.dart';
import 'package:nike_shoe_store/services/auth.dart';
import 'homepage.dart';
import 'productpage.dart';
import 'models/product_repositry.dart';
import 'models/product.dart';
import 'models/user.dart';
import 'loginPage.dart';
import 'package:provider/provider.dart';
import 'services/auth.dart';

void main() {
  runApp(MyApp());
}

List<Product> products = ProductsRepository.loadProducts();

class MyApp extends StatelessWidget {
  User user = new User();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Homepage(user));
  }
}
