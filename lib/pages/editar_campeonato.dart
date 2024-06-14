import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/http_service.dart';
import 'package:google_fonts/google_fonts.dart';

class EditarCampeonatoPage extends StatefulWidget {
  final int id;
  final String nombre;
  final String juego;
  final String reglas;
  final String premios;

  const EditarCampeonatoPage({
    required this.id,
    required this.nombre,
    required this.juego,
    required this.reglas,
    required this.premios,
  });

  @override
  State<EditarCampeonatoPage> createState() => _EditarCampeonatoPageState();
}

class _EditarCampeonatoPageState extends State<EditarCampeonatoPage> {
  late TextEditingController nombreController;
  late TextEditingController juegoController;
  late TextEditingController reglasController;
  late TextEditingController premiosController;

  String errNombre = "";
  String errJuego = "";
  String errReglas = "";
  String errPremios = "";

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.nombre);
    juegoController = TextEditingController(text: widget.juego);
    reglasController = TextEditingController(text: widget.reglas);
    premiosController = TextEditingController(text: widget.premios);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar campeonatos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                labelStyle: GoogleFonts.oswald(
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                errorText: errNombre.isNotEmpty ? errNombre : null,
              ),
              onChanged: (value) {
                setState(() {
                  errNombre = value.isEmpty ? 'Ingrese un nombre' : '';
                });
              },
            ),
            TextField(
              controller: juegoController,
              decoration: InputDecoration(
                labelText: 'Juego',
                labelStyle: GoogleFonts.oswald(
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                errorText: errJuego.isNotEmpty ? errJuego : null,
              ),
              onChanged: (value) {
                setState(() {
                  errJuego = value.isEmpty ? 'Ingrese un juego' : '';
                });
              },
            ),
            TextField(
              controller: reglasController,
              decoration: InputDecoration(
                labelText: 'Reglas',
                labelStyle: GoogleFonts.oswald(
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                errorText: errReglas.isNotEmpty ? errReglas : null,
              ),
              onChanged: (value) {
                setState(() {
                  errReglas = value.isEmpty ? 'Ingrese unas reglas' : '';
                });
              },
            ),
            TextField(
              controller: premiosController,
              decoration: InputDecoration(
                labelText: 'Premios',
                labelStyle: GoogleFonts.oswald(
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                errorText: errPremios.isNotEmpty ? errPremios : null,
              ),
              onChanged: (value) {
                setState(() {
                  errPremios = value.isEmpty ? 'Ingrese premios' : '';
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              onPressed: () async {
                setState(() {
                  errNombre = nombreController.text.isEmpty ? 'Ingrese un nombre' : '';
                  errJuego = juegoController.text.isEmpty ? 'Ingrese un juego' : '';
                  errReglas = reglasController.text.isEmpty ? 'Ingrese unas reglas' : '';
                  errPremios = premiosController.text.isEmpty ? 'Ingrese premios' : '';
                });

                if (errNombre.isEmpty && errJuego.isEmpty && errReglas.isEmpty && errPremios.isEmpty) {
                  try {
                    var respuesta = await HttpService().updateCampeonato(
                      widget.id,
                      nombreController.text,
                      juegoController.text,
                      reglasController.text,
                      premiosController.text,
                    );

                    if (respuesta == 'Error') {
                      print("Hubo un error al actualizar el campeonato.");
                    } else {
                      setState(() {});
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    print('Error en la solicitud: $e');
                  }
                }
              },
              child: Text(
                'Guardar',
                style: GoogleFonts.oswald(
                  textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
