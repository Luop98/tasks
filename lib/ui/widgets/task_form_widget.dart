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
 
  final formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descrptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String categorySelectd = "Personal";


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
            data: ThemeData.light().copyWith(
              dialogBackgroundColor: Colors.white,
              dialogTheme: DialogTheme(
                elevation: 0,
                backgroundColor:kBranPrimaryColor ,
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

        if(datetime!=null){
          _dateController.text = datetime.toString().substring(0, 10);
          setState(() {}) ;
        }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22.0),
          topRight: Radius.circular(22.0),
        ),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
         const   Text(
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
              controller: _titleController,
            ),
            divider10(),
            TextFieldNormalWidget(
              hintText: "Description",
              icon: Icons.description,
              controller: _descrptionController,
            ),
            divider10(),
          const  Text("Categoria: "),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.start,
              spacing: 10.0,
              children: [
                FilterChip(
                  selected: categorySelectd=="Personal",
                  backgroundColor: kBranSecondaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  selectedColor: categoryColor[categorySelectd],
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color:categorySelectd=="Personal" ? Colors.white: kBranPrimaryColor,
                  ),
                  label: Text("Personal"),
                  onSelected: (bool value) {
                    categorySelectd = "Personal";
                    setState(() {});
                  },
                ),
                FilterChip(
                  selected: categorySelectd=="Trabajo",
                  backgroundColor: kBranSecondaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  selectedColor: categoryColor[categorySelectd],
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color:categorySelectd=="Trabajo" ? Colors.white: kBranPrimaryColor,
                  ),
                  label: Text("Trabajo"),
                  onSelected: (bool value) {
                    categorySelectd = "Trabajo";
                    setState(() {});
                  },
                ),
                 FilterChip(
                  selected: categorySelectd=="Otro",
                  backgroundColor: kBranSecondaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  selectedColor: categoryColor[categorySelectd],
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color:categorySelectd=="Otro" ? Colors.white: kBranPrimaryColor,
                  ),
                  label: Text("Otro"),
                  onSelected: (bool value) {
                    categorySelectd = "Otro";
                    setState(() {});
                  },
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
              controller: _dateController,
            ),
            divider20(),
            ButtonNormalWidget(
              onPressed: (){
                if(formKey.currentState!.validate()){
                  
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
