import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  CollectionReference tasksReference =
      FirebaseFirestore.instance.collection('tasks');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Firestore"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                tasksReference.get().then((QuerySnapshot value) {
                  /* QuerySnapshot collection = value;
                 List <QueryDocumentSnapshot> docs = collection.docs;
                 print(docs.length);
                 print(docs[0]);
                 QueryDocumentSnapshot doc = docs[0];
                 print(doc.id);*/
                  QuerySnapshot collection = value;
                  collection.docs.forEach(
                    (QueryDocumentSnapshot element) {
                      Map<String, dynamic> myMap =
                          element.data() as Map<String, dynamic>;
                      print(myMap["title"]);
                    },
                  );
                });
              },
              child: Text(
                "obtener la data",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                tasksReference.add(
                  {
                    "title": "Ir de compras al super 3",
                    "description": "Debemos de comprar comida para todo el mes",
                  },
                ).then((DocumentReference value) {
                  print(value.id);
                }).catchError((error) {
                  print("Ocurrio un error en el Registro");
                }).whenComplete(() {
                  print("El resgistor a terminado");
                });
              },
              child: Text(
                "Agregar documento",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                tasksReference.doc("oCVGzXDYWhfkZy46leSe").update(
                  {
                    "title": "Ir de paseo",
                    "description": "tenemos que salir muy temprano",
                  },
                ).catchError(
                  (error) {
                    print(error);
                  },
                ).whenComplete(
                  () {
                    print("actulaizacion terminada");
                  },
                );
              },
              child: Text(
                "Actualizar Documento",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                tasksReference.doc("sen3Ig1Ov3cfDlKd0WFK").delete().catchError(
                  (error) {
                    print(error);
                  },
                ).whenComplete(
                  () {
                    print("La eliminacion esta completa");
                  },
                );
              },
              child: Text(
                "Eliminar Documento",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                tasksReference.doc("A0002").set(
                  {
                    "title": "Ir al concierto",
                    "description": "Este fin de semana debemos ir al concierto",
                  },
                ).catchError((error) {
                  print(error);
                }).whenComplete((){
                  print("Creacion completada");
                });
              },
              child: Text(
                "Agregar documneto personalizado",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
