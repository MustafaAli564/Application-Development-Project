import 'package:flutter/material.dart';
import 'package:recipe_app/AppBar/appbar.dart';
import 'package:recipe_app/pages/HomeScreen.dart';
import 'package:recipe_app/pages/favoritePage.dart';
import 'package:recipe_app/pages/mealPlanPage.dart';
import 'package:recipe_app/pages/settingsPage.dart';
import 'package:recipe_app/utils/constants.dart';
import 'package:iconsax/iconsax.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  late final List<Widget> page;
  @override
  void initState() {
    page = [
      const Homescreen(),
      const Favoritepage(),
      const Mealplanpage(),
      const Settingspage(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 247, 247, 247),
        
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 247, 247, 247),
        elevation: 1,
        iconSize: 28,
        currentIndex: selectedIndex,
        selectedItemColor: primarycolor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          color: primarycolor,
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w600,
          fontSize: 14.0,
        ),
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 0 ? Iconsax.home5 : Iconsax.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 1 ? Iconsax.heart5 : Iconsax.heart),
            label: "Favourites",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 2 ? Icons.food_bank : Icons.food_bank_outlined,
            ),
            label: "Meal Plan",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 3 ? Iconsax.setting_21 : Iconsax.setting_2,
            ),
            label: "Settings",
          ),
        ],
      ),
      body: page[selectedIndex],
    );
  }

  navBarPage(iconname) {
    return Center(child: Icon(iconname, size: 100, color: primarycolor));
  }
}
