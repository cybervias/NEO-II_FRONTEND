import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neo_application/pages/clientes_grupos/entidades_gestoras/entidades_model.dart';
import 'package:neo_application/pages/clientes_grupos/fracao_propriedades/Tabelas_model.dart';
import 'package:neo_application/pages/clientes_grupos/fracao_propriedades/fracao_api.dart';
import 'package:neo_application/pages/clientes_grupos/fracao_propriedades/fracao_model.dart';
import 'package:neo_application/pages/clientes_grupos/fracao_propriedades/fracao_page.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propManejo/propManejo_model.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propriedades_model.dart';
import 'package:neo_application/pages/provider/app_provider.dart';
import 'package:provider/provider.dart';

class PropManejoCreate extends StatefulWidget {
  PropManejoModel propManejoModel;
  var tipoAcao;

  PropManejoCreate({Key? key, required this.propManejoModel, this.tipoAcao})
      : super(key: key);

  @override
  State<PropManejoCreate> createState() => _PropManejoCreateState();
}

class _PropManejoCreateState extends State<PropManejoCreate> {
  Size get size => MediaQuery.of(context).size;
  late PropManejoModel opropManejo;
  late String _value;

  final TextEditingController _controllerID = TextEditingController();
  final TextEditingController _controllerIDTipoManejo = TextEditingController();
  final TextEditingController _controllerIDPropriedade = TextEditingController();

  late AppModel appRepository;
  late PropManejoModel opropManejoModel;
  EntidadesModel valueSelected = EntidadesModel();

  EntidadesModel listEntidadesSelecionado = EntidadesModel();
  PropriedadesModel listPropriedadeSelecionado = PropriedadesModel();
  TodasTabelasModel todasTabelas = TodasTabelasModel();

  List<EntidadesModel> listEntidades = [];
  List<PropriedadesModel> listPropriedade = [];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _setText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    opropManejoModel = widget.propManejoModel;
    appRepository = Provider.of<AppModel>(context);
    return Scaffold(
      body: _body(),
      appBar: AppBar(
        title: Text("Criar Novo Propriedade de Manejo"),
        backgroundColor: Color.fromRGBO(68, 76, 87, 2),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
    );
  }

  _setText() {
    opropManejo = widget.propManejoModel;
    _controllerID.text = opropManejo.ID.toString();
    _controllerIDTipoManejo.text = opropManejo.IDTipoManejo.toString();
    _controllerIDPropriedade.text = opropManejo.IDPropriedade.toString();
    if (listPropriedadeSelecionado.idPropriedade == null && opropManejo.IDPropriedade != 0) {
      listPropriedadeSelecionado.idPropriedade = opropManejo.IDPropriedade;
    }
    if (listEntidadesSelecionado.Id == null && opropManejo.IDTipoManejo != 0) {
      listEntidadesSelecionado.Id = opropManejo.IDTipoManejo;
    }
    }

  _body() {

    return FutureBuilder(
      future: TodasTabelas().getTodasTabelas(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Erro ao carregar os dados"));
        }
        if (snapshot.hasData) {
          todasTabelas = snapshot.data;
          listEntidades = todasTabelas.entidades!;
          listPropriedade = todasTabelas.propriedades!;
          List<EntidadesModel> listEntidadesValue = [];
          List<PropriedadesModel> listPropriedadeValue = [];

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
                                          value: listEntidadesSelecionado.Id != null ? listEntidadesSelecionado.Id.toString() : listEntidades[0].Id.toString(),
                                          onChanged: (newValue) => {
                                            setState(() {
                                              listEntidadesSelecionado.Id =
                                                  int.parse("$newValue");

                                              print(newValue.toString());
                                            }),
                                          },
                                          items: listEntidades.map<DropdownMenuItem<String>>(
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
                                          value: listPropriedadeSelecionado.idPropriedade != null ? listPropriedadeSelecionado.idPropriedade.toString() : listPropriedade[0].idPropriedade.toString(),
                                          onChanged: (newValue) => {
                                            setState(() {
                                              listPropriedadeSelecionado
                                                      .idPropriedade =
                                                  int.parse("$newValue");

                                              print(newValue.toString());
                                            }),
                                          },
                                          items: listPropriedade
                                              .map<DropdownMenuItem<String>>(
                                                  (value) {
                                            return DropdownMenuItem<String>(
                                              value: value.idPropriedade.toString(), 
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
                                      controller: _controllerIDTipoManejo,
                                      decoration: const InputDecoration(
                                        labelText: "Tipo de manejo",
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
   /* FracaoPropApi fracaoPropApi = FracaoPropApi();

    int Fracao = int.parse(_controllerFracao.text);

    var listEnti = listEntidades
        .where(
            (element) => element.Id == listEntidadesSelecionado.Id)
        .toList();
    var listPropriedades = listPropriedade
        .where((element) =>
            element.idPropriedade == listPropriedadeSelecionado.idPropriedade)
        .toList();

    int? idEntidades = listEnti[0].Id;
    int? idPropriedades = listPropriedades[0].idPropriedade;

    FracaoPropModel oFracaoProp = FracaoPropModel(
      ID: widget.fracaoPropModel.ID,
      IDEntidade: idEntidades,
      IDPropriedade: idPropriedades,
      Fracao: Fracao,
    );

    var messageReturn = await fracaoPropApi.updateFracaoProp(oFracaoProp);

    if (messageReturn["type"] == "S") {
      Fluttertoast.showToast(
          msg: messageReturn["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);

      AppModel app = Provider.of<AppModel>(context, listen: false);
      app.setPage(FracaoPropPage());
    }*/
  }

  _onClickAdd() async {
    /*if (_controllerFracao.text == "" || _controllerFracao.text == "0") {
      _onClickDialog();
      return;
    }
    FracaoPropApi fracaoPropApi = FracaoPropApi();

    int Fracao = int.parse(_controllerFracao.text);
//int IDEntidade = int.parse(_controllerIDEntidade.text);

    var listEnti = listEntidades
        .where(
            (element) => element.Id == listEntidadesSelecionado.Id)
        .toList();
    var listPropriedades = listPropriedade
        .where((element) =>
            element.idPropriedade == listPropriedadeSelecionado.idPropriedade)
        .toList();

    int? idEntidades = listEnti[0].Id;
    int? idPropriedades = listPropriedades[0].idPropriedade;

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
    }*/
  }

  /*_onClickDialog() => showDialog(
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
      );*/
}
