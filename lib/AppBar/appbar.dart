import 'package:flutter/material.dart';
class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  const MyAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white, // 🌿 Deep green
      elevation: 4,
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10), // Rounded bottom edge
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: Colors.white,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white, size: 28,),
        onPressed: () {
          // Handle menu or drawer
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search_sharp, color: Colors.white, size: 28,),
          onPressed: () {
            // Handle search
          },
        ),
      ],
    );
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
