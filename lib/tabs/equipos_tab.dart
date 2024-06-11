import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/equipo_agregar.dart';
import 'package:flutter_application_1/service/http_service.dart';
import 'package:flutter_application_1/widgets/equipo_tile.dart';

class EquiposTab extends StatefulWidget {
  const EquiposTab({super.key});

  @override
  State<EquiposTab> createState() => _EquiposTabState();
}

class _EquiposTabState extends State<EquiposTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        color:Colors.blue,
        child:Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("EQUIPOS", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
                  );
              },);
            }))
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
          Navigator.push(context,ruta).then((value){setState((){});});
        }
        
        )    
      
    );
  }
}