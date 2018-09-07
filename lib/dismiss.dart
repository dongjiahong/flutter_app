import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class DismissScreen extends StatefulWidget{
  @override
  createState() => DismissState();
}

class DismissState extends State<DismissScreen> {
  final items = List<String>.generate(8, (i) => "Item ${i+1}");
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('滑动item以删除该item'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index){
          final item = items[index];

          return Dismissible(
            // 每个Dismissble 必须有一个key， key能让这个item在flutter是唯一的组件
            key: Key(item),
            // 提供一个告诉flutter当我们划过item后需要干什么的函数
            onDismissed: (direction) {
              // 删除这个item
              setState((){
                items.removeAt(index);
              });
              Scaffold
                .of(context)
                .showSnackBar(SnackBar(content: Text('$item dismissed'),));
            },
            // 用一个背景色来突出item组件被滑动
            background: Container(color: Colors.red),
            child: ListTile(title: Text('$item')),
          );
        },
      ),
    );
  }
}

