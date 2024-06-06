import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/equipos_perfil.dart';

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
              Text('${this.widget.nombre}'),
            ],
          )),
          Container(
            decoration: BoxDecoration(
              color:Colors.white
            ),
            child: Row(
              children: [
                Text('${this.widget.descripcion}'),
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
              child: Text('Jugadores del equipo'),
            ),
          ),
      ],),
    );
    
  }
}