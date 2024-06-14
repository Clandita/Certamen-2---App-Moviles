import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/http_service.dart';
import 'package:google_fonts/google_fonts.dart';

class EditarJugadorPage extends StatefulWidget {
  final String rut;
  final String nombre;
  final String apellido;
  final String nickname;

  const EditarJugadorPage({required this.rut, required this.nombre,required this.apellido,required this.nickname});

  @override
  State<EditarJugadorPage> createState() => _EditarJugadorPageState();
}

class _EditarJugadorPageState extends State<EditarJugadorPage> {
  late TextEditingController rutController;
  late TextEditingController nombreController;
  late TextEditingController apellidoController;
  late TextEditingController nicknameController;

  @override
  void initState() {
    super.initState();
    rutController = TextEditingController(text: widget.rut);
    nombreController = TextEditingController(text: widget.nombre);
    apellidoController = TextEditingController(text: widget.apellido);
    nicknameController = TextEditingController(text: widget.nickname);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Jugador',style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
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
              controller: apellidoController,
              decoration: InputDecoration(
                labelText: 'Apellido',
                labelStyle:GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
            ),
            TextField(
              controller: nicknameController,
              decoration: InputDecoration(
                labelText: 'Nickname',
                labelStyle:GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey
              ),
              onPressed: () async {
                  var respuesta = await HttpService().updateJugador(
                    rutController.text,
                    nombreController.text,
                    apellidoController.text,
                    nicknameController.text
                  );
                  print('siiii');
                  if (respuesta == 'Error') {
                    print('nooo');
                    
                  } else {
                    Navigator.pop(context, {
                    'rut': rutController.text,
                    'nombre': nombreController.text,
                    'apellido': apellidoController.text,
                    'nickname': nicknameController.text,
                  });
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