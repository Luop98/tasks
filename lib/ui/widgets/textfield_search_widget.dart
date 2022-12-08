import 'package:flutter/material.dart';
import 'package:tasks/ui/general/colors.dart';

class TextFieldSearchWidget extends StatelessWidget {
  const TextFieldSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return    TextField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 20.0,
                          color: kBranPrimaryColor.withOpacity(0.6),
                        ),
                        hintText: "Buscar tarea...",
                        hintStyle: TextStyle(
                          fontSize: 14.0,
                          color: kBranPrimaryColor.withOpacity(0.6),
                        ),
                        filled: true,
                        fillColor: kBranSecondaryColor,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.0),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    );
  }
}