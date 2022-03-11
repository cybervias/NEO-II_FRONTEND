import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neo_application/pages/clientes_grupos/entidades_gestoras/entidades_api.dart';
import 'package:neo_application/pages/clientes_grupos/entidades_gestoras/entidades_model.dart';
import 'package:neo_application/pages/clientes_grupos/entidades_gestoras/entidades_page.dart';
import 'package:neo_application/pages/provider/app_provider.dart';
import 'package:neo_application/pages/utils/list_uf.dart';
import 'package:provider/provider.dart';

class EntidadesEdit extends StatefulWidget {
  EntidadesModel entiModel;
  var tipoAcao;
  String uf;
  EntidadesEdit(
      {Key? key, required this.entiModel, this.tipoAcao, this.uf = ""})
      : super(key: key);

  @override
  State<EntidadesEdit> createState() => _EntidadesEditState();
}

class _EntidadesEditState extends State<EntidadesEdit> {
  Size get size => MediaQuery.of(context).size;
  late EntidadesModel oEnti;

  final TextEditingController _controllerId = TextEditingController();
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerContato = TextEditingController();
  final TextEditingController _controllerTelefone = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  late AppModel appRepository;
  double constWidth = 400;
  late EntidadesModel oEntiModel;
  String? listUfSelecionado;
  String? valueSelected;

  @override
  Widget build(BuildContext context) {
    oEntiModel = widget.entiModel;
    appRepository = Provider.of<AppModel>(context);
    return Scaffold(
      body: _body(),
      appBar: AppBar(
        title: Text(widget.tipoAcao == "editar"
            ? "Editar Entidades (${widget.entiModel.Id})"
            : "Criar Nova Entidade"),
        backgroundColor: Color.fromRGBO(68, 76, 87, 2),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
    );
  }

  _setText() {
    oEnti = widget.entiModel;
    _controllerId.text = oEnti.Id.toString();
    _controllerNome.text = oEnti.Nome ?? "";
    _controllerContato.text = oEnti.Contato ?? "";
    _controllerTelefone.text = oEnti.Telefone.toString();
    _controllerEmail.text = oEnti.Email ?? "";
  }

  _body() {
    if (widget.entiModel.Nome != "") {
      _setText();
    }

    List<String> listUfs = Uf().listUfs();

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 50),
        child: Card(
          child: SafeArea(
            child: LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth < 786) {
                return Column(
                  children: [
                    _inputsEsq(listUfs),
                   
                     _Buttons()
                     ],
                );
              } else {
                return SafeArea(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _inputsEsq(listUfs),
                        ],
                      ),
                      Container(
                        child: _Buttons(),
                      )
                    ],
                  ),
                );
              }
            }),
          ),
        ),
      ),
    );
  }

  _inputsEsq(List<String> listUfs) {
    return Container(
      child: Container(
        padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 300,
              height: 30,
              child: TextFormField(
                controller: _controllerNome,
                decoration: const InputDecoration(
                  labelText: "Nome",
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(
              width: 30,
              height: 20,
            ),
            SizedBox(
              width: 300,
              height: 30,
              child: TextFormField(
                controller: _controllerContato,
                decoration: const InputDecoration(
                  labelText: "Contato",
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(
              width: 30,
              height: 20,
            ),
            SizedBox(
              width: 300,
              height: 30,
              child: TextFormField(
                controller: _controllerTelefone,
                decoration: const InputDecoration(
                  labelText: "Telefone",
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(
              width: 30,
              height: 20,
            ),
            SizedBox(
              width: 300,
              height: 30,
              child: TextFormField(
                controller: _controllerEmail,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(
              width: 30,
              height: 20,
            ),
          ],
        ),
      ),
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
            onPressed: () => {appRepository.setPage(EntidadesPage())},
            child: Text("Cancelar"),
          ),
        ],
      ),
    );
  }

  _onClickSalvar() async {
    EntidadesApi entidadesApi = EntidadesApi();

    EntidadesModel oEnti = EntidadesModel(
      Id: oEntiModel.Id,
      Nome: _controllerNome.text,
      Contato: _controllerContato.text,
      Telefone:  _controllerTelefone.text,
      Email: _controllerEmail.text,
    );

    var messageReturn = await entidadesApi.updateEntidade(oEnti);

    if (messageReturn["type"] == "S") {
      Fluttertoast.showToast(
          msg: messageReturn["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);

      AppModel app = Provider.of<AppModel>(context, listen: false);
      app.setPage(EntidadesPage());
    }
  }

  _onClickAdd() async {
    if (_controllerNome.text == "" ||
        _controllerContato.text == "" ||
        _controllerTelefone.text == "" ||
        _controllerEmail.text == "" ) {
      _onClickDialog();
      return;
    }
    EntidadesApi entidadesApi = EntidadesApi();

    EntidadesModel oEnti = EntidadesModel(
     
      Nome: _controllerNome.text,
      Contato: _controllerContato.text,
      Telefone: _controllerTelefone.text,
      Email: _controllerEmail.text,
    );

    var messageReturn = await entidadesApi.createEntidade(oEnti);

    if (messageReturn["type"] == "S") {
      Fluttertoast.showToast(
          msg: messageReturn["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      AppModel app = Provider.of<AppModel>(context, listen: false);
      app.setPage(EntidadesPage());
    }
  }

  _onClickDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            height: 200,
            child: Center(
              child: Text("Preencher campos obrigatorios"),
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
