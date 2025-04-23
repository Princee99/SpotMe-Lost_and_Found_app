import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference itemsCollection =
      FirebaseFirestore.instance.collection('items');

  // Add a new item to Firestore
  Future<void> addItem({
    required String type,
    required String name,
    required String location,
    required String date,
    required String area,
    required String contact,
    required String description,
    required String userId,
    String? imageUrl,
  }) async {
    try {
      await itemsCollection.add({
        'type': type,
        'name': name,
        'location': location,
        'date': date,
        'area': area,
        'contact': contact,
        'description': description,
        'userID': userId,
        'imageUrl': imageUrl ?? '',
      });
    } catch (e) {
      print("Error adding item: $e");
      throw e;
    }
  }

  // Fetch all items (lost or found)
  Stream<QuerySnapshot> getItems(String type) {
    return itemsCollection.where('type', isEqualTo: type).snapshots();
  }
}
