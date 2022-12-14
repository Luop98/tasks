

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tasks/models/user_model.dart';
import 'package:tasks/pages/home_page.dart';
import 'package:tasks/pages/register_pages.dart';
import 'package:tasks/services/my_service_firestore.dart';
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
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);
  MyServiceFirestore userService = MyServiceFirestore(collection: "users");

  _login() async {
    try {
      if (formKey.currentState!.validate()) {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (userCredential.user != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
        }
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "invalid-email") {
        showSnackBarError(context, "El correo electronico es invalido");
      } else if (error.code == "user-not-found") {
        showSnackBarError(context, "El usuario no esta registrado");
      } else if (error.code == "wrong-password ") {
        showSnackBarError(context, "La contrase??a es incorrecta");
      }
    }
  }

  _loginWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    if (googleSignInAccount == null) {
      return;
    }
    GoogleSignInAuthentication _googleSignInAuth =
        await googleSignInAccount.authentication;

    OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: _googleSignInAuth.idToken,
      accessToken: _googleSignInAuth.accessToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (userCredential.user != null) {
      UserModel userModel = UserModel(
        fullName: userCredential.user!.displayName!,
        email: userCredential.user!.email!,
      );
      userService.existkUser(userCredential.user!.email!).then((value){
        if(!value){
          userService.addUser(userModel).then((value) {
         if(value.isNotEmpty){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
            }
      });
        }else {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
        }
      });
    }
  }

  _loginWithFacebook() async {
    LoginResult _loginResult = await FacebookAuth.instance.login();
   if(_loginResult.status== LoginStatus.success){
   Map<String, dynamic> userData = await  FacebookAuth.instance.getUserData();
   
    AccessToken accessToken = _loginResult.accessToken!;

    OAuthCredential credential = FacebookAuthProvider.credential(accessToken.token); 

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

  if (userCredential.user != null) {


      UserModel userModel = UserModel(
        fullName: userCredential.user!.displayName!,
        email: userCredential.user!.email!,
      );
      
      userService.existkUser(userCredential.user!.email!).then((value){
        if(!value){
          userService.addUser(userModel).then((value) {
         if(value.isNotEmpty){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
            }
      });
        }else {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
        }
      });
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
            key: formKey,
            child: Column(
              children: [
                divider120(),
                SvgPicture.asset(
                  'asset/images/login.svg',
                  height: 180.0,
                ),
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
                  onPressed: () {
                    _login();
                  },
                ),
                divider20(),
                Text(
                  "O ingresa con tus redes sociales",
                ),
                divider20(),
                ButtonCustonWidget(
                  text: "Iniciar sesi??n con Google",
                  icon: "google",
                  color: Color(0xfff84b2a),
                  onPressed: () {
                    _loginWithGoogle();
                  },
                ),
                divider20(),
                ButtonCustonWidget(
                  text: "Iniciar sesi??n con Facebook",
                  icon: "facebook",
                  color: Color(0xff507cc0),
                  onPressed: () {
                    _loginWithFacebook();
                  },
                ),
                divider20(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "A??n no estas registraado?   ",
                    ),
                    divider10Width(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPages()));
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
      ),
    );
  }
}
