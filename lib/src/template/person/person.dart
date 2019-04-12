

import './animated_fab.dart';
import './diagonal_clipper.dart';
import './initial_list.dart';
import './list_model.dart';
import './task_row.dart';
import 'package:flutter/material.dart';


class QMPersonCenter extends StatelessWidget {
  final String bgImage;
  final QMPerson user;
  final QMPersonDescription desc;
  final Function(BuildContext,QMPersonItem) onTap;
  QMPersonCenter({
    this.bgImage,
    this.desc,
    this.user,
    this.onTap
  });
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new _QMPersonCenter(bgImage: bgImage,desc:desc,user:user,onTap: onTap,),
    );
  }
}

class _QMPersonCenter extends StatefulWidget {
  final String bgImage;
  final QMPerson user;
  final QMPersonDescription desc;
  final void Function(BuildContext,QMPersonItem) onTap;
  _QMPersonCenter({Key key,this.bgImage,this.desc,this.user,this.onTap}) : super(key: key);

  @override
  _MainPageState createState() => new _MainPageState(onTap: this.onTap);
}

class _MainPageState extends State<_QMPersonCenter> {
  _MainPageState({this.onTap});
  final GlobalKey<AnimatedListState> _listKey =
      new GlobalKey<AnimatedListState>();
  final double _imageHeight = 256.0;
  final void Function(BuildContext,QMPersonItem) onTap;
  ListModel listModel;
  bool showOnlyCompleted = false;

  @override
  void initState() {
    super.initState();
    listModel = new ListModel(_listKey, widget.user.list ?? tasks,this.onTap);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          _buildTimeline(),
          _buildIamge(),
          _buildTopHeader(),
          _buildProfileRow(),
          _buildBottomPart(),
          _buildFab(),
        ],
      ),
    );
  }

  Widget _buildFab() {
    return new Positioned(
        top: _imageHeight - 100.0,
        right: -40.0,
        child: new AnimatedFab(
          onClick: _changeFilterState,
        ));
  }

  void _changeFilterState() {
    showOnlyCompleted = !showOnlyCompleted;
    List<QMPersonItem> list = widget.user.list ?? tasks;
    list.where((task) => !task.completed).forEach((task) {
      if (showOnlyCompleted) {
        listModel.removeAt(listModel.indexOf(task));
      } else {
        listModel.insert(list.indexOf(task), task);
      }
    });
  }

  Widget _buildIamge() {
    return new Positioned.fill(
      bottom: null,
      child: new ClipPath(
        clipper: new DialogonalClipper(),
        child: new Image.asset(
          widget.bgImage ?? 'assets/images/common_user_background.png',
          fit: BoxFit.cover,
          height: _imageHeight,
          colorBlendMode: BlendMode.srcOver,
          color: new Color.fromARGB(120, 20, 10, 40),
        ),
      ),
    );
  }

  Widget _buildTopHeader() {
    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
      child: new Row(
        children: <Widget>[
          new Icon(Icons.menu, size: 32.0, color: Colors.white),
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: new Text(
                "Fusion Platform",
                style: new TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          new Icon(Icons.linear_scale, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildProfileRow() {
    return new Padding(
      padding: new EdgeInsets.only(left: 16.0, top: _imageHeight / 2.5),
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
            minRadius: 28.0,
            maxRadius: 28.0,
            backgroundImage: new AssetImage(widget.user.photo ?? 'assets/images/avatar.png'),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  widget.user.name ?? '张善旭',
                  style: new TextStyle(
                      fontSize: 26.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                new Text(
                  widget.user.desc ?? '高级系统架构员',
                  style: new TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPart() {
    return new Padding(
      padding: new EdgeInsets.only(top: _imageHeight),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildMyTasksHeader(),
          _buildTasksList(),
        ],
      ),
    );
  }

  Widget _buildTasksList() {
    return new Expanded(
      child: new AnimatedList(
        initialItemCount: widget.user.list.length ?? tasks.length,
        key: _listKey,
        itemBuilder: (context, index, animation) {
          return new TaskRow(
            task: listModel[index],
            animation: animation,
            onTap:onTap,

          );
        },
      ),
    );
  }

  Widget _buildMyTasksHeader() {
    return new Padding(
      padding: new EdgeInsets.only(left: 64.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            widget.desc!=null ? widget.desc.title:'Fusion 3.0平台移动框架',
            style: new TextStyle(fontSize: 34.0),
          ),
          new Text(
            widget.desc!=null ? widget.desc.content:'Fusion 3.0移动端,新平台,新体验',
            style: new TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return new Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 32.0,
      child: new Container(
        width: 1.0,
        color: Colors.grey[300],
      ),
    );
  }
}


class QMPersonDescription{
  String title;
  String content;
  QMPersonDescription({
    this.title,
    this.content
  });
}

class QMPerson {
  String name;
  String desc;
  String photo;
  List<QMPersonItem> list;

  QMPerson(
    {@required this.name,this.desc,this.photo,this.list}
  );
}

class QMPersonItem {
  final String id;
  final String name;
  final String category;
  final String time;
  final Color color;
  final bool completed;

  QMPersonItem({@required this.id,this.name, this.category, this.time, this.color, this.completed});
}
  