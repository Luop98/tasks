import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tasks/models/task_model.dart';
import 'package:tasks/ui/general/colors.dart';
import 'package:tasks/ui/widgets/button_normal_widget.dart';
import 'package:tasks/ui/widgets/general_widget.dart';
import 'package:tasks/ui/widgets/item_task_widget.dart';
import 'package:tasks/ui/widgets/textfield_normal_widget.dart';

import '../ui/widgets/task_form_widget.dart';

class HomePage extends StatelessWidget {
  CollectionReference tasksReference =
      FirebaseFirestore.instance.collection('tasks');

  showTaskFrom(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return TaskFormWidget();
     
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBranSecondaryColor,
      floatingActionButton: InkWell(
        onTap: () {
          showTaskFrom(context);
        },
        borderRadius: BorderRadius.circular(14.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: kBranPrimaryColor,
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              Text(
                "Nueva Traea",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 22.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bienvenido Ramon",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: kBranPrimaryColor,
                      ),
                    ),
                    Text(
                      "Mis Tareas",
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff2c3550),
                      ),
                    ),
                    divider10(),
                    TextFieldNormalWidget(
                      icon: Icons.search,
                      hintText: "Buscar tarea..",
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Todas mis tareas",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: kBranPrimaryColor.withOpacity(0.85),
                    ),
                  ),
                  StreamBuilder(
                    stream: tasksReference.snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snap) {
                      if (snap.hasData) {
                        List<TaskModel> tasks = [];
                        QuerySnapshot collection = snap.data;
                        /*
                        collection.docs.forEach((element) { 
                          Map <String, dynamic> myMap = element.data() as Map <String, dynamic>;
                          tasks.add(TaskModel.fromJson(myMap));
                        });*/

                        tasks = collection.docs
                            .map((e) => TaskModel.fromJson(
                                e.data() as Map<String, dynamic>))
                            .toList();

                        return ListView.builder(
                          itemCount: tasks.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return ItemTaskWidget(
                              taskModel: tasks[index],
                            );
                          },
                        );
                      }
                      return loadinWidget();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      /*body: StreamBuilder(
      stream: tasksReference.snapshots(),
      builder: (BuildContext context, AsyncSnapshot snap){
        if(snap.hasData){
          QuerySnapshot collection = snap.data;
          List<QueryDocumentSnapshot> docs =collection.docs;
          List<Map<String, dynamic>> docsMap = docs.map((e) => e.data() as Map<String, dynamic>).toList();
          print(docsMap);
          return ListView.builder(
            itemCount: docsMap.length,
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                title: Text(docsMap[index]["title"]),
              );
            },
          );
              }
        return Center(child: CircularProgressIndicator(),);
      },
    ),*/
    );
  }
}
