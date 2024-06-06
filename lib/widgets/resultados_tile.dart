import 'package:flutter/material.dart';

class ResultadoTile extends StatefulWidget {
  final int equipo_id;
  final int puntos;
  final bool ganador;

  const ResultadoTile({this.equipo_id = 0,this.puntos = 0,this.ganador = false});

  @override
  State<ResultadoTile> createState() => _ResultadoTileState();
}

class _ResultadoTileState extends State<ResultadoTile> { 


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            ),
            Container(
              child: Text('$this.equipo_id'),
            ),
            Container(
              child: Text('$this.puntos'),
            ),
            Container(
              child: Text('$this.ganador'),
            )
        ],
      ),
    );
  }
}
