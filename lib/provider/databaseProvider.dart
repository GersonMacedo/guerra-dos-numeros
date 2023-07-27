import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseProvider {
  final User? user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance.collection('users');

  Future<void> saveUserData() async {
    if (user != null) {
      await db.doc(user!.uid).set({
        'name': user!.displayName!,
        'score': 2,
      }).then((value) => print('Database atualizada!'))
          .catchError((error) => print('Erro ao buscar dados do banco: $error'));
    }
  }

  Future<List<Map<String, dynamic>>> getUpdatedDatabase() async {
    final querySnapshot = await db.get();
    await saveUserData();

    // Definindo a lista usersList explicitamente como List<Map<String, dynamic>>
    List<Map<String, dynamic>> usersList = querySnapshot.docs.map((document) {
      return document.data();
    }).toList();

    return usersList;
  }
}
