import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/partidos_agregar.dart';
import 'package:flutter_application_1/service/http_service.dart';
import 'package:flutter_application_1/widgets/partido_tile.dart';
import 'package:google_fonts/google_fonts.dart';

class CalendarioTab extends StatefulWidget {
  const CalendarioTab({super.key});

  @override
  State<CalendarioTab> createState() => _CalendarioTabState();
}

class _CalendarioTabState extends State<CalendarioTab> {
    List<dynamic> partidos = [];

  @override
  void initState() {
    super.initState();
    fetchPartidos();
  }

  Future<void> fetchPartidos() async {
    var partidosData = await HttpService().partidos();
    setState(() {
      partidos = partidosData;
    });
  }
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
              child: Text(
                "CALENDARIO DE PARTIDOS",
                style: GoogleFonts.oswald(
                  textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            

            Expanded(child: FutureBuilder(
              future: HttpService().partidos(), 
            builder: (context,AsyncSnapshot snapshot){
              if(!snapshot.hasData||snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(itemCount: snapshot.data.length, itemBuilder:(context,index){
                var partidos =snapshot.data[index];
                
                
                return PartidoTile(
                  id:partidos["id"],
                  jugado:partidos["jugado"],  
                  lugar: partidos['lugar'],
                  campeonato_id: partidos['campeonato_id'],
                  hora:partidos['hora'],
                  onEdit: fetchPartidos,
                  onDelete: fetchPartidos
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
            builder:(context)=>PartidosAgregar(),
            );
          Navigator.push(context,ruta).then((value){fetchPartidos();});
        })    

    );
  }
}