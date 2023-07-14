import 'package:applock/presentation/Activity.dart';
import 'package:applock/presentation/Setting.dart';
import 'package:applock/utils/Global.dart';
import 'package:applock/utils/GlobalFunction.dart';
import 'package:applock/utils/StringValues.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Splashpage extends StatefulWidget {
    static String routeNamed = StringValues.splashPage;

  const Splashpage({super.key});

  @override
  State<Splashpage> createState() => _SplashPageState();
}

class _SplashPageState extends State<Splashpage> {

  _getBody() {
    switch (currentPage) {
      case 0:
        return Activity();
      case 1:
        return Setting();
      default:
        return Activity();
    }
  }

  _getBottomBar() {
    return Card(
      color: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      margin: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _getBottomBarItem(index: 0, icontab: Icons.home),
          _getBottomBarItem(index: 1,icontab: Icons.add)
        ],
      ),
    );
  }

  _getBottomBarItem({
    required int index,
    required IconData icontab,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentPage = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: ScreenUtil().setHeight(60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color:
                    currentPage == index ? Colors.blueGrey: Colors.transparent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Icon(
                  icontab,
                  color: currentPage == index
                      ? Colors.white
                      : Colors.black,
                  size: setHeight(32),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
      return SafeArea(child: Scaffold(
        body: Column(
          children: <Widget>[Expanded(child: _getBody()), _getBottomBar()],
        ),
        resizeToAvoidBottomInset: false,
        
      ));
  
  }
}
