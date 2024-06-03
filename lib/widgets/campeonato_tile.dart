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
    return Container();
  }
}