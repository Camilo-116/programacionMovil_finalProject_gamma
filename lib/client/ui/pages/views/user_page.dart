import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gamma/client/ui/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../server/models/user_model.dart';

class UserPage extends StatefulWidget {
  UserPage({
    Key? key,
    required this.user,
  }) : super(key: key);
  UserModel user;
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // final double coverHeight = 280;
  final double profileHeight = 120;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    log('Height: $height');
    log('Width: $width');

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 34, 15, 57),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: (10 / 756) * height),
            child: buildCover(width, height),
          ),
          buildAccountStats(width, height),
          buildEditProfile(width, height),
          buildContent(width, height),
          SizedBox(
            height: height * 0.1,
          ),
        ],
      ),
    );
  }

  Widget buildCover(double width, double height) {
    UserController userController = Get.find();
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: (15 / 756) * height,
            left: (10 / 360) * width,
          ),
          child: CircleAvatar(
            radius: ((profileHeight / 756) * height) / 2,
            backgroundColor: const Color.fromARGB(255, 97, 24, 180),
            child: CircleAvatar(
                radius: (((profileHeight / 756) * height) / 2) - 8,
                backgroundColor: Colors.grey.shade800,
                backgroundImage: AssetImage(
                  widget.user.profilePhoto,
                )),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: (20 / 360) * width),
              child: Text(
                widget.user.username,
                style: GoogleFonts.hind(
                  color: Colors.white,
                  fontSize: (24 / 360) * width,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              children: [
                Obx(
                  () => Container(
                      margin: EdgeInsets.only(
                        left: (20 / 360) * width,
                        right: (5 / 360) * width,
                      ),
                      width: (20 / 360) * width,
                      height: (20 / 756) * height,
                      decoration: BoxDecoration(
                        color: (userController.loggedUserStatus == 'Online')
                            ? Colors.green
                            : (userController.loggedUserStatus == 'Offline' ||
                                    userController.loggedUserStatus ==
                                        'Invisible')
                                ? Colors.grey
                                : (userController.loggedUserStatus == 'Busy')
                                    ? Colors.red
                                    : Colors.amber,
                        shape: BoxShape.circle,
                      )),
                ),
                Container(
                  padding: EdgeInsets.only(top: (2.0 / 756) * height),
                  child: TextButton(
                    onPressed: () async {
                      userController.changeStatus(
                          await _dialogBuilder(context) ?? widget.user.status);
                      log('Change status to: ${userController.loggedUserStatus}');
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: (10 / 756) * height,
                        horizontal: (15 / 360) * width,
                      ),
                      backgroundColor: const Color.fromARGB(255, 54, 9, 91),
                      minimumSize: const Size(100, 40),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: Obx(
                      () => Text(
                        userController.loggedUserStatus,
                        style: GoogleFonts.hind(
                            color: const Color.fromARGB(255, 241, 219, 255),
                            fontWeight: FontWeight.bold,
                            fontSize: (16 / 360) * width),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: (20 / 360) * width,
                    top: (10 / 756) * height,
                  ),
                  child: Text(
                    widget.user.email,
                    style: GoogleFonts.hind(
                      color: Colors.white,
                      fontSize: (16 / 360) * width,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget buildAccountStats(double width, double height) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildStatColumn('Publicaciones', 190, width, height),
          buildStatColumn('Seguidores', 1505, width, height),
          buildStatColumn('Seguidos', 3054, width, height),
        ],
      );

  Widget buildStatColumn(String label, int count, double width, double height) {
    return Container(
        width: width * 0.3,
        padding: EdgeInsets.only(top: 0.0132 * height),
        child: TextButton(
          onPressed: () {
            log('$label Column Pressed');
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.0132, horizontal: width * 0.0138),
            backgroundColor: const Color.fromARGB(255, 54, 9, 91),
            minimumSize: const Size(150, 50),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          child: Text(
            '$count\n$label',
            textAlign: TextAlign.center,
            style: GoogleFonts.hind(
                color: const Color.fromARGB(255, 241, 219, 255),
                fontWeight: FontWeight.bold,
                fontSize: width * 0.042),
          ),
        ));
  }

  Widget buildEditProfile(double width, double height) => Padding(
        padding: EdgeInsets.only(
            top: height * 0.0264, left: width * 0.11, right: width * 0.11),
        child: Center(
          child: TextButton(
            onPressed: () {
              log('Edit Button Pressed');
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  vertical: 0.0132, horizontal: 0.0416),
              backgroundColor: const Color.fromARGB(255, 54, 9, 91),
              minimumSize: const Size(470, 60),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            child: Text(
              'Editar Perfil',
              style: GoogleFonts.hind(
                  color: const Color.fromARGB(255, 241, 219, 255),
                  fontWeight: FontWeight.bold,
                  fontSize: (20 / 360) * width),
            ),
          ),
        ),
      );

  Widget buildContent(double width, double height) => Column(
        children: [
          const Divider(),
          Text('Plataformas',
              textAlign: TextAlign.left,
              style: GoogleFonts.hind(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: (20 / 360) * width)),
          Container(
            color: const Color.fromARGB(255, 54, 9, 91),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildImg('assets/images/xbox.png', width, height),
                buildImg('assets/images/playstation.png', width, height),
                buildImg('assets/images/switch.png', width, height),
              ],
            ),
          ),
          const Divider(),
          Text('Juegos',
              textAlign: TextAlign.left,
              style: GoogleFonts.hind(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: (20 / 360) * width)),
          Container(
            color: const Color.fromARGB(255, 54, 9, 91),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildImg('assets/images/rl.png', width, height),
                buildImg('assets/images/valorant.png', width, height),
                buildImg('assets/images/fallguys.png', width, height),
              ],
            ),
          ),
        ],
      );

  Widget buildImg(String img, double width, double height) => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          img,
          fit: BoxFit.cover,
          width: (100 / 360) * width,
          height: (150 / 756) * height,
        ),
      );

  Future<String?> _dialogBuilder(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        return SimpleDialog(
          title: const Text(
            'Cambiar estado.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 64, 32, 104),
          elevation: 24,
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Online');
              },
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: width * 0.00555),
                      child: Icon(
                        Icons.circle,
                        color: Colors.green,
                        size: width * 0.0444,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: 'Online',
                    style: GoogleFonts.hind(
                      color: Colors.white,
                      fontSize: width * 0.0444,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ]),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Invisible');
              },
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: width * 0.00555),
                      child: Icon(
                        Icons.circle_outlined,
                        color: Colors.grey,
                        size: width * 0.0444,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: 'Invisible',
                    style: GoogleFonts.hind(
                      color: Colors.white,
                      fontSize: width * 0.0444,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ]),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Busy');
              },
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: width * 0.00555),
                      child: Icon(
                        Icons.circle,
                        color: Colors.red,
                        size: width * 0.0444,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: 'Busy',
                    style: GoogleFonts.hind(
                      color: Colors.white,
                      fontSize: width * 0.0444,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ]),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Away');
              },
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: width * 0.00555),
                      child: Icon(
                        Icons.circle,
                        color: Colors.amber,
                        size: width * 0.0444,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: 'Away',
                    style: GoogleFonts.hind(
                      color: Colors.white,
                      fontSize: width * 0.0444,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ]),
              ),
            ),
          ],
        );
      },
    );
  }
}
