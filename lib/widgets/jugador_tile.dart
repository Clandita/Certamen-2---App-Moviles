import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class JugadorTile extends StatefulWidget {
  
  final String rut;
  final String nombre;
  final String apellido;
  final String nickname; 

  const JugadorTile({this.nombre='sin nombre',this.rut='sin rut',this.apellido='sin apellido', this.nickname='sin nickname',});

  @override
  State<JugadorTile> createState() => _JugadorTileState();
}

class _JugadorTileState extends State<JugadorTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(10),    
          decoration: BoxDecoration(
            color: Color.fromRGBO(158, 158, 158, 0.8),
            border:Border.all(color: Colors.black),
            borderRadius: BorderRadius.all( Radius.circular(10))
          ),
      child: Column(children: [

        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromRGBO(158, 158, 158, 0.8),
            borderRadius: BorderRadius.only( topLeft: Radius.circular(10), topRight: Radius.circular(10))
          ),
          child: Row(
        
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/user.png'),
              )
            ],
          )),
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
            ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${this.widget.nombre} '+'${this.widget.apellido}', style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white))),
            ],
          )),
          Container(
            child: Text('Nickname:',style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          ),
          Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${this.widget.nickname}',style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
            ],
          )),
      ],),
    );
    
  }
}