import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Providers/favProvider.dart';
import 'package:recipe_app/Providers/qty.dart';
import 'package:recipe_app/Widgets/myIconButton.dart';
import 'package:recipe_app/Widgets/quantityChanger.dart';
import 'package:recipe_app/utils/constants.dart';

class Detailspage extends StatefulWidget {
  final DocumentSnapshot<Object?> documentSnapshot;
  const Detailspage({super.key, required this.documentSnapshot});

  @override
  State<Detailspage> createState() => _DetailspageState();
}

class _DetailspageState extends State<Detailspage> {
  @override
  void initState() {
    super.initState();

    final ingredientAmounts =
        widget.documentSnapshot['ingredientsAmount'] as List<dynamic>;

    List<double> baseAmounts =
        ingredientAmounts
            .map<double>((item) => (item['amount'] as num).toDouble())
            .toList();

    Provider.of<QtyProvider>(
      context,
      listen: false,
    ).setBaseIngredientAmounts(baseAmounts);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Favprovider.of(context);
    final qtyProvider = Provider.of<QtyProvider>(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: bottomButtons(provider),
      backgroundColor: const Color(0xFFF6F6F6),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: widget.documentSnapshot['image'],
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.documentSnapshot['image']),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 10,
                  left: 10,
                  child: Row(
                    children: [
                      Myiconbutton(
                        icon: Icons.arrow_back,
                        pressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Spacer(),
                      Myiconbutton(icon: Iconsax.notification, pressed: () {}),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).size.width + 15,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                width: 120,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.documentSnapshot['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(
                        Iconsax.flash_1,
                        size: 20,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${widget.documentSnapshot['cal']} Cal",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black87,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Iconsax.star_15,
                          color: Colors.amber,
                          size: 20,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          "${widget.documentSnapshot['rating']}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        "Ingredients",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Servings",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Quantitychanger(
                            currnumber: qtyProvider.currentNumber,
                            onAdd: () => qtyProvider.incQty(),
                            onRemove: () => qtyProvider.decQty(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Ingredient Images
                      Column(
                        children:
                            (widget.documentSnapshot['ingredientsImage']
                                    as List<dynamic>)
                                .map<Widget>(
                                  (imageUrl) => Container(
                                    height: 60,
                                    width: 60,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(imageUrl),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                      const SizedBox(width: 20),

                      // Ingredient Names
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            (widget.documentSnapshot['ingredientName']
                                    as List<dynamic>)
                                .map<Widget>(
                                  (ingredient) => SizedBox(
                                    height: 60,
                                    child: Center(
                                      child: Text(
                                        ingredient,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                      const SizedBox(width: 20),

                      // Ingredient Amounts with Units (updated)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          (widget.documentSnapshot['ingredientsAmount'] as List)
                              .length,
                          (index) {
                            final amount = double.parse(
                              qtyProvider.updateIngredientAmount[index]
                                  .toString(),
                            ).toStringAsFixed(1);
                            final unit =
                                widget
                                    .documentSnapshot['ingredientsAmount'][index]['unit'];

                            return SizedBox(
                              height: 60,
                              child: Center(
                                child: Text(
                                  "$amount $unit",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton bottomButtons(Favprovider provider) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.transparent,
      elevation: 0,
      onPressed: () {},
      label: Row(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primarycolor,
              padding: const EdgeInsets.symmetric(
                horizontal: 100,
                vertical: 10,
              ),
              foregroundColor: Colors.white,
            ),
            onPressed: () {},
            child: const Text(
              "Lets Start!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            style: IconButton.styleFrom(
              shape: const CircleBorder(
                side: BorderSide(color: Colors.grey, width: 2),
              ),
            ),
            onPressed: () {
              provider.toggleFav(widget.documentSnapshot);
            },
            icon: Icon(
              provider.exists(widget.documentSnapshot)
                  ? Iconsax.heart5
                  : Iconsax.heart,
              color:
                  provider.exists(widget.documentSnapshot)
                      ? Colors.red
                      : Colors.black,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
