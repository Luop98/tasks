import 'package:flutter/material.dart';

import '../general/colors.dart';

Widget divider3() => const SizedBox(height: 3);
Widget divider6() => const SizedBox(height: 6);
Widget divider10() => const SizedBox(height: 10);
Widget divider20() => const SizedBox(height: 20);
Widget divider30() => const SizedBox(height: 30);
Widget divider40() => const SizedBox(height: 40);
Widget divider120() => const SizedBox(height: 120);

Widget divider3Width() => const SizedBox(height: 3);
Widget divider6Width() => const SizedBox(height: 6);
Widget divider10Width() => const SizedBox(height: 10);
Widget divider20Width() => const SizedBox(height: 20);
Widget divider30Width() => const SizedBox(height: 30);
Widget divider40Width() => const SizedBox(height: 40);

Widget loadinWidget() => Center(
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: kBranPrimaryColor,
          strokeWidth: 2.2,
        ),
      ),
    );


showSnackBarSuccess(BuildContext context, String text){
   ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              backgroundColor: const Color(0xff17c3b2),
              content: Row(
                children: [
                const  Icon(Icons.check, color: Colors.white,),
                  divider10Width(), 
                  Text(text)
                ],
              ),
            ),
          );
}

showSnackBarError(BuildContext context, String text){
   ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              backgroundColor: Colors.redAccent,
              content: Row(
                children: [
                const  Icon(Icons.warning_amber, color: Colors.white,),
                  divider10Width(), 
                  Text(text)
                ],
              ),
            ),
          );
}