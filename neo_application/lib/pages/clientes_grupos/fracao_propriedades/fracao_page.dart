import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neo_application/pages/clientes_grupos/fracao_propriedades/Tabelas_model.dart';
import 'package:neo_application/pages/clientes_grupos/fracao_propriedades/fracao_api.dart';
import 'package:neo_application/pages/clientes_grupos/fracao_propriedades/fracao_edit.dart';
import 'package:neo_application/pages/clientes_grupos/fracao_propriedades/fracao_model.dart';
import 'package:neo_application/pages/provider/app_provider.dart';
import 'package:provider/provider.dart';


class FracaoPropPage extends StatefulWidget {
  const FracaoPropPage({Key? key}) : super(key: key);

  @override
  State<FracaoPropPage> createState() => _FracaoPropPageState();
}

class _FracaoPropPageState extends State<FracaoPropPage> {
  Size get size => MediaQuery.of(context).size;

  List<FracaoPropModel> listFracaoProp = [];
  List<TodasTabelasModel> listTabelas = [];

  FracaoPropApi fracaoPropApi = FracaoPropApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      appBar: AppBar(
        title: Text("Lista de Fração de Propriedade"),
        backgroundColor: Color.fromRGBO(68, 76, 87, 2),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onNavAdd(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(78, 204, 196, 2),
      ),
    );
  }

  void _onNavAdd(BuildContext context) {
    AppModel app = Provider.of<AppModel>(context, listen: false);
    app.setPage(FracaoPropEdit(
      fracaoPropModel: FracaoPropModel(
        ID: 0,
        IDEntidade: 0,
        IDPropriedade: 0,
        Fracao: 0,
         ),
      tipoAcao: "adicionar",
    ));
  }

  _body() {
    return FutureBuilder(
      future: FracaoPropApi().getListFracaoProp(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Erro ao carregar os dados"));
        }
        if (snapshot.hasData) {
          listFracaoProp = snapshot.data;

          return Container(
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    
                    title: Text("Entidade: " + "${Map.from(listFracaoProp[index].entidades)['Nome']}" + " - " + "Propriedade: " +  "${Map.from(listFracaoProp[index].propriedades)['Nome']}" + " - " + "Fração: " +  "${listFracaoProp[index].Fracao}"
                        ),
                        
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            AppModel app =
                                Provider.of<AppModel>(context, listen: false);
                            app.setPage(FracaoPropEdit(
                              fracaoPropModel: listFracaoProp[index],
                              tipoAcao: "editar",
                            ));
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Color.fromARGB(246, 34, 37, 44),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await _dialogDelete(index, context);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Color.fromARGB(246, 34, 37, 44),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

   Future<void> _deleteFracaoProp(int index, BuildContext context) async {
    var resposta =
        await  fracaoPropApi.deleteFracaoProp(listFracaoProp[index].ID!);
    if (resposta["type"] == "S") {
      Fluttertoast.showToast(
          msg: resposta["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      Navigator.pop(context);
      setState(() {
         FracaoPropApi().getListFracaoProp();
      });
    }
  }

  _dialogDelete(int index, BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            height: 50,
            child: Center(
              child: Text("Você deseja excluir este item?"),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => _deleteFracaoProp(index, context),
              child: Text("Sim"),
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(246, 34, 37, 44)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Não"),
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(246, 34, 37, 44)),
            ),
          ],
        ),
      );
}
