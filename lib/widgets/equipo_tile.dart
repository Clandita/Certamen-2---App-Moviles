import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/editar_equipo.dart';
import 'package:flutter_application_1/pages/equipos_perfil.dart';
import 'package:flutter_application_1/service/http_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EquipoTile extends StatefulWidget {
  final int id;
  final String nombre;
  final String descripcion;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  

  const EquipoTile({this.nombre='sin nombre', this.descripcion='sin descripcion', required this.id,required this.onEdit,required this.onDelete});


  @override
  State<EquipoTile> createState() => _EquipoTileState();
}

class _EquipoTileState extends State<EquipoTile> {
  late TextEditingController idController;
  late String nombre;
  late String descripcion;

  @override
  void initState() {
    super.initState();
    idController=TextEditingController(text: widget.id.toString());
    nombre = widget.nombre;
    descripcion = widget.descripcion;

  }

  void editarEquipo() async {
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EquipoEditar(
          id: widget.id,
          nombre: nombre,
          descripcion: descripcion,
        ),
      ),
    );

    if (updatedData != null) {
      setState(() {
        nombre = updatedData['nombre'];
        descripcion = updatedData['descripcion'];
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(10),    
          decoration: BoxDecoration(
            color: Color.fromRGBO(87, 86, 86, 0.9),
            border:Border.all(color: Colors.black),
            borderRadius: BorderRadius.all( Radius.circular(10))
          ),
      child: Column(children: [
        Container(
          color: Color.fromRGBO(87, 86, 86, 0.9),
          child: Text('Equipo', style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 20, color: Colors.white))),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.8),
            borderRadius: BorderRadius.only()
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${this.widget.nombre}', style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),),
            ],
          )),
          Container(
            color: Colors.white,
            child: Divider(color: Colors.black)),
          Container(
            decoration: BoxDecoration(
              color:const Color.fromRGBO(255, 255, 255, 0.8)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${this.widget.descripcion}',style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16))),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EquipoPerfil(equipo_id: widget.id),
                  ),
                );
              },
              child: Text('Jugadores del equipo', style: GoogleFonts.oswald(textStyle: TextStyle(fontSize: 16, color: Colors.black))),
            ),
          ),
            
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EquipoEditar(
                          id: widget.id, 
                          nombre: nombre,
                          descripcion: descripcion),
                      ),
                    ).then((value) {
                      if (value ==true){
                        widget.onEdit();
                      }
                    });
                  },
                  icon: Icon(MdiIcons.bookEdit,color: Colors.white,size: 30,),
                ),
              ),

              Container(
                
                child: IconButton(
                  onPressed: () async {
                  var respuesta= await HttpService().deleteEquipo(
                    int.parse(idController.text)
               
                );
                if(respuesta=='Error'){
                  print("nooo");
                }else{
                  widget.onDelete();
                }
                  },
                  icon: Icon(MdiIcons.delete,color: Colors.white,size: 30,),
                ),
              ),




            ],
          ),
            ],
          ),
      
    );
    
  }
}