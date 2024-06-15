import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter_application_1/service/http_service.dart';
import 'package:google_fonts/google_fonts.dart';

class EditarPartido extends StatefulWidget {
  final int partidoId;
  final String lugar;
  

  const EditarPartido({Key? key, required this.partidoId, required this.lugar});

  @override
  _EditarPartidoState createState() => _EditarPartidoState();
}

class _EditarPartidoState extends State<EditarPartido> { 
  final HttpService httpService = HttpService();
  late TextEditingController partidoIdController;
  late TextEditingController lugarController;

  @override
  void initState() {
    super.initState();
    partidoIdController=TextEditingController(text: widget.partidoId.toString());
    lugarController=TextEditingController(text: widget.lugar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Partido'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateTimeField(
              decoration: InputDecoration(labelText: 'Fecha del partido',labelStyle: GoogleFonts.oswald(
                      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    )),
              onDateSelected: (DateTime value){}, selectedDate: DateTime.now()),
            TextFormField(
              controller: lugarController,
              decoration: InputDecoration(labelText: 'Lugar del Partido', labelStyle: GoogleFonts.oswald(
                      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    )),
            ),
           
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {                
                    var respuesta = await HttpService().updatePartidos(
                      int.parse(partidoIdController.text),
                      lugarController.text
                    );
                    if (respuesta == 'Error') {
                    } else {
                      Navigator.pop(context,true);
                    }
                  },            
            
                  child: Text('Guardar Cambios', style: GoogleFonts.oswald(
                      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
