import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/http_service.dart'; // Asegúrate de importar tu servicio HTTP

class PartidosEquipoPage extends StatefulWidget {
  final int partido_id;
  final int campeonato_id;

  const PartidosEquipoPage({Key? key, required this.partido_id,required this.campeonato_id}) : super(key: key);

  @override
  State<PartidosEquipoPage> createState() => _PartidosEquipoPageState();
}

class _PartidosEquipoPageState extends State<PartidosEquipoPage> {
  
  List<dynamic> _equiposDisponibles = [];
  dynamic selectedEquipo;

  @override
  void initState() {
    super.initState();
    _cargarEquiposDisponibles();
  }

  Future<void> _cargarEquiposDisponibles() async {
    try {
      List<dynamic> equipos = await HttpService().obtenerEquiposPorCampeonato(widget.campeonato_id);
      setState(() {
        _equiposDisponibles = equipos;
      });
    } catch (e) {
      // Manejar el error aquí
      print('Error al cargar equipos disponibles: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Equipo a Partido"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Selecciona un equipo para añadir al Partido",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<dynamic>(
              value: selectedEquipo,
              items: _equiposDisponibles.map((equipo) {
                return DropdownMenuItem<dynamic>(
                  value: equipo,
                  child: Text(equipo['nombre']), // Asume que 'nombre' es el campo del equipo
                );
              }).toList(),
              onChanged: (dynamic value) {
                setState(() {
                  selectedEquipo = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Equipo',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                    if (selectedEquipo != null) {
      try {
        await HttpService().agregarResultado(
          selectedEquipo['id'],
          widget.partido_id,
          0, // Puedes ajustar los puntos según sea necesario
          false, // Puedes ajustar el valor de ganador según sea necesario
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Equipo agregado con éxito')));
        Navigator.pop(context);
      } catch (e) {
        print('Error al agregar equipo: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al agregar equipo')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Por favor selecciona un equipo')));
    }

              },
              child: Text('Agregar Equipo'),
            ),
          ],
        ),
      ),
    );
  }
}

