import 'product.dart';

class ProductsRepository {
  static List<Product> loadProducts() {
    List<Product> allProducts = <Product>[
      Product(
          "Air Jordan 1 Mid",
          [9.5, 10, 10.5, 11, 12],
          9995,
          "The Air Jordan 1 Mid Shoe is inspired by the first AJ1, offering fans of Jordan retros a chance to follow in the footsteps of greatness. Fresh colour trims the clean, classic materials, injecting some newness into the familiar design.",
          "AIR"),
      Product(
          "Jordan Delta 2",
          [5.5, 6, 6.5, 7, 8],
          11495,
          "The Jordan Delta 2 offers a fresh, fearless take on the features you want: durability, comfort and an attitude that's Jordan to the core.We updated design lines and swapped out some components, but the idea is the same as the first Delta.The 2 still has that clashing combination of supportive and space age-like materials, with lots of different textures and heavy stitching to create a look that's both adventurous and iconic.",
          "Delta"),
      Product(
          "Air Jordan 7 Retro",
          [9, 9.5, 10],
          15995,
          "Inspired by the shoe originally worn by MJ during the '92 season and summer of basketball, the Air Jordan 7 Retro revives its championship legacy for a new generation of sneakerheads.",
          "007"),
      Product(
          "Jordan Zoom '92",
          [7.5, 8, 9, 9.5, 10],
          10797,
          "descriptioA nod to '90s basketball shoes, the Jordan Zoom '92 focuses on comfort, while tapping into the irreverent spirit of that era's designs. A stretchy-fit sleeve and underfoot cushioning offer a comfortable fit. '90s-inspired details give the shoe its retro flavour.",
          "ZOOM"),
      Product(
          "Jordan MA2",
          [7.5, 8, 9, 10],
          7495,
          "descriptioThe all-new Jordan MA2 makes plays on the street with wildly diverse materials. Varied designs create a look that captures the feel of Jordan heritage while forging a fresh, new identity that stands on its own.",
          "MA2"),
      Product(
          "Jordan One Take",
          [9, 9.5, 10],
          8295,
          "descriptioRussell Westbrook backs up his brashness with a fast, aggressive playing style and numbers that place him among the league's best. His all-new Jordan One Take II embodies his edginess and speed. Colours, textures and design lines speak to Russ' persona both on and off the court. This PF version uses an extra-durable outsole that's ideal for outdoor courts.",
          "ONE")
    ];
    return allProducts;
  }
}
