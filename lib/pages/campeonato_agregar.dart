import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/http_service.dart';

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
                  setState(() {
                    errNombre = "";
                    errJuego = "";
                    errReglas = "";
                    errPremios = "";
                    errGeneral = "";
                  });

                  String nombre = nombreController.text;
                  String juego = juegoController.text;
                  String reglas = reglasController.text;
                  String premios = premiosController.text;

                  bool hasError = false;

                  if (nombre.isEmpty) {
                    setState(() {
                      errNombre = "Ingrese un nombre al campo";
                    });
                    hasError = true;
                  }
                  if (juego.isEmpty) {
                    setState(() {
                      errJuego = "Ingrese un juego al campo";
                    });
                    hasError = true;
                  }
                  if (reglas.isEmpty) {
                    setState(() {
                      errReglas = "Ingrese una regla al campo";
                    });
                    hasError = true;
                  }
                  if (premios.isEmpty) {
                    setState(() {
                      errPremios = "Ingrese un premio al campo";
                    });
                    hasError = true;
                  }

                  if (!hasError) {
                    var respuesta = await HttpService().campeonatosAgregar(
                      nombre,
                      juego,
                      reglas,
                      premios,
                    );

                    if (respuesta['errors'] != null) {
                      var errores = respuesta['errors'];
                      setState(() {
                        errNombre = errores['nombre'] != null ? errores['nombre'][0] : '';
                        errJuego = errores['juego'] != null ? errores['juego'][0] : '';
                        errReglas = errores['reglas'] != null ? errores['reglas'][0] : '';
                        errPremios = errores['premios'] != null ? errores['premios'][0] : '';
                        errGeneral = errores['general'] != null ? errores['general'][0] : '';
                      });
                      print(errNombre);
                    } else {
                      // todo ok, volver a la pagina que lista
                      Navigator.pop(context);
                    }
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
