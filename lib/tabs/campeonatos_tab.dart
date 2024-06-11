
import 'package:flutter/material.dart';

import 'package:flutter_application_1/service/http_service.dart';
import 'package:flutter_application_1/widgets/campeonato_tile.dart';
import 'package:google_fonts/google_fonts.dart';

class CampeonatosTab extends StatelessWidget {
  const CampeonatosTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:AssetImage('assets/images/iconito.jpeg'),
            fit: BoxFit.cover)
        ),
        child:Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("CAMPEONATOS", style:  GoogleFonts.oswald(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
            ),


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
                  juego: campeonato['juego'],
                  reglas: campeonato['reglas'],
                  premios:campeonato['premios']
                  );
              },);
            })),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color:Colors.white
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Color(0xff142157),
        onPressed: (){})    
    );
  }
}