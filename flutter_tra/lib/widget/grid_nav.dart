import 'package:flutter/material.dart';
import 'package:flutter_tra/model/common_model.dart';
import 'package:flutter_tra/model/grid_nav_model.dart';
import 'package:flutter_tra/widget/webview.dart';

import '../model/common_model.dart';

class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;

  GridNav({Key key, this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(6),
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNavModel == null) items;
    if (gridNavModel.hotel != null) {
      items.add(_gridNavItem(context, gridNavModel.hotel, true));
    }
    if (gridNavModel.flight != null) {
      items.add(_gridNavItem(context, gridNavModel.flight, false));
    }
    if (gridNavModel.travel != null) {
      items.add(_gridNavItem(context, gridNavModel.travel, false));
    }
    return items;
  }

  _gridNavItem(BuildContext context, GridNavItem gridNavItem, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2));
    items.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4));

    List<Widget> exAndItems = [];
    items.forEach((item){
      exAndItems.add(Expanded(
        flex: 1,
        child: item,
      ));
    });
    Color startColor = Color(int.parse('0xff'+gridNavItem.startColor));
    Color endColor = Color(int.parse('0xff'+gridNavItem.endColor));
    return Container(
      height: 88,
      margin: first?null:EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        //线性渐变
        gradient: LinearGradient(
          colors: [startColor,endColor]
        )
      ),
      child: Row(
        children: exAndItems,
      ),
    );
  }

  _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(context, Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Image.network(
          model.icon,
          fit: BoxFit.contain,
          height: 88,
          width: 121,
          alignment: AlignmentDirectional.bottomEnd,
        ),
        Container(
          margin: EdgeInsets.only(top: 11),
          child: Text(
            model.title,
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        )
      ],
    ), model);
  }

  _doubleItem(BuildContext context, CommonModel topItem, CommonModel bottomItem,
      ) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _item(context,topItem,true),
        ),
        Expanded(
          child: _item(context,bottomItem,false),
        )
      ],
    );
  }

  _item(BuildContext context, CommonModel item, bool isFirst) {
    BorderSide borderSide = new BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                left: borderSide,
                bottom: isFirst ? borderSide : BorderSide.none)),
        child: _wrapGesture(context, Center(
          child: Text(
            item.title,
            style: TextStyle(fontSize: 14, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ), item)
      ),
    );
  }

  _wrapGesture(BuildContext context,Widget child,CommonModel model){
    return GestureDetector(
      onTap: (){
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
      child: child,
    );
  }
}
