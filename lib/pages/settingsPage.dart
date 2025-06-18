// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// class Settingspage extends StatelessWidget {
//   const Settingspage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Lottie.asset(
//               'animations/coming_soon.json',
//               width: 250,
//               height: 250,
//               fit: BoxFit.contain,
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Settings Coming Soon!',
//               style: TextStyle(
//                 fontSize: 25,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 10),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 'We are building an amazing profile experience for you to manage your account!',
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.normal,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Settingspage extends StatefulWidget {
  const Settingspage({super.key});

  @override
  State<Settingspage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<Settingspage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  void addRecipe() async {
    if (_formKey.currentState!.validate()) {
      final ingredientsList = ingredientsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      await FirebaseFirestore.instance.collection('Recipe-Data').add({
        'name': nameController.text.trim(),
        'ingredientName': ingredientsList,
        'category': categoryController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Recipe added successfully')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Recipe')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Recipe Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a recipe name' : null,
              ),
              TextFormField(
                controller: ingredientsController,
                decoration: InputDecoration(
                    labelText: 'Ingredients (comma-separated)'),
                validator: (value) => value!.isEmpty
                    ? 'Please enter at least one ingredient'
                    : null,
              ),
              TextFormField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: addRecipe,
                child: Text('Add Recipe'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
