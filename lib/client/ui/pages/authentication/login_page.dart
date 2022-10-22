import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gamma/client/ui/controllers/authentication_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../home_pages/home.dart';
import 'signup_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  bool _isObscure = true;
  AuthenticationController authentication_controller = Get.find();
  final textControllers = [TextEditingController(), TextEditingController()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 89, 147, 218),
                  Color.fromARGB(255, 78, 140, 212),
                  Color.fromARGB(255, 55, 117, 192),
                  Color.fromARGB(255, 37, 103, 177),
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
          ),
          SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(40.0, 70, 40, 30.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Inicio de sesión',
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      _buildTF('Nombre de Usuario', Icons.person, false,
                          textControllers[0]),
                      const SizedBox(height: 20.0),
                      _buildTF('Contraseña', Icons.lock, _isObscure,
                          textControllers[1]),
                      _buildForgotBtn(textControllers),
                      _buildRememberMeBtn(),
                      _buildLoginBtn(textControllers),
                      _buildSignWith(textControllers),
                    ]),
              ))
        ]),
      ),
    );
  }

  Widget _buildTF(String nCampo, IconData icon, bool obscure,
      TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          nCampo,
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: const Color.fromARGB(69, 255, 255, 255),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            autocorrect: false,
            enableSuggestions: false,
            obscureText: obscure,
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              // contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                icon,
                color: Colors.white,
                size: 25,
              ),
              hintText: 'Ingresa tu ${nCampo.toLowerCase()}',
              hintStyle: GoogleFonts.openSans(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotBtn(List<TextEditingController> controllers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            log('Forgot Password Button Pressed');
            for (var controller in controllers) {
              controller.clear();
            }
          },
          child: Text('¿Olvidaste tu contraseña o usuario?',
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              )),
        ),
      ],
    );
  }

  Widget _buildRememberMeBtn() {
    return SizedBox(
      height: 20.0,
      child: Row(children: <Widget>[
        Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: SizedBox(
              child: Checkbox(
                value: _rememberMe,
                checkColor: Colors.green,
                activeColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value!;
                  });
                },
              ),
            )),
        Text('Mantener sesión iniciada',
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ))
      ]),
    );
  }

  Widget _buildLoginBtn(List<TextEditingController> controllers) {
    return Container(
        padding: const EdgeInsets.only(top: 25.0, bottom: 10),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              log('To Home page');
              if (authentication_controller.login()) {
                for (var controller in controllers) {
                  controller.clear();
                }
              }
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const HomePage()),
              // ).then((value) {

              // });
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              backgroundColor: Colors.white,
            ),
            child: Text('Ingresar',
                style: GoogleFonts.openSans(
                  color: Colors.blueAccent,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ));
  }

  Widget _buildSignWith(List<TextEditingController> controllers) {
    return Column(
      children: <Widget>[
        Text(
          '- O bien -',
          style: GoogleFonts.openSans(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                text: '¿No tienes una cuenta? ',
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  log('To signup page');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  ).then((value) {
                    for (var controller in controllers) {
                      controller.clear();
                    }
                  });
                },
                child: Text('Registrate aquí',
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ))),
            // const Text('¿No tienes una cuenta? ',
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 12.0,
            //         fontWeight: FontWeight.bold,
            //         fontFamily: 'Montserrat')),
          ],
        )
      ],
    );
  }
}
