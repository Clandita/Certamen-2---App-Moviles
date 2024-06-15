import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/jugador_agregar.dart';
import 'package:flutter_application_1/service/http_service.dart';
import 'package:flutter_application_1/widgets/jugador_tile.dart';
import 'package:google_fonts/google_fonts.dart';
class EquipoPerfil extends StatefulWidget {
  final int equipo_id;
  const EquipoPerfil({required this.equipo_id});

  @override
  State<EquipoPerfil> createState() => _EquipoPerfilState();
}

class _EquipoPerfilState extends State<EquipoPerfil> {
    List<dynamic> jugadores = [];

  @override
  void initState() {
    super.initState();
    fetchJugadores();
  }

  Future<void> fetchJugadores() async {
    var jugadoresData = await HttpService().jugadores();
    setState(() {
      jugadores = jugadoresData;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: FutureBuilder(
          future: HttpService().obtenerEquipo(widget.equipo_id),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return Text('${snapshot.data!["nombre"]}', style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)));
          },
        ),
      ),
      
      body: FutureBuilder(
        future: HttpService().jugadoresPorEquipo(widget.equipo_id),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              var jugador = snapshot.data[index];
              return JugadorTile(
                nombre:jugador["nombre"],
                rut:jugador["rut"],
                apellido:jugador["apellido"],
                nickname:jugador["nickname"],
                onEdit: fetchJugadores,
                onDelete: fetchJugadores,

              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color:Colors.black
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor:Colors.white,
        onPressed: (){
          MaterialPageRoute ruta =MaterialPageRoute(
            builder:(context)=>JugadorAgregar(id_Equipo: widget.equipo_id,),
            );
          Navigator.push(context,ruta).then((value){
            fetchJugadores();
          });
        })    
      
    );
  }
}
