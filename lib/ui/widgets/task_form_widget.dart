import 'package:flutter/material.dart';

import '../general/colors.dart';
import 'button_normal_widget.dart';
import 'general_widget.dart';
import 'textfield_normal_widget.dart';

class TaskFormWidget extends StatefulWidget {
  const TaskFormWidget({super.key});

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  showSelectDate() async {
    DateTime? datetime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2030),
        cancelText: "Cancelar",
        confirmText: "Aceptar",
        helpText: "Seleccionar Fecha",
        builder: (BuildContext context, Widget? widget) {
          return Theme(
            data: ThemeData.dark().copyWith(
              dialogBackgroundColor: Colors.white,
              dialogTheme: DialogTheme(
                elevation: 0,
                backgroundColor: kBranPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              colorScheme: ColorScheme.dark(
                primary: kBranPrimaryColor,
              ),
              
            ),
            child: widget!,
          );
        },);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22.0),
          topRight: Radius.circular(22.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Agregar tarea",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15.0,
            ),
          ),
          divider10(),
          TextFieldNormalWidget(
            hintText: "Titulo",
            icon: Icons.text_fields,
          ),
          divider10(),
          TextFieldNormalWidget(
            hintText: "Description",
            icon: Icons.description,
          ),
          divider10(),
          Text("Categoria: "),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.start,
            spacing: 10.0,
            children: [
              FilterChip(
                selected: true,
                backgroundColor: kBranSecondaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                selectedColor: categoryColor["Personal"],
                checkmarkColor: Colors.white,
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                label: Text("Personal"),
                onSelected: (bool value) {},
              ),
              FilterChip(
                selected: true,
                backgroundColor: kBranSecondaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                selectedColor: categoryColor["Trabajo"],
                checkmarkColor: Colors.white,
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                label: Text("Trabajo"),
                onSelected: (bool value) {},
              ),
              FilterChip(
                selected: true,
                backgroundColor: kBranSecondaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                selectedColor: categoryColor["Otro"],
                checkmarkColor: Colors.white,
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                label: Text("Otro"),
                onSelected: (bool value) {},
              ),
            ],
          ),
          divider10(),
          TextFieldNormalWidget(
            hintText: "Fecha",
            icon: Icons.date_range,
            onTap: () {
              showSelectDate();
            },
          ),
          divider20(),
          ButtonNormalWidget(),
        ],
      ),
    );
  }
}
