import 'package:flutter/material.dart';
import 'package:flutter_tra/model/common_model.dart';
import 'package:flutter_tra/model/grid_nav_model.dart';
import 'package:flutter_tra/widget/webview.dart';

class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;

  GridNav({Key key, this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _gridNavItems(context),
    );
  }

  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNavModel == null) items;
    if (gridNavModel.hotel != null) {
    }
    if (gridNavModel.flight != null) {}
    if (gridNavModel.travel != null) {}
  }

  _gridNavItem(BuildContext context, GridNavItem gridNavItem, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem.mainItem));
  }

  _mainItem(BuildContext context, CommonModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
              return WebView(
                url: model.url,
                title: model.title,
                statusBarColor: model.statusBarColor,
                hideAppBar: model.hideAppBar,
              );
            }));
      },
      child: Stack(
        children: <Widget>[
          Image.network(
            model.icon,
            fit: BoxFit.contain,
            height: 88,
            width: 121,
            alignment: AlignmentDirectional.bottomEnd,
          ),
          Text(
            model.title,
            style: TextStyle(fontSize: 14, color: Colors.white),
          )
        ],
      ),
    );
  }

  _doubleItem(BuildContext context,CommonModel topItem,CommonModel bottomItem,bool isCenterItem){
    return Column(
      children: <Widget>[
        Expanded(
        )
      ],
    );

  }
  _item(BuildContext context,CommonModel item,bool isFirst,bool isCenter){
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(border: Border(
          left:
        )),
        child: ,
      ),
    );
  }
}
