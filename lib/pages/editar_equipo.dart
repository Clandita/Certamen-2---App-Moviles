import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/http_service.dart';

class EquipoEditar extends StatefulWidget {
  final int id;
  final String nombre;
  final String descripcion;


  EquipoEditar({required this.id, required this.nombre, required this.descripcion});

  @override
  State<EquipoEditar> createState() => _EquipoEditarState();
}

class _EquipoEditarState extends State<EquipoEditar> {
  late TextEditingController idController;
  late TextEditingController nombreController;
  late TextEditingController descripcionController;
  

  @override
  void initState() {
    super.initState();
    idController=TextEditingController(text: widget.id.toString());
    nombreController = TextEditingController(text: widget.nombre);
    descripcionController = TextEditingController(text: widget.descripcion);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Equipo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre del Equipo',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: descripcionController,
              decoration: InputDecoration(
                labelText: 'Descripción del Equipo',
              ),
              maxLines: null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var respuesta= await HttpService().updateEquipos(
                  int.parse(idController.text), 
                  nombreController.text, 
                  descripcionController.text,
                );
                if(respuesta=='Error'){
                  print("nooo");
                }else{
                  print('ID : ${idController.text}');

                  Navigator.pop(context); 
                  setState(() {});
                }
            },
              child: Text('Guardar'),
            ),

          ],
        ),
      ),
    );
  }
}
