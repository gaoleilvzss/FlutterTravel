import 'package:flutter/material.dart';
import 'package:flutter_tra/model/common_model.dart';
import 'package:flutter_tra/model/grid_nav_model.dart';
import 'package:flutter_tra/widget/webview.dart';

class SaleBox extends StatelessWidget {
  final List<CommonModel> saleBox;

  SaleBox({Key key, this.saleBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: _items(context),
    );
  }

  _items(BuildContext context) {
    if (saleBox == null) return null;
    List<Widget> items = [];
//    items.add(item)

    int sep = (saleBox.length / 2 + 0.5).toInt();
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, //平均排列
          children: items.sublist(0, sep),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, //平均排列
            children: items.sublist(sep, subNavList.length),
          ),
        )
      ],
    );
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.spaceBetween, //平均排列
//      children: items,
//    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return WebView(
              url: model.url,
              statusBarColor: model.statusBarColor,
              hideAppBar: model.hideAppBar,
            );
          }));
        },
        child: Column(
          children: <Widget>[
            Image.network(
              model.icon,
              width: 18,
              height: 18,
            ),
            Padding(
              padding: EdgeInsets.only(top: 3),
              child: Text(
                model.title,
                style: TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
