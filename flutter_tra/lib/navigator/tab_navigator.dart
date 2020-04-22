import 'package:flutter/material.dart';
import 'package:flutter_tra/pgaes/home_page.dart';
import 'package:flutter_tra/pgaes/my_page.dart';
import 'package:flutter_tra/pgaes/search_page.dart';
import 'package:flutter_tra/pgaes/travel_page.dart';
import 'dart:io';
import 'package:flutter/services.dart';
class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

int _currentIndex = 0;
PageController _controller = PageController(initialPage: 0);
List pageList = [HomePage(), SearchPage(), TravelPage(), MyPage()];
final _defaultColor = Colors.grey;
final _activeColor = Colors.blue;

class _TabNavigatorState extends State<TabNavigator> {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    return Scaffold(
      body: PageView.builder(
        itemCount: pageList.length,
        controller: _controller,
          onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      }, itemBuilder: (BuildContext context, int index) {
        return pageList[index];
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _controller.jumpToPage(index);
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _defaultColor,
              ),
              activeIcon: Icon(Icons.home, color: _activeColor),
              title: Text(
                '首页',
                style: TextStyle(
                    color: _currentIndex == 0 ? _activeColor : _defaultColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _defaultColor,
              ),
              activeIcon: Icon(Icons.search, color: _activeColor),
              title: Text(
                '搜索',
                style: TextStyle(
                    color: _currentIndex == 1 ? _activeColor : _defaultColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.camera_alt,
                color: _defaultColor,
              ),
              activeIcon: Icon(Icons.camera_alt, color: _activeColor),
              title: Text(
                '旅拍',
                style: TextStyle(
                    color: _currentIndex == 2 ? _activeColor : _defaultColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                color: _defaultColor,
              ),
              activeIcon: Icon(Icons.account_circle, color: _activeColor),
              title: Text(
                '我的',
                style: TextStyle(
                    color: _currentIndex == 3 ? _activeColor : _defaultColor),
              )),
        ],
      ),
    );
  }
}
