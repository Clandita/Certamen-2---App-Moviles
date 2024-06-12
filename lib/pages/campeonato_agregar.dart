import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/http_service.dart'; // Asegúrate de importar http_service.dart

class CampeonatoAgregar extends StatefulWidget {
  const CampeonatoAgregar({super.key});

  @override
  State<CampeonatoAgregar> createState() => _CampeonatoAgregarState();
}

class _CampeonatoAgregarState extends State<CampeonatoAgregar> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController juegoController = TextEditingController();
  TextEditingController reglasController = TextEditingController();
  TextEditingController premiosController = TextEditingController();
  
  String errNombre = "";
  String errJuego = "";
  String errReglas = "";
  String errPremios = "";
  String errGeneral = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Nuevo campeonato"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            Text("Agregar nombre:"),
            TextFormField(
              decoration: InputDecoration(labelText: "Nombre"),
              controller: nombreController,
            ),
            Text(
              errNombre,
              style: TextStyle(color: Colors.red),
            ),
            Text("Agregar que juego es:"),
            TextFormField(
              decoration: InputDecoration(labelText: "Juego"),
              controller: juegoController,
            ),
            Text(
              errJuego,
              style: TextStyle(color: Colors.red),
            ),
            Text("Reglas:"),
            TextFormField(
              decoration: InputDecoration(labelText: "Reglas"),
              controller: reglasController,
            ),
            Text(
              errReglas,
              style: TextStyle(color: Colors.red),
            ),
            Text("Premios:"),
            TextFormField(
              decoration: InputDecoration(labelText: "Premios"),
              controller: premiosController,
            ),
            Text(
              errPremios,
              style: TextStyle(color: Colors.red),
            ),
            Text(
              errGeneral,
              style: TextStyle(color: Colors.red),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: FilledButton(
                child: Text("Agregar Campeonato"),
                onPressed: () async {
                  var respuesta = await HttpService().campeonatosAgregar(
                    nombreController.text,
                    juegoController.text,
                    reglasController.text,
                    premiosController.text
                  );
                  if (respuesta['message'] != null) { // Verifica si hay un mensaje de error en la respuesta
                  } else {
                    Navigator.pop(context); // Cierra la pantalla actual si la respuesta es exitosa
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
