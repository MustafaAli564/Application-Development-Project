import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favprovider extends ChangeNotifier{
  List<String> _favoriteIds = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> get favorites => _favoriteIds;


  Favprovider(){
    loadFavorites();
  }

  void toggleFav(DocumentSnapshot product) async{
    String prodId = product.id;
    if(_favoriteIds.contains(prodId)){
      _favoriteIds.remove(prodId);
      await _removeFav(prodId);
    }else{
      _favoriteIds.add(prodId);
      await _addFav(prodId);
    }
    notifyListeners();
  }
  bool exists(DocumentSnapshot meal){
    return _favoriteIds.contains(meal.id);
  }

  Future<void> _addFav(String prodId) async{
    try{  
      await _firestore.collection("favs").doc(prodId).set({
        'isfavorite': true,
      });
    }catch(e){
      print(e.toString());
    }
  }

  Future<void> _removeFav(String prodId) async{
    try{  
      await _firestore.collection("favs").doc(prodId).delete();
    }catch(e){
      print(e.toString());
    }
  }

  Future<void> loadFavorites() async{
    try{
      QuerySnapshot snapshot = await _firestore.collection("favs").get();
      _favoriteIds = snapshot.docs.map((doc) => doc.id).toList();
    }catch(e){
      print(e.toString());
    }
    notifyListeners();
  }

  static Favprovider of(BuildContext context, {bool listen = true}){
    return Provider.of<Favprovider>(context, listen: listen);
  }
}