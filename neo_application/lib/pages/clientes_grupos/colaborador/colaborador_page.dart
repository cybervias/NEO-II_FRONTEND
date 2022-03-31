import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neo_application/pages/clientes_grupos/colaborador/colaborador_api.dart';
import 'package:neo_application/pages/clientes_grupos/colaborador/colaborador_edit.dart';
import 'package:neo_application/pages/clientes_grupos/colaborador/colaborador_model.dart';
import 'package:neo_application/pages/clientes_grupos/fracao_propriedades/Tabelas_model.dart';
import 'package:neo_application/pages/login_page/login_page.dart';
import 'package:neo_application/pages/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:neo_application/pages/utils/globals.dart' as globals;

class ColaboradorPage extends StatefulWidget {
  String? token;
 
  ColaboradorPage({Key? key, this.token}) : super(key: key);

  @override
  State<ColaboradorPage> createState() => _ColaboradorPageState();
}

class _ColaboradorPageState extends State<ColaboradorPage> {
  Size get size => MediaQuery.of(context).size;
  
  List<ColaboradorModel> listColaborador = [];
  List<TodasTabelasModel> listTabelas = [];

  ColaboradorApi colaboradorApi = ColaboradorApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      appBar: AppBar(
        title: Text("Usuário"),
        backgroundColor: Color.fromRGBO(78, 204, 196, 2),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
    );
  }

  void _onNavAdd(BuildContext context) {
    AppModel app = Provider.of<AppModel>(context, listen: false);
    app.setPage(ColaboradorEdit(
      colaboradorModel: ColaboradorModel(
      idAuditor: 0,
      Nome: "",
      DataInicio: "",
      Especialidade: "",
      qAuditor: "",
      qAuditorLider: "",
      qLiderExperiencia: "",
      Usuario: "",
         ),
      tipoAcao: "adicionar",
    ));
  }

  _body() {
    return FutureBuilder(
      future: ColaboradorApi().getListColaborador(),
      builder: (context, AsyncSnapshot snapshot) {
         
        if (globals.isValid == false) {
          Fluttertoast.showToast(
              msg: "Usuario não autorizado",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 10,
              fontSize: 16.0);
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage()));
          });
        }
        if (snapshot.hasError) {
          return Center(child: Text("Erro ao carregar os dados"));
        }
        if (snapshot.hasData) {
          listColaborador = snapshot.data;
          return Container(
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text("Nome: " + "${listColaborador[index].Nome}" + " - " "Usuário: " + "${listColaborador[index].Usuario}" + " - " "Especialidade: " + "${listColaborador[index].Especialidade}" + " - " "Data de Início: " + "${listColaborador[index].DataInicio}"
                        ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            AppModel app =
                                Provider.of<AppModel>(context, listen: false);
                            app.setPage(ColaboradorEdit(
                              colaboradorModel: listColaborador[index],
                              tipoAcao: "editar",
                            ));
                          },
                          icon: const Icon(
                            Icons.edit,
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
}
