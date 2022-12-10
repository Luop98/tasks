import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasks/pages/register_pages.dart';
import 'package:tasks/ui/general/colors.dart';
import 'package:tasks/ui/widgets/button_normal_widget.dart';
import 'package:tasks/ui/widgets/general_widget.dart';
import 'package:tasks/ui/widgets/textfield_normal_widget.dart';
import 'package:tasks/ui/widgets/textfield_password_widget.dart';

import '../ui/widgets/button_custom_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.all(16.0),
          child: Column(
            children: [
              divider120(),
              /*SvgPicture.asset(
                'asset/images/login.svg',
                height: 180.0,
              ),*/
              divider30(),
              Text(
                "Iniciar Sesion",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: kBranPrimaryColor,
                ),
              ),
              divider10(),
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
                text: "Iniciar Sesion",
                icon: "check",
                color: kBranPrimaryColor,
              ),
              divider20(),
              Text(
                "O ingresa con tus redes sociales",
              ),
              divider20(),
              ButtonCustonWidget(
                text: "Iniciar sesión con Google",
                icon: "google",
                color: Color(0xfff84b2a),
              ),
              divider20(),
              ButtonCustonWidget(
                text: "Iniciar sesión con Facebook",
                icon: "facebook",
                color: Color(0xff507cc0),
              ),
              divider20(),
              Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Text(
                    "Aún no estas registraado?   ",
                  ),
                  divider10Width(),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPages()));
                    },
                    child: Text(
                      "Registrate",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: kBranPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
