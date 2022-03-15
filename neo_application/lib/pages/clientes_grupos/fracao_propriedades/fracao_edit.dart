import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neo_application/pages/clientes_grupos/entidades_gestoras/entidades_model.dart';
import 'package:neo_application/pages/clientes_grupos/fracao_propriedades/fracao_api.dart';
import 'package:neo_application/pages/clientes_grupos/fracao_propriedades/fracao_model.dart';
import 'package:neo_application/pages/clientes_grupos/fracao_propriedades/fracao_page.dart';
import 'package:neo_application/pages/provider/app_provider.dart';
import 'package:provider/provider.dart';

class FracaoPropEdit extends StatefulWidget {
  FracaoPropModel fracaoPropModel;
  var tipoAcao;

  FracaoPropEdit({Key? key, required this.fracaoPropModel, this.tipoAcao})
      : super(key: key);

  @override
  State<FracaoPropEdit> createState() => _FracaoPropEditState();
}

class _FracaoPropEditState extends State<FracaoPropEdit> {
  Size get size => MediaQuery.of(context).size;
  late FracaoPropModel oFracaoProp;
  late String _value;

  final TextEditingController _controllerID = TextEditingController();
  final TextEditingController _controllerIDEntidade = TextEditingController();
  final TextEditingController _controllerIDPropriedade =
      TextEditingController();
  final TextEditingController _controllerFracao = TextEditingController();

  late AppModel appRepository;
  late FracaoPropModel ofracaoPropModel;
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
    ofracaoPropModel = widget.fracaoPropModel;
    appRepository = Provider.of<AppModel>(context);
    return Scaffold(
      body: _body(),
      appBar: AppBar(
        title: Text(widget.tipoAcao == "editar"
            ? "Editar Fração (${widget.fracaoPropModel.ID})"
            : "Criar Nova Fração"),
        backgroundColor: Color.fromRGBO(68, 76, 87, 2),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
    );
  }

  _setText() {
    oFracaoProp = widget.fracaoPropModel;
    _controllerID.text = oFracaoProp.ID.toString();
    _controllerIDEntidade.text = oFracaoProp.IDEntidade.toString();
    _controllerIDPropriedade.text = oFracaoProp.IDPropriedade.toString();
    _controllerFracao.text = oFracaoProp.Fracao.toString();
    /*listEntidadesSelecionado.Nome =
        valueSelected.Nome != null ? valueSelected.Nome : oGrupo.IDGestor.toString();*/
  }
  
  _body() {
//List _listEntidades = EntidadesApi().getListEntidades();

    return FutureBuilder(
      
      future: TodasTabelas().getBuscaTodasTabelas(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Erro ao carregar os dados"));
        }
        if (snapshot.hasData) {
          listEntidades = snapshot.data;
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 50),
              child: Card(
                child: SafeArea(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Column(
                      children: [
                        Container(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                          value: listEntidadesSelecionado.Nome,
                                          onChanged: (newValue) => {
                                            setState(() {
                                              listEntidadesSelecionado.Nome = "";
                                              listEntidadesSelecionado.Nome =
                                                  newValue;
                                              print(newValue);
                                            }),
                                          },
                                          items: listEntidades.map<DropdownMenuItem<String>>((value) {
                                            return DropdownMenuItem<String>(
                                              value: value.Id.toString(),
                                              child: Text(value.Nome!),
                                            );
                                          }).toList(),
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
                                          hint: Text("Propriedade"),
                                          isDense: true,
                                          isExpanded: true,
                                          value: listEntidadesSelecionado.Nome,
                                          onChanged: (newValue) => {
                                            setState(() {
                                              listEntidadesSelecionado.Nome = "";
                                              listEntidadesSelecionado.Nome =
                                                  newValue;
                                              print(newValue);
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
                                  const SizedBox(
                                    width: 30,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    height: 40,
                                    child: TextFormField(
                                      controller: _controllerFracao,
                                      decoration: const InputDecoration(
                                        labelText: "Fração da Propriedade",
                                        border: OutlineInputBorder(),
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        _Buttons()
                      ],
                    );
                  }),
                ),
              ),
            ),
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
            onPressed: () => {appRepository.setPage(FracaoPropPage())},
            child: Text("Cancelar"),
          ),
        ],
      ),
    );
  }

  _onClickSalvar() async {
    FracaoPropApi fracaoPropApi = FracaoPropApi();

 int Fracao = int.parse(_controllerFracao.text);
// int IDEntidade = int.parse(_controllerIDEntidade.text);
    //int Fracao = int.parse(_controllerFracao.text);

    var listEnti = listEntidades
        .where((element) => element.Nome == listEntidadesSelecionado.Nome)
        .toList();
//var listPropriedades = listPropriedades.where((element) => element.Nome == listPropriedadesSelecionado.Nome).toList();

    int? idEntidades = 10; //listEnti[0].Id;
    int? idPropriedades = 11; //listPropriedades[0].Id;

    FracaoPropModel oFracaoProp = FracaoPropModel(
      ID: widget.fracaoPropModel.ID,
      IDEntidade: idEntidades,
      IDPropriedade: idPropriedades,
      Fracao: Fracao,
    );

    var messageReturn = await fracaoPropApi.updateGrupo(oFracaoProp);

    if (messageReturn["type"] == "S") {
      Fluttertoast.showToast(
          msg: messageReturn["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);

      AppModel app = Provider.of<AppModel>(context, listen: false);
      app.setPage(FracaoPropPage());
    }
  }

  _onClickAdd() async {
    if (_controllerIDEntidade.text == "") {
      _onClickDialog();
      return;
    }
    FracaoPropApi fracaoPropApi = FracaoPropApi();

    var listEnti = listEntidades
        .where((element) => element.Nome == listEntidadesSelecionado.Nome)
        .toList();

int Fracao = int.parse(_controllerFracao.text);
//int IDEntidade = int.parse(_controllerIDEntidade.text);

    int? idEntidades = 10; //listEnti[0].Id;
     int? idPropriedades = 11; //listPropriedades[0].Id;

    FracaoPropModel oFracaoProp = FracaoPropModel(
      ID: widget.fracaoPropModel.ID,
      IDEntidade: idEntidades,
      IDPropriedade: idPropriedades,
      Fracao: Fracao,
    );

    var messageReturn = await fracaoPropApi.createFracaoProp(oFracaoProp);

    if (messageReturn["type"] == "S") {
      Fluttertoast.showToast(
          msg: messageReturn["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      AppModel app = Provider.of<AppModel>(context, listen: false);
      app.setPage(FracaoPropPage());
    } else {
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
