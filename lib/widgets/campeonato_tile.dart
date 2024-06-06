import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/equipos_en_campeonato.dart';

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
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 1),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      decoration: BoxDecoration(
        color: Color(0xDDFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(30)),
        border: Border.all(color: Colors.black),
      ),
      child: ExpansionTile(
        title: Text(widget.nombre, style: TextStyle(fontSize: 20)),
        children: [
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text('Juego: ${widget.juego}', style: TextStyle(fontSize: 16)),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text('Reglas: ', style: TextStyle(fontSize: 16)),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(' ${widget.reglas}', textAlign: TextAlign.justify),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text('Premios: ', style: TextStyle(fontSize: 16)),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(' ${widget.premios}', textAlign: TextAlign.justify),
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
              child: Text('Ver Equipos'),
            ),
          ),
        ],
      ),
    );
  }
}
