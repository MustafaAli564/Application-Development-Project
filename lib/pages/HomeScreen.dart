import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipe_app/Widgets/banner.dart';
import 'package:recipe_app/Widgets/myIconButton.dart';
import 'package:recipe_app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  // String category = "All";
  // final CollectionReference categoriesItems = FirebaseFirestore.instance
  //     .collection("App-Category");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerParts(),
                  searchBar(),
                  const MyBanner(),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // StreamBuilder(
                  //   stream: categoriesItems.snapshots(),
                  //   builder: (
                  //     context,
                  //     AsyncSnapshot<QuerySnapshot> streamSnapshot,
                  //   ) {
                  //     if (streamSnapshot.hasData) {
                  //       return SingleChildScrollView(
                  //         scrollDirection: Axis.horizontal,
                  //         child: Row(
                  //           children: List.generate(
                  //             streamSnapshot.data!.docs.length,
                  //             (index) => GestureDetector(
                  //               onTap: () {},
                  //               child: Container(
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(25),
                  //                 ),
                  //                 padding: const EdgeInsets.symmetric(
                  //                   horizontal: 20,
                  //                   vertical: 10,
                  //                 ),
                  //                 margin: const EdgeInsets.only(right: 20),
                  //                 child: Text(
                  //                   streamSnapshot.data!.docs[index]["name"],
                  //                   style: TextStyle(
                  //                     fontWeight: FontWeight.w600
                  //                   ),
                  //                 ),
                                  
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     }
                  //     return Center(child: CircularProgressIndicator());
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding searchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 22),
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: Icon(Iconsax.search_normal),
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          hintText: "Search Recipes...",
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Row headerParts() {
    return Row(
      children: [
        Text(
          "What are you\ncooking today?",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
        Spacer(),
        Myiconbutton(icon: Iconsax.notification, pressed: () {}),
      ],
    );
  }
}
