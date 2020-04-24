import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_tra/dao/home_dao.dart';
import 'package:flutter_tra/model/common_model.dart';
import 'package:flutter_tra/model/home_model.dart';
import 'package:flutter_tra/model/sale_box_model.dart';
import 'package:flutter_tra/widget/loading_container.dart';
import 'package:flutter_tra/widget/local_nav.dart';
import 'package:flutter_tra/widget/sale_box_nav.dart';
import 'package:flutter_tra/widget/sub_nav.dart';
import 'package:flutter_tra/widget/webview.dart';


import '../model/common_model.dart';
import '../model/grid_nav_model.dart';
import '../widget/grid_nav.dart';

const MAX_APPBAR_ALPHA = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String resultString = "";
  List<CommonModel> localNavList = [];
  List<CommonModel> bannerList = [];
  List<CommonModel> subList = [];
  GridNavModel gridNavModel;
  SaleBoxModel saleBoxModel;
  double appBarAlpha = 0;

  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _swiperController = new SwiperController();
    _swiperController.startAutoplay();
    _handleRefresh();
  }
  SwiperController _swiperController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: LoadingContainer(isLoading:_loading ,child: Stack(
        children: <Widget>[
          RefreshIndicator(
            onRefresh: _handleRefresh,
            child: NotificationListener(
              // ignore: missing_return
              onNotification: (s){
                setState(() {
                  if(s is ScrollUpdateNotification && s.depth == 0){
                    _onScroll(s.metrics.pixels);
                  }
                });
              },
              child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: _listView),
            ),
          ),
          _appBar
        ],
      ),),
    );
  }
  Widget get _appBar{
    return Opacity(
      opacity: appBarAlpha,
      child: Container(
          height:40,
          color: Colors.white,
          child: Center(
            child: Text('首页',style: TextStyle(color: Color(0xff333333)),),
          )
      ),
    );
  }
  Widget get _listView{
    return ListView(
      children: <Widget>[
        Container(
          height: 160,
          child: Swiper(
            controller: _swiperController,
            itemCount: bannerList.length,
            autoplay: false,
            loop: false,
            pagination: SwiperPagination(),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    CommonModel model = bannerList[index];
                    return WebView(url:model.url,title: model.title,hideAppBar: model.hideAppBar,);
                  }));
                },
                child: Image.network(
                  bannerList[index].icon,
                  fit: BoxFit.fill,
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(
            localNavList: localNavList,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child:GridNav(gridNavModel: gridNavModel,),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child:     SubNav(subNavList: subList,),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child:     SaleBox(saleBox: saleBoxModel,),
        ),
      ],
    );
}
  Future<Null> _handleRefresh() async {
//    HomeDao.fetch().then((result){
//      setState(() {
//        resultString = json.encode(result);
//      });
//    }).catchError((e){
//      setState(() {
//        resultString = e.toString();
//      });
//    });
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        bannerList = model.bannerList;
        gridNavModel = model.gridNav;
        saleBoxModel = model.salesBox;
        subList = model.subNavList;
        _loading = false;
      });
    } catch (E) {
      print(E);
      setState(() {
        _loading = false;
      });
    }
    return null;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _swiperController.stopAutoplay();
    _swiperController.dispose();
    super.dispose();
  }

  _onScroll(double offset) {
    double alpha = offset/MAX_APPBAR_ALPHA;
    if(alpha>1){
      alpha = 1;
    }else if(alpha<0){
      alpha = 0;
    }
    appBarAlpha = alpha;
  }
}
