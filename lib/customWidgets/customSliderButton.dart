import 'dart:io';
import 'package:nike_shoe_store/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SliderButton extends StatefulWidget {
  User user;
  Function onSliderChanged;
  SliderButton(this.user, this.onSliderChanged);
  @override
  _SliderButtonState createState() => _SliderButtonState();
}

class _SliderButtonState extends State<SliderButton> {
  double second = 0;
  String text;
  Color textcolor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    text = (widget.user.cart.isEmpty)
        ? 'Your Cart Is Empty'
        : 'Slide To Confirm Order';
    textcolor = (widget.user.cart.isEmpty) ? Colors.red : Colors.black87;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        sliderBackground(text, textcolor),
        SliderTheme(
          data: SliderThemeData(
              thumbShape:
                  RoundSliderThumbShape(enabledThumbRadius: 15, elevation: 5),
              thumbColor: Colors.black87,
              activeTrackColor: Colors.transparent,
              inactiveTrackColor: Colors.transparent),
          child: Slider(
            onChangeEnd: (value) {
              if (value != 99) {
                setState(() {
                  second = 0;
                  widget.onSliderChanged(second);
                });
              } else {
                setState(() {
                  text = 'Order Confirmed';
                  textcolor = Colors.green;
                  Future.delayed(Duration(milliseconds: 2000), () => 1)
                      .whenComplete(() => setState(() {
                            text = 'Your Cart Is Empty';
                            textcolor = Colors.red;
                          }));
                  widget.user.cart = Set();
                  second = 0;
                  widget.onSliderChanged(second);
                });
              }
            },
            value: second,
            min: 0,
            max: 99,
            //divisions: 20,
            label: second.toString(),
            onChanged: (value) {
              if (widget.user.cart.isEmpty) {
                setState(() {
                  second = 0;
                });
              } else {
                widget.onSliderChanged(value);
                second = value;
              }
            },
          ),
        ),
      ],
    );
  }
}

class sliderBackground extends StatelessWidget {
  String text;
  Color textColor;
  sliderBackground(this.text, this.textColor);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Shimmer.fromColors(
              child: Text(
                text,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              baseColor: textColor,
              highlightColor: Colors.white),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(100))));
  }
}
