import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propriedades_api.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propriedades_createPage.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propriedades_edit.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propriedades_model.dart';
import 'package:neo_application/pages/provider/app_provider.dart';
import 'package:provider/provider.dart';

class PropriedadesPage extends StatefulWidget {
  const PropriedadesPage({Key? key}) : super(key: key);

  @override
  State<PropriedadesPage> createState() => _PropriedadesPageState();
}

class _PropriedadesPageState extends State<PropriedadesPage> {
  Size get size => MediaQuery.of(context).size;

  List<PropriedadesModel> listProp = [];

  PropriedadesApi propriedadesApi = PropriedadesApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      appBar: AppBar(
        title: Text("Lista de Propriedades"),
        backgroundColor: Color.fromRGBO(78, 204, 196, 2),
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
    app.setPage(
      PropriedadesCreate(),
    );
  }

  _body() {
    return FutureBuilder(
      future: PropriedadesApi().getListPropriedades(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Erro ao carregar os dados"));
        }
        if (snapshot.hasData) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              CircularProgressIndicator();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              listProp = snapshot.data;
              return Container(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text("Nome: " + listProp[index].Nome! +
                            ' - ' + "CNPJ: " +
                            listProp[index].CNPJ!),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                AppModel app = Provider.of<AppModel>(context,
                                    listen: false);
                                app.setPage(PropriedadesEdit(
                                  propModel: listProp[index],
                                  tipoAcao: "editar",
                                  indice: index,
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
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<void> _deletePropriedade(int index, BuildContext context) async {
    var resposta =
        await propriedadesApi.deletePropriedade(listProp[index].idPropriedade!);
    if (resposta["type"] == "S") {
      Fluttertoast.showToast(
          msg: resposta["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 10,
          fontSize: 16.0);
      Navigator.pop(context);
      setState(() {
        PropriedadesApi().getListPropriedades();
      });
    }
  }

  _dialogDelete(int index, BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            height: 60,
            child: Center(
              child: Text("Você deseja excluir este item?"),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => _deletePropriedade(index, context),
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
