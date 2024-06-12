import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/equipos_perfil.dart';
import 'package:google_fonts/google_fonts.dart';

class EquipoTile extends StatefulWidget {
  final String nombre;
  final String descripcion;
  final int id;

  const EquipoTile({this.nombre='sin nombre', this.descripcion='sin descripcion', required this.id});


  @override
  State<EquipoTile> createState() => _EquipoTileState();
}

class _EquipoTileState extends State<EquipoTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(10),    
          decoration: BoxDecoration(
            color: Color.fromRGBO(87, 86, 86, 0.9),
            border:Border.all(color: Colors.black),
            borderRadius: BorderRadius.all( Radius.circular(10))
          ),
      child: Column(children: [
        Container(
          color: Color.fromRGBO(87, 86, 86, 0.9),
          child: Text('Equipo', style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 20, color: Colors.white))),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.8),
            borderRadius: BorderRadius.only()
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${this.widget.nombre}', style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),),
            ],
          )),
          Container(
            color: const Color.fromRGBO(255, 255, 255, 0.8),
            child: Divider(color: Colors.black)),
          Container(
            decoration: BoxDecoration(
              color:const Color.fromRGBO(255, 255, 255, 0.8)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${this.widget.descripcion}',style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16))),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EquipoPerfil(equipo_id: widget.id),
                  ),
                );
              },
              child: Text('Jugadores del equipo', style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16, color: Colors.black))),
            ),
          ),
      ],),
    );
    
  }
}