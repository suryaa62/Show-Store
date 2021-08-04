import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/user.dart';

import 'package:rive/rive.dart';
import 'customWidgets/customSliderButton.dart';

class Billpage extends StatefulWidget {
  User user;

  Billpage({this.user});

  @override
  _BillpageState createState() => _BillpageState();
}

class _BillpageState extends State<Billpage> {
  final _formKey = GlobalKey<FormState>();
  double cartTotal = 0;
  bool showAnimation = false;
  Artboard _artboard;
  BoxAnim _controller;
  BoxAnim _cranecontroller;
  double second = 0;

  @override
  void initState() {
    _loadRiveFile();
    super.initState();
  }

  void _loadRiveFile() async {
    final bytes = await rootBundle.load('assets/placeOrderAnim.riv');
    final file = RiveFile.import(bytes);

    if (file != null) {
      setState(() {
        _artboard = file.mainArtboard
          ..addController(_controller = BoxAnim('begin'));
        _artboard.addController(_cranecontroller = BoxAnim('crane'));
        _cranecontroller.isActive = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _cranecontroller.dispose();
    super.dispose();
  }

  InputDecoration inputDeco() {
    return InputDecoration(
      border: InputBorder.none,
      focusColor: Colors.black87,
    );
  }

  Widget mytextField({String leadingText}) {
    return Row(
      children: [
        Text(leadingText),
        Expanded(
          child: TextFormField(
            scrollPadding: EdgeInsets.all(0),
            autofocus: false,
            decoration: inputDeco(),
          ),
        ),
      ],
    );
  }

  List<TableRow> generateList() {
    cartTotal = 0;
    List list = List.generate(widget.user.cart.length, (index) {
      cartTotal += widget.user.cart.elementAt(index)[0].price;
      return TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text((index + 1).toString()),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.user.cart.elementAt(index)[0].name),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.user.cart.elementAt(index)[1].toString()),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.user.cart.elementAt(index)[0].price.toString()),
        ),
        IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              setState(() {
                cartTotal = 0;
                widget.user.cart.remove(widget.user.cart.elementAt(index));
              });
            })
      ]);
    }).toList();
    list.insert(
        0,
        TableRow(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("S. No."),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Product Name "),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Size "),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Price "),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Cancel "),
          )
        ]));
    return list;
  }

  Widget billForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              "Billing Address",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            Divider(
              color: Colors.black87,
              thickness: 5,
            ),
            mytextField(leadingText: "Name : "),
            mytextField(leadingText: "Address :  "),
            mytextField(leadingText: "Phone No. : "),
            mytextField(leadingText: "Email : "),
            Divider(
              color: Colors.black87,
              thickness: 5,
            ),
            Text(
              "YOUR CART",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            Divider(
              color: Colors.black87,
              thickness: 5,
            ),
            Table(
                border: TableBorder(verticalInside: BorderSide(width: 1)),
                children: generateList()),
            Divider(
              color: Colors.black87,
              thickness: 5,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Total : Rs " + cartTotal.toString(),
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ));
  }

  void onSliderChanged(double value) {
    setState(() {
      if (value == 0) {
        //  _controller.apply(_artboard, 0.5);

        showAnimation = false;
      } else
        showAnimation = true;

      if (value < 60) {
        _controller.frameplus(_artboard, value.round());
      }

      if (value >= 40)
        _cranecontroller.frameplus(_artboard, value.round() - 40);

      second = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.black87,
        ),
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
                flex: 6,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 100),
                  child: !showAnimation
                      ? Card(
                          elevation: 0,
                          color: Color.fromRGBO(245, 245, 245, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: billForm()),
                        )
                      : Rive(
                          artboard: _artboard,
                          fit: BoxFit.cover,
                        ),
                )),
            Expanded(
              child: SliderButton(widget.user, onSliderChanged),
            ),
          ],
        ));
  }
}

class BoxAnim extends SimpleAnimation {
  BoxAnim(String animationName) : super(animationName);

  double timeForOneFrame;

  int frameplus(Artboard artboard, int frame) {
    timeForOneFrame =
        instance.animation.durationSeconds / instance.animation.fps;
    print(instance.animation.fps);

    instance.animation.loop = Loop.loop;

    //instance.time = timeForOneFrame * frame;
    print(instance.time);
    apply(artboard, getElapsedSecond(frame));
    isActive = false;
    return 1;
  }

  double getElapsedSecond(int frame) {
    print(frame);
    int currentFrame = instance.time ~/ timeForOneFrame;

    return (frame - currentFrame) * timeForOneFrame;
  }

  void tillFrame(Artboard artboard, int frame) {
    timeForOneFrame =
        instance.animation.durationSeconds / instance.animation.fps;
    int currentFrame = instance.time ~/ timeForOneFrame;
    if (frame - currentFrame > 0) {
      for (int i = currentFrame; i <= frame; i++) {
        Future.delayed(Duration(milliseconds: 17)).whenComplete(() {
          frameplus(artboard, frame);
        });
      }
    } else {
      for (int i = currentFrame; i >= frame; i--) {
        Future.delayed(Duration(milliseconds: 17)).whenComplete(() {
          frameplus(artboard, frame);
        });
      }
    }
  }
}
