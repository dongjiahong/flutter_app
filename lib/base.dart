import 'package:flutter/material.dart';

import 'tabs.dart';
import 'dismiss.dart';
import 'hero.dart';
import 'http.dart';
import 'textForm.dart';

class BaseWidgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基础组件'),
      ),
      body: MainScreen(),
      drawer: _buildDrawerPage(context),
    );
  }

  // drawer
  Widget _buildDrawerPage(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.black45,
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('这是ListTile组件'),
          leading: Icon(Icons.phone_android),
        ),
        _buildSnackBarPage(context),
        _buildTabsPage(context),
        _buildDismissPage(context),
        _buildHeroPage(context),
        _buildHttpPage(context),
        _buildTextFormPage(context),
      ],
    );
  }

  // snackBar
  Widget _buildSnackBarPage(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('这是一个提示条'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
    );
    return Container(
        decoration: BoxDecoration(color: Colors.deepPurple),
        padding: EdgeInsets.only(top: 2.0),
        child: RaisedButton(
          color: Colors.blue,
          child: Text('点击显示SnackBar'),
          onPressed: () {
            Scaffold.of(context).showSnackBar(snackBar);
          },
        ));
  }

  // tabs
  Widget _buildTabsPage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.pink),
      padding: EdgeInsets.only(top: 2.0),
      child: RaisedButton(
        color: Colors.black12,
        child: Text('点击跳转到Tabs页'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TabsScreen()),
          );
        },
      ),
    );
  }

  // dismiss
  Widget _buildDismissPage(BuildContext context) {
    return Container(
      height: 100.0,
      decoration: BoxDecoration(
        image: DecorationImage( // 给container添加背景色
          image: NetworkImage('https://flutter.io/images/flutter-mark-square-100.png'),
        ),
      ),
      padding: EdgeInsets.only(top: 2.0),
      child: RaisedButton(
        color: Colors.transparent, // 颜色透明，不然会挡住背景色
        child: Text('体会下Dismiss控件'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DismissScreen()),
          );
        },
      ),
    );
  }
}

Widget _buildHeroPage(BuildContext context) {
  return GestureDetector(
    child: Container(
      height: 100.0,
      padding: EdgeInsets.only(top: 2.0),
      child: Hero(
        tag: 'imageHero',
        child: Image.network(
            'https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg'),
      ),
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HeroScreen()),
      );
    },
  );
}

Widget _buildHttpPage(BuildContext context) {
  return Container (
    padding: EdgeInsets.only(top: 2.0),
    child: RaisedButton(
      child: Text('http控件'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HttpScreen()),
        );
      },
    ),
  );
}

Widget _buildTextFormPage(BuildContext context) {
  return Container (
    padding: EdgeInsets.only(top: 2.0),
    child: RaisedButton(
      child: Text('TextForm控件'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TextFormScreen()),
        );
      },
    ),
  );
}