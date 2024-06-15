import 'package:flutter/material.dart';

import 'package:flutter_application_1/pages/equipo_agregar.dart';
import 'package:flutter_application_1/service/http_service.dart';
import 'package:flutter_application_1/widgets/equipo_tile.dart';
import 'package:google_fonts/google_fonts.dart';

class EquiposTab extends StatefulWidget {
  const EquiposTab({super.key});

  @override
  State<EquiposTab> createState() => _EquiposTabState();
}

class _EquiposTabState extends State<EquiposTab> {
  List equipos = [];

  @override
  void initState() {
    super.initState();
    fetchEquipos();
  }

  Future<void> fetchEquipos() async {
    try {
      var data = await HttpService().campeonatos();
      setState(() {
        equipos = data;
      });
    } catch (e) {
      print('Error fetching campeonatos: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:AssetImage('assets/images/iconito.jpeg'), 
            fit: BoxFit.cover
          )  
        ),
        child:Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("EQUIPOS", style:  GoogleFonts.oswald(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),),
            ),
            Expanded(child: FutureBuilder(
              future: HttpService().equipos(), 
            builder: (context,AsyncSnapshot snapshot){
              if(!snapshot.hasData||snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(itemCount: snapshot.data.length, itemBuilder:(context,index){
                var equipo =snapshot.data[index];
                return EquipoTile(
                  id:equipo["id"],
                  nombre:equipo["nombre"],
                  descripcion: equipo['descripcion'],
                  onEdit: fetchEquipos,
                  onDelete: fetchEquipos,
                  );
              },);
            })),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color:Colors.white
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Color(0xff142157),
        onPressed: (){
          MaterialPageRoute ruta =MaterialPageRoute(
            builder:(context)=>EquipoAgregar(),
            );
          Navigator.push(context,ruta).then((value){fetchEquipos();});
        }
        
        )    
      
    );
  }
}