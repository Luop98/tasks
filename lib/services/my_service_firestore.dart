
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasks/models/task_model.dart';

class MyServiceFirestore{

  String collection;
  MyServiceFirestore({required this.collection});
 late final CollectionReference _collectionReference= FirebaseFirestore.instance.collection(collection); 
  
  //agregar

  Future<String> addTask(TaskModel model)async{
   DocumentReference documentReference = await _collectionReference.add(model.toJson());
   String id = documentReference.id;
   return id;
  }

//delete


// actualizar
}