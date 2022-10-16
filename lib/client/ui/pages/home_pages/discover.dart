import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';

class DiscoverGamers extends StatefulWidget {
  const DiscoverGamers({Key? key}) : super(key: key);

  @override
  _DiscoverGamersState createState() => _DiscoverGamersState();
}

class _DiscoverGamersState extends State<DiscoverGamers> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late SwipeableCardSectionController swipeableStackController;

  @override
  void initState() {
    super.initState();
    swipeableStackController = SwipeableCardSectionController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 26,
            ),
            onPressed: () {
              print('Back home ...');
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          'Descubre',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: const Color(0xFFF5F5F5),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 400,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Image.network(
                          'https://picsum.photos/seed/788/600',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.chevron_left,
                              color: Colors.black,
                              size: 30,
                            ),
                            onPressed: () {
                              print('Left swipe ...');
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 30,
                            ),
                            onPressed: () {
                              print('Add ...');
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.chevron_right,
                              color: Colors.black,
                              size: 30,
                            ),
                            onPressed: () {
                              print('Right swipe ...');
                            },
                          ),
                        ],
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.9, 0),
                        child: Text(
                          'Nombre de Usuario',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.8, 0),
                        child: Text(
                          'Juego favorito:  Rocket League\nRango: Supersonic Legend\nPlataforma: PlayStation 5',
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}