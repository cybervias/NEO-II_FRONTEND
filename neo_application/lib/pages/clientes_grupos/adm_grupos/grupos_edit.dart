import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:javascript/javascript.dart';
import 'package:neo_application/pages/clientes_grupos/adm_grupos/grupos_api.dart';
import 'package:neo_application/pages/clientes_grupos/adm_grupos/grupos_model.dart';
import 'package:neo_application/pages/clientes_grupos/adm_grupos/grupos_page.dart';
import 'package:neo_application/pages/clientes_grupos/entidades_gestoras/entidades_model.dart';
import 'package:neo_application/pages/provider/app_provider.dart';
import 'package:provider/provider.dart';

class GruposEdit extends StatefulWidget {
  GruposModel grupoModel;
  var tipoAcao;

  GruposEdit({Key? key, required this.grupoModel, this.tipoAcao})
      : super(key: key);

  @override
  State<GruposEdit> createState() => _GruposEditState();
}

class _GruposEditState extends State<GruposEdit> {
  Size get size => MediaQuery.of(context).size;
  late GruposModel oGrupo;
  late String _value;

  final TextEditingController _controllerIdGrupo = TextEditingController();
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerDataFormacao = TextEditingController();
  final TextEditingController _controllerIDGestor = TextEditingController();

  late AppModel appRepository;
  late GruposModel oGrupoModel;
  EntidadesModel valueSelected = EntidadesModel();

  EntidadesModel listEntidadesSelecionado = EntidadesModel();

  List<EntidadesModel> listEntidades = [];

final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _setText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    oGrupoModel = widget.grupoModel;
    appRepository = Provider.of<AppModel>(context);
    return Scaffold(
      body: _body(),
      appBar: AppBar(
        title: Text(widget.tipoAcao == "editar"
            ? "Editar Grupos (${widget.grupoModel.idGrupo})"
            : "Criar Novo Grupos"),
        backgroundColor: Color.fromRGBO(68, 76, 87, 2),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
    );
  }

  _setText() {
    oGrupo = widget.grupoModel;
    _controllerIdGrupo.text = oGrupo.idGrupo.toString();
    _controllerNome.text = oGrupo.Nome ?? "";
    _controllerDataFormacao.text = oGrupo.DataFormacao.toString();
    _controllerIDGestor.text = oGrupo.IDGestor.toString();
    /*listEntidadesSelecionado.Nome =
        valueSelected.Nome != null ? valueSelected.Nome : oGrupo.IDGestor.toString();*/
  }

