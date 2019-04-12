import './person.dart';
import 'package:flutter/material.dart';

class TaskRow extends StatelessWidget {
  final QMPersonItem task;
  final double dotSize = 12.0;
  final Animation<double> animation;
  final void Function(BuildContext,QMPersonItem) onTap;

  const TaskRow({Key key, this.task, this.animation,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new FadeTransition(
      opacity: animation,
      child: new SizeTransition(
        sizeFactor: animation,
        child: new GestureDetector(
          //发生点击事件后回调
          onTap: () {
            // print('发生点击事件后回调');
            this.onTap(context,task);
          },
          child: new Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: new Row(
              children: <Widget>[
                new Padding(
                  padding:
                      new EdgeInsets.symmetric(horizontal: 32.0 - dotSize / 2),
                  child: new Container(
                    height: dotSize,
                    width: dotSize,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle, color: task.color),
                  ),
                ),
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        task.name,
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      new Text(
                        task.category,
                        style:
                            new TextStyle(fontSize: 12.0, color: Colors.grey),
                      )
                    ],
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: new Text(
                    task.time,
                    style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
