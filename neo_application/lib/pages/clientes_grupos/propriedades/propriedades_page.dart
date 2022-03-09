import 'package:flutter/material.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propriedades_api.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      splashColor: Colors.blue,
                      child: SizedBox(
                        width: size.width,
                        height: size.height - 200,
                        child: FutureBuilder(
                          future: PropriedadesApi().getListPropriedades(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text("Erro ao carregar os dados"));
                            }
                            if (snapshot.hasData) {
                              listProp = snapshot.data;
                              return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      title: Text(listProp[index].Nome! +
                                          ' - ' +
                                          listProp[index].CNPJ!),
                                      trailing: IconButton(
                                        onPressed: () {
                                          AppModel app = Provider.of<AppModel>(
                                              context,
                                              listen: false);
                                          app.setPage(PropriedadesEdit(
                                              propModel: listProp[index]));
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color:
                                              Color.fromARGB(246, 34, 37, 44),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    ),
                    listProp.isNotEmpty
                        ? Container(
                            alignment: Alignment.bottomRight,
                            child: ButtonBar(
                              children: [
                                ElevatedButton(
                                  onPressed: () => {},
                                  child: Text("Novo"),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(246, 34, 37, 44),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
