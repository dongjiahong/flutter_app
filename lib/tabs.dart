import 'package:flutter/material.dart';

class TabsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    //return Container(
      //child: DefaultTabController(
      home: DefaultTabController(
        length: 3, // tab页数量
        child: Scaffold(
          appBar: AppBar(
            title: Text('Tabs Demo'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
          ),

          body: TabBarView(
            children: <Widget>[
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),

      ),
    );
  }
}