  _body() {
    return FutureBuilder(
      future: EntidadesApi().getListEntidades(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Erro ao carregar os dados"));
        }
        if (snapshot.hasData) {
          listEntidades = snapshot.data;

          print(listEntidades);

          return ListView(
            children: [
              Card(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                  return Container(
                    padding: EdgeInsets.all(50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 300,
                          height: 40,
                          child: TextFormField(
                            controller: _controllerNome,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: "Nome",
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                          height: 20,
                        ),
                        Container(
                          width: 300,
                          height: 40,
                          child: TextFormField(
                            controller: _controllerDataFormacao,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: "Data da Formatação",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.date_range,
                                  color: Color.fromARGB(96, 88, 87, 87),
                                  size: 20,
                                ),
                                onPressed: () async {
                                  final data = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  if (data != null)
                                    setState(() => _value = data.toString());

                                  _controllerDataFormacao.text =  _value.substring(8, 10) + '/' + _value.substring(5, 7) +  '/' + _value.substring(0, 4);
                            
                                  print( _controllerDataFormacao.text);
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                          height: 20,
                        ),
                        Container(
                          width: 300,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<String>(
                                hint: Text("Entidades Gestoras"),
                                isDense: true,
                                isExpanded: true,
                                value: listEntidadesSelecionado.Id !=
                                        null
                                    ? listEntidadesSelecionado.Id
                                        .toString()
                                    : listEntidades[0].Id.toString(),
                                onChanged: (newValue) => {
                                  setState(() {
                                    listEntidadesSelecionado.Id =
                                        int.parse("$newValue");

                                    print(newValue.toString());
                                  }),
                                },
                                items: listEntidades
                                    .map<DropdownMenuItem<String>>(
                                        (value) {
                                  return DropdownMenuItem<String>(
                                    value: value.Id.toString(),
                                    child: Text(value.Nome!),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        _Buttons()
                      ],
                    ),
                  );
                }),
              ),
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  _Buttons() {
    return Container(
      alignment: Alignment.bottomRight,
      child: ButtonBar(
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(246, 34, 37, 44)),
            onPressed: () =>
                widget.tipoAcao == "editar" ? _onClickSalvar() : _onClickAdd(),
            child: widget.tipoAcao == "editar"
                ? Text("Salvar Alterações")
                : Text("Adicionar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(246, 34, 37, 44)),
            onPressed: () => {appRepository.setPage(GruposPage())},
            child: Text("Cancelar"),
          ),
        ],
      ),
    );
  }

  _onClickSalvar() async {
    if (_controllerNome.text == "" || _controllerDataFormacao.text == "") {
      _onClickDialog();
      return;
    }
    GruposApi gruposApi = GruposApi();

   var listEnti = listEntidades.where((element) => element.Id == listEntidadesSelecionado.Id) .toList();

    int? idEntidades = listEnti[0].Id;

var dataForm =_controllerDataFormacao.text.substring(3, 5) + '/' + _controllerDataFormacao.text.substring(0, 2) +  '/' + _controllerDataFormacao.text.substring(6, 10);

    GruposModel oGrupo = GruposModel(
      idGrupo: widget.grupoModel.idGrupo,
      Nome: _controllerNome.text,
      DataFormacao: dataForm,
      IDGestor: idEntidades,
    );

    var messageReturn = await gruposApi.updateGrupo(oGrupo);

    if (messageReturn["type"] == "S") {
      Fluttertoast.showToast(
          msg: messageReturn["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);

      AppModel app = Provider.of<AppModel>(context, listen: false);
      app.setPage(GruposPage());
    }
  }

  _onClickAdd() async {
    if (_controllerNome.text == "" || _controllerDataFormacao.text == "") {
      _onClickDialog();
      return;
    }
    GruposApi gruposApi = GruposApi();

    var listEnti = listEntidades.where((element) => element.Id == listEntidadesSelecionado.Id) .toList();

    int? idEntidades = listEnti[0].Id;

    var dataForm =_controllerDataFormacao.text.substring(3, 5) + '/' + _controllerDataFormacao.text.substring(0, 2) +  '/' + _controllerDataFormacao.text.substring(6, 10);

    GruposModel oGrupo = GruposModel(
      Nome: _controllerNome.text,
      DataFormacao: dataForm,
      IDGestor: idEntidades,
    );

    var messageReturn = await gruposApi.createGrupo(oGrupo);

    if (messageReturn["type"] == "S") {
      Fluttertoast.showToast(
          msg: messageReturn["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      AppModel app = Provider.of<AppModel>(context, listen: false);
      app.setPage(GruposPage());
    } else{
      Fluttertoast.showToast(
          msg: messageReturn["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }

  _onClickDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            height: 60,
            child: Center(
              child: Text(
                  "Preencha os campos obrigatorios. \n\n      Nome, Data da Formatação."),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => {Navigator.pop(context)},
              style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(75, 171, 143, 30)),
              child: Text("Ok"),
            )
          ],
        ),
      );

  // String? _validateNome(String? value) {
  //    if (value!.isEmpty) {
  //     return "Nome não";
  //   }
  // }

  // String? _validateCnpj(String? value) {
  //   if (value!.isEmpty) {
  //     return "Digite o usuario";
  //   }
  // }

  // String? _validateXCoord(String? value) {
  //   if (value!.isEmpty) {
  //     return "Digite o usuario";
  //   }
  // }

  // String? _validateYCorrd(String? value) {
  //   if (value!.isEmpty) {
  //     return "Digite o usuario";
  //   }
  // }

  // String? _validateAreaPropriedade(String? value) {
  //   if (value!.isEmpty) {
  //     return "Digite o usuario";
  //   }
  // }

  // String? _validateAreaTotal(String? value) {
  //   if (value!.isEmpty) {
  //     return "Digite o usuario";
  //   }
  // }

  // String? _validateAreaPlantada(String? value) {
  //   if (value!.isEmpty) {
  //     return "Digite o usuario";
  //   }
  // }

  // String? _validateAreaEstimaConser(String? value) {
  //   if (value!.isEmpty) {
  //     return "Digite o usuario";
  //   }
  // }

  // String? _validateAreaInfr(String? value) {
  //   if (value!.isEmpty) {
  //     return "Digite o usuario";
  //   }
  // }

  // String? _validateAreaOutro(String? value) {
  //   if (value!.isEmpty) {
  //     return "Digite o usuario";
  //   }
  // }

  // String? _validateLocalizacao(String? value) {
  //   if (value!.isEmpty) {
  //     return "Digite o usuario";
  //   }
  // }
}
