import 'package:flutter/material.dart';
import 'package:wilpro/ui/composants/my_colors.dart';

class MyNavBar extends StatefulWidget {
  final Function(int) action;
  const MyNavBar({super.key, required this.action});

  @override
  State<MyNavBar> createState() => _MyNavBar();
}

class _MyNavBar extends State<MyNavBar> {
  int _selectedIndex = 1;

  _changeView(int index) {
    _selectedIndex = index;
    widget.action(index);
  }

  Widget navBarItem(
      {required IconData icon,
      required int index,
      String? label,
      Color selected = MyColors.blue,
      Color unselected = MyColors.black}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _changeView(index);
        },
        child: Container(
          color: MyColors.backgroundNavBar,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  color: _selectedIndex == index ? selected : unselected),
              label != null
                  ? Text(
                      label,
                      style: TextStyle(
                          color:
                              _selectedIndex == index ? selected : unselected),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    double deviceWidth(BuildContext context) =>
        MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.1),
      height: screenHeight * 0.07,
      color: MyColors.backgroundNavBar,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          navBarItem(icon: Icons.edit, index: 0, label: "Création"),
          navBarItem(icon: Icons.home, index: 1, label: "Acceuil"),
          navBarItem(icon: Icons.bookmark, index: 2, label: "Historique"),
        ],
      ),
    );
  }
}
