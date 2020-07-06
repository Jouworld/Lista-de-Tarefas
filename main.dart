import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';


void main(){
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _toDoList = [];

  final  tarefaController = TextEditingController();

  void _addToDo(){

    setState(() { //comando para atualizar a tela
      Map<String, dynamic> newToDo = Map();
      newToDo["title"] = tarefaController.text;
      tarefaController.text = "";// resetando campo de texto
      newToDo["ok"] = false; // inicializando a tarefa como não concluída
      _toDoList.add(newToDo);
    });
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor:Color(0xffB22222),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Nova Tarefa",
                        labelStyle: TextStyle(color: Color(0xffB22222))
                    ),
                    controller: tarefaController,
                  ),
                ),
                RaisedButton(
                  color: Color(0xffB22222),
                  child: Text(
                    "Adicionar",
                    style: TextStyle(
                      color: Colors.white
                    ),

                  ),
                  onPressed: _addToDo,
                ),

              ],
            ),

          ),
          Expanded(
            child: ListView.builder(//criar lista conforme a mesma vai sendo renderizada
              padding: EdgeInsets.only(top: 10.0),
              itemCount: _toDoList.length, // pegando o tamanho da lista
              itemBuilder: (context, index){
                return CheckboxListTile(
                  title: Text(_toDoList[index]["title"]),
                  value: _toDoList[index]["ok"],
                  secondary: CircleAvatar(
                    child: Icon(_toDoList[index]["ok"]? Icons.check : Icons.assignment_late),
                  ),
                  onChanged: (c){
                    print (c);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }




  Future<File> _getFile() async{//função para obter o arquivo

    final directory = await getApplicationDocumentsDirectory();//peguei o local onde posso salvar os documentos
    return File("${directory.path}/data.json");//pegando o caminho do diretório e junto com o nome do arquivo e abro o arquivo através do file

  }


  Future<File> _saveData() async{ //função para salvar o arquivo

   String data = json.encode(_toDoList);//pegando a lista e transformando em um Json e colocando em uma string
   final file = await _getFile();
   return file.writeAsString(data);

  }

  Future<String> _readData() async{ // função para ler o dados no arquivo

    try{
      final file = await _getFile();
      return file.readAsString();
    } catch (e){
      return null;
    }
  }



}


