
import 'package:flutter_tra/model/config_model.dart';
import 'package:flutter_tra/model/sale_box_model.dart';

import 'common_model.dart';
import 'grid_nav_model.dart';

class HomeModel{
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final SaleBoxModel salesBox;


  HomeModel({this.config,this.bannerList,this.localNavList,this.gridNav,this.subNavList,this.salesBox});

}