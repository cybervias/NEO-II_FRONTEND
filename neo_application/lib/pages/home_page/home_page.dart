import 'package:flutter/material.dart';
import 'package:neo_application/constants/constants_sizes.dart';
import 'package:neo_application/pages/provider/drawer_provider.dart';
import 'package:neo_application/web/body.dart';
import 'package:neo_application/web/menu.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Size get size => MediaQuery.of(context).size;
  bool get showDrawer => size.width <= 800;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          _body(),
        ],
      ),
    );
  }

  _body() {
    final provider = Provider.of<DrawerProvider>(context);
    var isCollapsed = provider.isCollapsed;

    return SafeArea(
      child: Container(
        width: size.width,
        height: size.height,
        child: showDrawer
            ? Row(
                children: [
                  Container(
                    width: isCollapsed
                        ? menuWidth1
                        : MediaQuery.of(context).size.width * 0.00,
                    child: _menu(),
                  ),
                  Container(
                    width: isCollapsed
                        ? size.width - menuWidth1
                        : MediaQuery.of(context).size.width,
                    child: _right(context),
                  ),
                ],
              )
            : Row(
                children: [
                  Container(
                    width: isCollapsed
                        ? MediaQuery.of(context).size.width * 0.00
                        : menuWidth1,
                    child: _menu(),
                  ),
                  Container(
                    width: isCollapsed
                        ? MediaQuery.of(context).size.width
                        : size.width - menuWidth1,
                    child: _right(context),
                  ),
                ],
              ),
      ),
    );
  }

  _menu() {
    return Container(
      child: Drawer(
        child: Menu(),
      ),
    );
  }

  _right(context) {
    return Container(
      child: Body(),
    );
  }
}
