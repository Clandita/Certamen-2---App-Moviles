import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/http_service.dart';
import 'package:google_fonts/google_fonts.dart';

class EditarCampeonatoPage extends StatefulWidget {
  final int id;
  final String nombre;
  final String juego;
  final String reglas;
  final String premios;


  const EditarCampeonatoPage({required this.id, required this.nombre,required this.juego,required this.reglas,required this.premios });

  @override
  State<EditarCampeonatoPage> createState() => _EditarCampeonatoPageState();
}

class _EditarCampeonatoPageState extends State<EditarCampeonatoPage> {
  
  late TextEditingController idController;
  late TextEditingController nombreController;
  late TextEditingController juegoController;
  late TextEditingController reglasController;
  late TextEditingController premiosController;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController(text: widget.id.toString());
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
                labelStyle:GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
            ),
            TextField(
              controller: juegoController,
              decoration: InputDecoration(
                labelText: 'Juego',
                labelStyle:GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
            ),
            TextField(
              controller: reglasController,
              decoration: InputDecoration(
                labelText: 'Reglas',
                labelStyle:GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
            ),
            TextField(
              controller: premiosController,
              decoration: InputDecoration(
                labelText: 'Premios',
                labelStyle:GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey
              ),
              onPressed: () async {
                  var respuesta = await HttpService().updateCampeonato(
                    int.parse(idController.text),
                    nombreController.text,
                    juegoController.text,
                    reglasController.text,
                    premiosController.text
                  );
                  print('siiii');
                  if (respuesta == 'Error') {
                    print('nooo');
                    
                  } else {
                    setState(() {});
                    Navigator.pop(context);
                  }
                },
              child: Text('Guardar', style:GoogleFonts.oswald(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))),
            ),
          ],
        ),
      ),
    );
  }
}