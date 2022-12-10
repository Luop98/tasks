import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../ui/general/colors.dart';
import '../ui/widgets/button_custom_widget.dart';
import '../ui/widgets/general_widget.dart';
import '../ui/widgets/textfield_normal_widget.dart';
import '../ui/widgets/textfield_password_widget.dart';

class RegisterPages extends StatefulWidget {
  const RegisterPages({super.key});

  @override
  State<RegisterPages> createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages> {
  final keyForm = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  _registerUser()async {
  try{
     if(keyForm.currentState!.validate()){
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
     }
  }on FirebaseAuthException catch(error){
    if(error.code == "weak-password"){
      showSnackBarError(context, "La contraseña es muy debil");
    }else if(error.code == "email-already-in-use"){
      showSnackBarError(context, "El correo electronico ya esta siendo usado");
    }
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: keyForm,
            child: Column(
              children: [
                divider120(),
                SvgPicture.asset(
                  'asset/images/login.svg',
                  height: 180.0,
                ),
                divider30(),
                Text(
                  "Registrate",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: kBranPrimaryColor,
                  ),
                ),
                divider20(),
                TextFieldNormalWidget(
                  hintText: "Nombre Completo",
                  icon: Icons.email,
                  controller: _fullNameController,
                ),
                divider10(),
                divider6(),
                TextFieldNormalWidget(
                  hintText: "Correo electronico",
                  icon: Icons.email,
                  controller: _emailController,
                ),
                divider10(),
                divider6(),
                TextFieldPasswordWidget(
                  controller: _passwordController,
                ),
                divider20(),
                ButtonCustonWidget(
                  text: "Registrate Ahora",
                  icon: "check",
                  color: kBranPrimaryColor,
                  onPressed: (){
                    _registerUser();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
