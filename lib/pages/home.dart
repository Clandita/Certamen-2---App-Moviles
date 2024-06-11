import 'package:flutter/material.dart';

import 'package:flutter_application_1/tabs/calendario_tab.dart';
import 'package:flutter_application_1/tabs/campeonatos_tab.dart';
import 'package:flutter_application_1/tabs/equipos_tab.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child:Scaffold(
        appBar: AppBar(
          title: Text('E-sports' ,style:  GoogleFonts.oswald(textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
          //leading:  
          //Container(child: CircleAvatar(backgroundImage: AssetImage('assets/images/iconito.jpeg'))),
        bottom: TabBar(
          labelStyle: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: [Tab(text:'Campeonatos'),Tab(text:'Equipos'),Tab(text:'Calendario')],
        ),
        ),
        body: TabBarView(children: [CampeonatosTab(),EquiposTab(), CalendarioTab()],),
        )
    );

  }
}