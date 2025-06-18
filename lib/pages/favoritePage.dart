import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Providers/favProvider.dart';
import 'package:recipe_app/pages/detailsPage.dart';

class Favoritepage extends StatefulWidget {
  const Favoritepage({super.key});

  @override
  State<Favoritepage> createState() => _FavoritepageState();
}

class _FavoritepageState extends State<Favoritepage> {
  @override
  Widget build(BuildContext context) {
    final provider = Favprovider.of(context);
    final favoriteItems = provider.favorites;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          "Your Favorites",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body:
          favoriteItems.isEmpty
              ? const Center(
                child: Text(
                  "No favorites yet...",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: favoriteItems.length,
                itemBuilder: (context, index) {
                  String favId = favoriteItems[index];
                  return FutureBuilder<DocumentSnapshot>(
                    future:
                        FirebaseFirestore.instance
                            .collection('Recipe-Data')
                            .doc(favId)
                            .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.all(20),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return const SizedBox();
                      }

                      var data = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Stack(
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => Detailspage(
                                            documentSnapshot: data,
                                          ),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: data['image'],
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 6,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            bottomLeft: Radius.circular(16),
                                          ),
                                          child: Image.network(
                                            data['image'],
                                            width: 110,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        recipeInfo(data),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Delete icon in top-right
                            dltButton(provider, data),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
    );
  }

  Positioned dltButton(Favprovider provider, DocumentSnapshot<Object?> data) {
    return Positioned(
      top: 6,
      right: 6,
      child: GestureDetector(
        onTap: () {
          setState(() {
            provider.toggleFav(data);
          });
        },
        child: const CircleAvatar(
          radius: 16,
          backgroundColor: Colors.white,
          child: Icon(Iconsax.trash, color: Colors.red, size: 18),
        ),
      ),
    );
  }

  Expanded recipeInfo(DocumentSnapshot<Object?> data) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data['name'],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Iconsax.flash_1, size: 16, color: Colors.orange),
                const SizedBox(width: 4),
                Text(
                  "${data['cal']} Cal",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 12),
                Icon(Iconsax.tag, size: 16, color: Colors.teal),
                const SizedBox(width: 4),
                Text(
                  data['category'],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Iconsax.star_15, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      "${data['rating']}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${data['reviews']} reviews",
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
