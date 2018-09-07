import 'package:flutter/material.dart';
import 'dart:math';

import 'english.dart';
import 'base.dart';
import 'bottom_app_bar.dart';
import 'more_drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      theme: new ThemeData(
        primaryColor: Colors.blueGrey,
      ),
      // 下面定义路由，如果是用命名路由route就不能使用home,两者不共存
      //home: new HomeScreen(),
      initialRoute: '/', // 定义app的起始页面
      routes: {
        '/': (context) => HomeScreen(),
        // '/other':  // 调用时候使用Navigator.pushName(context, '/other') 返回用Navigator.pop(context)
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learn Demo"),
      ),
      body: _buildGridView(context),
    );
  }
}

Widget _buildGridView(BuildContext context) {
  final _cardList = _buildGridViewList(context);
  return GridView.count(
    crossAxisCount: 2,
    children: _cardList,
  );
}

Color _getRandomColor() {
  final List<Color> _colors = [
    Colors.blue,
    Colors.yellow,
    Colors.pink,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.yellowAccent,
    Colors.white30,
    Colors.brown,
    Colors.white,
  ];
  return _colors[Random.secure().nextInt(_colors.length)];
}

List<Card> _buildGridViewList(BuildContext context) {
  final List<Card> _gridViewList = [];
  // XXX 添加新的组件
  _gridViewList
      .add(_newCard(context, '基础组件', BaseWidgetScreen(), _getRandomColor()));
  _gridViewList.add(
      _newCard(context, '随机英语单词Demo', RandomWordsScreen(), _getRandomColor()));
  _gridViewList.add(
      _newCard(context, '底部AppBar', BottomAppBarScreen(), _getRandomColor()));
  _gridViewList
      .add(_newCard(context, '各种抽屉', MoreDrawerScreen(), _getRandomColor()));
  return _gridViewList;
}

Card _newCard(BuildContext context, String text, Widget mscreen, Color color) {
  return Card(
    child: RaisedButton(
      color: color,
      child: Text(
        text,
        style: TextStyle(fontSize: 24.0),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => mscreen),
        );
      },
    ),
  );
}
