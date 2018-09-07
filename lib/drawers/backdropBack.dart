import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class BackdropBack extends StatefulWidget{
  @override
  BackdropState createState() => BackdropState();
}

class BackdropState extends State<BackdropBack> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation animation;
  double slidValue = 10.0;


  @override 
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync:  this,
    );
    CurvedAnimation curve = CurvedAnimation(
      parent: controller,
      curve: Curves.elasticOut,
    );
    animation = Tween(
      begin: 50.0,
      end: 200.0,
    ).animate(curve)
    ..addListener((){
      setState((){});
    })
    ..addStatusListener((status){
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }

  @override 
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void playAnmition() {
    controller.forward();
  }

  Widget _childrens() {

    return Column(
      children: <Widget>[
        Text('后置面板'),
        Slider(
          value: slidValue,
          max: 100.0,
          onChanged: (double value) {
            setState(() {
              slidValue = value;
            });
          },
        ),
        FloatingActionButton.extended(
          icon: Icon(Icons.play_circle_outline),
          label: Text('点击观看下面的动画'),
          onPressed: playAnmition,
        ),
        Container(
          margin: EdgeInsets.only(top: 100.0),
          width: animation.value,
          height: animation.value,
          decoration: BoxDecoration(
            color: Colors.redAccent,
          ),
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return _childrens();
  }
}