import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipe_app/Widgets/banner.dart';
import 'package:recipe_app/Widgets/foodcard.dart';
import 'package:recipe_app/Widgets/myIconButton.dart';
import 'package:recipe_app/pages/viewAll.dart';
import 'package:recipe_app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String searchQuery = "";
  String category = "All";
  final CollectionReference categoriesItems = FirebaseFirestore.instance
      .collection("App-Category");
  Query get recipefilter => FirebaseFirestore.instance
      .collection("Recipe-Data")
      .where('category', isEqualTo: category);
  Query get allrecipes => FirebaseFirestore.instance.collection("Recipe-Data");
  Query get selectedrecipes => category == "All" ? allrecipes : recipefilter;

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
                  categorylist(),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Quick & Easy",
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 0.1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const Viewall()),
                          );
                        },
                        child: Text(
                          "View all",
                          style: TextStyle(
                            color: bannerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream:
                  (searchQuery.isNotEmpty
                          ? FirebaseFirestore.instance
                              .collection("Recipe-Data")
                              .where(
                                'ingredientName',
                                arrayContains: searchQuery,
                              )
                          : selectedrecipes)
                      .snapshots(),

              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> recipes =
                      snapshot.data?.docs ?? [];
                  if (recipes.length > 10) {
                    final limitedRecipes = recipes.take(10).toList();
                  } else {
                    final limitedRecipes = recipes;
                  }

                  return Padding(
                    padding: EdgeInsets.only(top: 5, left: 15),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            recipes
                                .map((e) => Foodcard(documentSnapshot: e))
                                .toList(),
                      ),
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> categorylist() {
    return StreamBuilder(
      stream: categoriesItems.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                streamSnapshot.data!.docs.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      category = streamSnapshot.data!.docs[index]["name"];
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1), // soft shadow
                          blurRadius: 8,
                          offset: Offset(0, 4), // horizontal, vertical offset
                        ),
                      ],
                      borderRadius: BorderRadius.circular(25),
                      color:
                          category == streamSnapshot.data!.docs[index]["name"]
                              ? primarycolor
                              : Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    margin: const EdgeInsets.only(right: 20),
                    child: Text(
                      streamSnapshot.data!.docs[index]["name"],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color:
                            category == streamSnapshot.data!.docs[index]["name"]
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Padding searchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 22),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchQuery =
                value.trim().isNotEmpty
                    ? value.trim()[0].toUpperCase() +
                        value.trim().substring(1).toLowerCase()
                    : "";
          });
        },
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
