import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavrailWidget extends StatefulWidget {
  const NavrailWidget({super.key});

  @override
  State<NavrailWidget> createState() => _NavrailWidgetState();
}

class _NavrailWidgetState extends State<NavrailWidget> {
  int _selectedIndex = 0;
  PointerHoverEvent? event;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        centerTitle: true,
      ),
      body: Row(
        children: <Widget>[
          MouseRegion(
            onHover: (event) {
              print(event.down);

              event = event;
              setState(() {});
            },
            child: NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.selected,
              backgroundColor: Colors.green,
              destinations: const <NavigationRailDestination>[
                // navigation destinations
                NavigationRailDestination(
                  icon: Icon(Icons.favorite_border),
                  selectedIcon: Icon(Icons.favorite),
                  label: Text('Wishlist'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person_outline_rounded),
                  selectedIcon: Icon(Icons.person),
                  label: Text('Account'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.shopping_cart_outlined),
                  selectedIcon: Icon(Icons.shopping_cart),
                  label: Text('Cart'),
                ),
              ],
              selectedIconTheme: IconThemeData(color: Colors.white),
              unselectedIconTheme: IconThemeData(color: Colors.black),
              selectedLabelTextStyle: TextStyle(color: Colors.white),
            ),
          ),

          // create a navigation rail

          const VerticalDivider(thickness: 1, width: 2),
          Expanded(
            child: Center(
              child: Text('Page Number: $_selectedIndex'),
            ),
          )
        ],
      ),
    );
  }
}
