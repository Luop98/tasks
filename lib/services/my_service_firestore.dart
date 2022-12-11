import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasks/models/task_model.dart';
import 'package:tasks/models/user_model.dart';

class MyServiceFirestore {
  String collection;
  MyServiceFirestore({required this.collection});
  late final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(collection);

  //agregar

  Future<String> addTask(TaskModel model) async {
    DocumentReference documentReference =
        await _collectionReference.add(model.toJson());
    String id = documentReference.id;
    return id;
  }

 Future<void> finishedTask(String taskId) async {
   await _collectionReference.doc(taskId).update(
      {
        "status": false,  
      },
    );
  }

 Future<String> addUser(UserModel userModel)async{
   DocumentReference documentReference = await _collectionReference.add(userModel.toJson());
    return documentReference.id;
  }
  
    Future<bool> existkUser (String email)async{
  QuerySnapshot collection = await  _collectionReference.where("email", isEqualTo: email).get();
  if(collection.docs.isNotEmpty){
      return true;
  }
  return false; 
  }

}
