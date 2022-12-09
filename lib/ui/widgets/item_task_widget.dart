import 'package:flutter/material.dart';
import 'package:tasks/models/task_model.dart';
import 'package:tasks/ui/widgets/item_category_widget.dart';

import '../general/colors.dart';
import 'general_widget.dart';

class ItemTaskWidget extends StatelessWidget {
  TaskModel taskModel;

  ItemTaskWidget({required this.taskModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(4, 4),
            blurRadius: 12.0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemCategoryWidget(
                text: taskModel.category,
              ),
              divider3(),
              Text(
                taskModel.title,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: kBranPrimaryColor.withOpacity(0.85),
                ),
              ),
              Text(
                taskModel.description,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: kBranPrimaryColor.withOpacity(0.75),
                ),
              ),
              divider6(),
              Text(
                taskModel.date,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: kBranPrimaryColor.withOpacity(0.75),
                ),
              ),
            ],
          ),
          Positioned(
            top: -10,
            right: -12,
            child: PopupMenuButton(
              elevation: 2,
              color: Colors.white,
              icon: Icon(Icons.more_vert, color: kBranPrimaryColor.withOpacity(0.86)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              onSelected: (value){
                print(value); 
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 1,
                    child: Text(
                      "Editar",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: kBranPrimaryColor.withOpacity(0.85),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value:  2,
                    child: Text(
                      "Finalizar",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: kBranPrimaryColor.withOpacity(0.85),
                      ),
                    ),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
    );
  }
}
