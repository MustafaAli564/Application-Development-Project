import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Quantitychanger extends StatelessWidget {
  final int currnumber;
  final Function() onAdd;
  final Function() onRemove;
  const Quantitychanger({
    super.key,
    required this.currnumber,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,),
      decoration: BoxDecoration(
        border: Border.all(width: 2.5,color: Colors.grey),
        borderRadius: BorderRadius.circular(25)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: onRemove, icon: Icon(Iconsax.minus)),
          SizedBox(width: 10,),
          Text(
            "$currnumber",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),

          ),
          SizedBox(width: 10,),
          IconButton(onPressed: onAdd, icon: Icon(Iconsax.add)),
        ],
      ),
    );
  }
}
