import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/service/http_service.dart';
import 'package:flutter_application_1/widgets/campeonato_tile.dart';

class CampeonatosTab extends StatelessWidget {
  const CampeonatosTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        color:Colors.blue,
        child:Column(
          children: [
            Text("LISTA DE CAMPEONATOS"),
            Expanded(child: FutureBuilder(
              future: HttpService().campeonatos(), 
            builder: (context,AsyncSnapshot snapshot){
              if(!snapshot.hasData||snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(itemCount: snapshot.data.length, itemBuilder:(context,index){
                var campeonato =snapshot.data[index];
                return CampeonatoTile(
                  id:campeonato["id"],
                  nombre:campeonato["nombre"],
                  reglas: campeonato['reglas'],
                  premios:campeonato['premios']
                  );
              },);
            }))
          ],
        )
      )

    );
  }
}