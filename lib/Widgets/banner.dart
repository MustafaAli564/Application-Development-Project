import 'package:flutter/material.dart';
import 'package:recipe_app/utils/constants.dart';

class MyBanner extends StatelessWidget {
  const MyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: primarycolor,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 15,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cook the best\nRecipes!!",
                  style: TextStyle(
                    height: 1.1,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 33),
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: Text(
                    "Explore",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 5,
            child: Image.network(
              "https://static.vecteezy.com/system/resources/previews/049/655/073/non_2x/a-plate-full-of-different-types-of-food-png.png",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
