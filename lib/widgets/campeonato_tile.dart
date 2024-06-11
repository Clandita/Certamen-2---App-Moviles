import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/equipos_en_campeonato.dart';
import 'package:google_fonts/google_fonts.dart';

class CampeonatoTile extends StatefulWidget {
  final String nombre;
  final String juego;
  final String reglas;
  final String premios;
  final int id;

  const CampeonatoTile({this.nombre='sin nombre',this.juego='sin juego',this.reglas='sin reglas', this.premios='sin premios', required this.id});

  @override
  State<CampeonatoTile> createState() => _CampeonatoTileState();
}

class _CampeonatoTileState extends State<CampeonatoTile> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: Container(
        margin: EdgeInsets.fromLTRB(5, 5, 5, 1),
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(color: Colors.black),
        ),
        child: ExpansionTile(
          backgroundColor: Colors.grey,
          title: Center(child: Text(widget.nombre, style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color:Color(0xff142157))))),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
          
              children: [
                Icon(Icons.games_outlined, size: 16,),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Juego', style:  GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(' ${widget.juego}', textAlign: TextAlign.justify, style:  GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16)))
            ),
            Divider(color: Colors.black,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.rule, size: 16,),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Reglas', style:  GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Text(' ${widget.reglas}', textAlign: TextAlign.justify,style:  GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16))),
            ),
            Divider(color: Colors.black),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.gamepad_outlined, size: 16,),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Premios', style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(' ${widget.premios}', textAlign: TextAlign.justify, style:  GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16))),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EquiposCampeonato(campeonato_Id: widget.id),
                    ),
                  );
                },
                child: Text('Equipos Participantes', style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
