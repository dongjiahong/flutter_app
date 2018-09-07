import 'package:flutter/material.dart';

 import 'drawers/backdropBack.dart';

// 参考实验项目: https://codelabs.developers.google.com/codelabs/mdc-104-flutter/
// flutter中的视图Widget像Android中的Activity一样存在生命周期，生命周期的回调函数体都在State中。 
// 组件State的生命周期整理：
//  -> 构造函数
//  -> initState (注意flutter的热加载功能是不会调用它的，如果你改变了代码记得重启app)
//  -> didChangeDependencies
//  -> build

const double _kFlingVelocity = 2.0;

class MoreDrawerScreen extends StatefulWidget {
  @override
  MoreDrawerState createState() => MoreDrawerState();
}

class MoreDrawerState extends State<MoreDrawerScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 直接缓存一个控件不是好习惯，如下面的_frontlayout控件，应该使用函数去生成
  Widget _frontlayout() {
    return Container(
      height: 1000.0,
      child: Card(
        elevation: 20.0,
        color: Colors.blue,
        child: Column(
          children: [
            Center(
              child: Text('前置面板'),
            ),
          ],
        ),
      ),
    );
  }

  Card _thirdlayout = Card(
    margin: EdgeInsets.only(left: 20.0, right: 20.0),
    elevation: 20.0,
    color: Colors.yellowAccent,
    child: Text('第三个面板'),
  );

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    Animation<RelativeRect> layerAnimation = RelativeRectTween(
            begin: RelativeRect.fromLTRB(0.0, 200.0, 0.0, 0.0), // 开始的位置
            // 结束的位置，如果没有动画效果那你看到的就是结束的位置
            end: RelativeRect.fromLTRB(0.0, 400.0, 0.0, 0.0))
        // animate 为补间动画添加动画，而不是返回单个值，animate函数返回一个包含补间的新动画。
        // 当你想要将新创建的动画提供给另一个控件时，此方法最为有用，然后可以读取包含补间的当前
        // 值以及监听对值得更改
        .animate(_controller.view);

    return Stack(
      children: <Widget>[
        BackdropBack(),
        PositionedTransition(
          rect: layerAnimation, // 让前面板从开始位置到结束位置过渡
          child: Stack(children: [
            _frontlayout(),
            PositionedTransition(
              rect: layerAnimation,
              child: _thirdlayout,
            ),
          ]),
        ),
      ],
    );
  }

  bool get _frontLayerVisible {
    final AnimationStatus status = _controller.status;
    // 完成和开始
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    // fling可以理解为'投掷'动画，其使用诸如弹簧的物理模拟来驱动动画。
    _controller.fling(
        velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity);
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text('点击右边按钮'),
      elevation: 0.0,
      actions: <Widget>[
        _BackdropMenu(
          listenable: _controller.view,
          onPressed: _toggleBackdropLayerVisibility,
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: LayoutBuilder(
        builder: _buildStack,
      ),
    );
  }
}

class _BackdropMenu extends AnimatedWidget {
  final Function onPressed;

  const _BackdropMenu({
    Listenable listenable,
    this.onPressed,
  }) : super(listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = this.listenable;
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: this.onPressed,
          icon: Stack(
            children: <Widget>[
              Opacity(
                opacity: animation.value,
                child: Icon(Icons.arrow_drop_up),
              ),
              FractionalTranslation(
                translation:
                    Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 0.5)
                            // evaluate获取动画当前值的补间。这个方法对于已经在监听动画的控件最为有用，
                            // 因此每当动画改变值时重建。
                            )
                        .evaluate(animation),
                child: Opacity(
                    opacity: 1 - animation.value, // 上面的图片显示这里就不显示了，跟上面的情况相反
                    child: Icon(Icons.arrow_drop_down)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
