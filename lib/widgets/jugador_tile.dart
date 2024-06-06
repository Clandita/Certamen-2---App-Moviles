import 'package:flutter/material.dart';
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
            color: Colors.blue,
            border:Border.all(color: Colors.black),
            borderRadius: BorderRadius.all( Radius.circular(10))
          ),
      child: Column(children: [

        Container(
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.only( topLeft: Radius.circular(10), topRight: Radius.circular(10))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${this.widget.nombre} '+'${this.widget.apellido}'),
            ],
          )),
          Container(
          decoration: BoxDecoration(
            color: Colors.amber,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${this.widget.nickname}'),
            ],
          )),
          
          Container(
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.only( bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${this.widget.rut}'),
            ],
          )),


      ],),
    );
    
  }
}