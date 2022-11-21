import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CheckPageContent extends StatelessWidget {
  const CheckPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<dynamic, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('wystąpił błąd'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('ładowanie strony'));
          }
          final documents = snapshot.data!.docs;
          return ListView(
            children: [
              for (final document in documents) ...[
                Center(
                  child: Text(document['title']),
                ),
              ],
            ],
          );
        });
  }
}
