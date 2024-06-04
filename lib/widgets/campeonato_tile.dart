import 'package:flutter/material.dart';

class CampeonatoTile extends StatefulWidget {
  final String nombre;
  final String reglas;
  final String premios;
  final int id;

  const CampeonatoTile({this.nombre='sin nombre',this.reglas='sin reglas', this.premios='sin premios', required this.id});

  @override
  State<CampeonatoTile> createState() => _CampeonatoTileState();
}

class _CampeonatoTileState extends State<CampeonatoTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: EdgeInsets.fromLTRB(5, 5, 5, 1),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xDDFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        children: [
        Container(child: Text(' ${this.widget.nombre}')),
        Text(' ${this.widget.reglas}'),
        Text(' ${this.widget.premios}'),
        ],
      ),
    );
  }
}