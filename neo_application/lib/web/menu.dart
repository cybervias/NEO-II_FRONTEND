import 'package:flutter/material.dart';
import 'package:neo_application/web/expandable_list/sub_list_tile.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(246, 34, 37, 44),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 2, top: 10),
              child: Image.asset(
                "assets/images/neocert_logo.png",
                fit: BoxFit.fill,
                width: 100,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Usuário",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SubListTile()
          ],
        ),
      ),
    );
  }
}
