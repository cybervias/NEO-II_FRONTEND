import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neo_application/pages/clientes_grupos/adm_grupos/grupos_model.dart';
import 'package:neo_application/pages/clientes_grupos/controle_escopo/controle_api.dart';
import 'package:neo_application/pages/clientes_grupos/controle_escopo/controle_model.dart';
import 'package:neo_application/pages/clientes_grupos/controle_escopo/controle_page.dart';
import 'package:neo_application/pages/clientes_grupos/entidades_gestoras/entidades_model.dart';
import 'package:neo_application/pages/clientes_grupos/fracao_propriedades/Tabelas_model.dart';
import 'package:neo_application/pages/clientes_grupos/fracao_propriedades/fracao_model.dart';
import 'package:neo_application/pages/clientes_grupos/fracao_propriedades/fracao_page.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propriedades_model.dart';
import 'package:neo_application/pages/provider/app_provider.dart';
import 'package:provider/provider.dart';

class ControleEdit extends StatefulWidget {
  ControleModel controleModel;
  var tipoAcao;

  ControleEdit({Key? key, required this.controleModel, this.tipoAcao})
      : super(key: key);

  @override
  State<ControleEdit> createState() => _ControleEditState();
}

class _ControleEditState extends State<ControleEdit> {
  Size get size => MediaQuery.of(context).size;
  late ControleModel oControle;
  late String _valueEntrada;
  late String _valueSaida;

  final TextEditingController _controllerID = TextEditingController();
  final TextEditingController _controlleridFracao = TextEditingController();
  final TextEditingController _controlleridEntidade = TextEditingController();
  final TextEditingController _controlleridPropriedade =
      TextEditingController();
  final TextEditingController _controlleridGrupo = TextEditingController();
  final TextEditingController _controllerDataEntrada = TextEditingController();
  final TextEditingController _controllerDataSaida = TextEditingController();
  final TextEditingController _controllerRequerenteSaida =
      TextEditingController();
  final TextEditingController _controllerAreaEscopo = TextEditingController();
  final TextEditingController _controllerAreaAuditada = TextEditingController();
  final TextEditingController _controllerCicloTrabalho =
      TextEditingController();

  late AppModel appRepository;
  late ControleModel oControleModel;
  EntidadesModel valueSelected = EntidadesModel(); //TODO excluir

  EntidadesModel listEntidadesSelecionado = EntidadesModel();
  PropriedadesModel listPropriedadeSelecionado = PropriedadesModel();
  EntidadesModel listFracaoSelecionado = EntidadesModel();
  FracaoPropModel listGrupoSelecionado = FracaoPropModel();

  TodasTabelasModel todasTabelas = TodasTabelasModel();

  List<EntidadesModel> listEntidades = [];
  List<PropriedadesModel> listPropriedade = [];
  List<FracaoPropModel> listFracao = [];
  List<GruposModel> listGrupos = [];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _setText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    oControleModel = widget.controleModel;
    appRepository = Provider.of<AppModel>(context);
    return Scaffold(
      body: _body(),
      appBar: AppBar(
        title: Text(widget.tipoAcao == "editar"
            ? "Editar Fração (${widget.controleModel.ID})"
            : "Criar Nova Fração"),
        backgroundColor: Color.fromRGBO(68, 76, 87, 2),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
    );
  }

  _setText() {
    oControle = widget.controleModel;
    _controllerID.text = oControle.ID.toString();
    _controlleridFracao.text = oControle.idFracao.toString();
    _controlleridEntidade.text = oControle.idEntidade.toString();
    _controlleridPropriedade.text = oControle.idPropriedade.toString();
    _controlleridGrupo.text = oControle.idGrupo.toString();
    _controllerDataEntrada.text = oControle.DataEntrada.toString();
    _controllerDataSaida.text = oControle.DataSaida.toString();
    _controllerRequerenteSaida.text = oControle.RequerenteSaida.toString();
    _controllerAreaEscopo.text = oControle.AreaEscopo.toString();
    _controllerAreaAuditada.text = oControle.AreaAuditada.toString();
    _controllerCicloTrabalho.text = oControle.CicloTrabalho.toString();

    if (listPropriedadeSelecionado.idPropriedade == null &&
        oControle.idPropriedade != 0) {
      listPropriedadeSelecionado.idPropriedade = oControle.idPropriedade;
    }
    if (listEntidadesSelecionado.Id == null && oControle.idEntidade != 0) {
      listEntidadesSelecionado.Id = oControle.idEntidade;
    }
    if (listFracaoSelecionado.Id == null && oControle.idFracao != 0) {
      listFracaoSelecionado.Id = oControle.idFracao;
    }
    if (listGrupoSelecionado.ID == null && oControle.idGrupo != 0) {
      listGrupoSelecionado.ID = oControle.idGrupo;
    }
    /*listEntidadesSelecionado.Nome =
        valueSelected.Nome != null ? valueSelected.Nome : oGrupo.IDGestor.toString();*/
  }

  _body() {
//List _listEntidades = EntidadesApi().getListEntidades();

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
          listFracao = todasTabelas.fracaoPropriedades!;
          listGrupos = todasTabelas.grupos!;

          List<EntidadesModel> listEntidadesValue = [];
          List<PropriedadesModel> listPropriedadeValue = [];
          List<FracaoPropModel> listFracaoValue = [];
          List<GruposModel> listGruposValue = [];

          //listEntidadesSelecionado.Nome = listEntidades[0].Nome;

          /* if (oFracaoProp != null) {
            listEntidadesValue = listEntidades
                .where((entidades) => entidades.Id == oFracaoProp.IDEntidade)
                .toList();
            print(listEntidades);

            listPropriedadeValue = listPropriedade
                .where((propriedade) =>
                    propriedade.idPropriedade == oFracaoProp.IDPropriedade)
                .toList();
            print(listPropriedade);
          }*/

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
                                      border: Border.all(width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButton<String>(
                                          hint: Text("Fração da Propriedade"),
                                          isDense: true,
                                          isExpanded: true,
                                          value: listFracaoSelecionado.Id != null ? listFracaoSelecionado.Id.toString() : listFracao[0].ID.toString(),
                                          onChanged: (newValue) => {
                                            setState(() {
                                              listFracaoSelecionado.Id = int.parse("$newValue");
                                            }),
                                          },
                                          items: listFracao.map<DropdownMenuItem<String>>((value) {
                                            return DropdownMenuItem<String>(
                                              value: value.ID.toString(),
                                              child: Text(value.Fracao.toString()),
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
                                          value: listPropriedadeSelecionado
                                                      .idPropriedade !=
                                                  null
                                              ? listPropriedadeSelecionado
                                                  .idPropriedade
                                                  .toString()
                                              : listPropriedade[0]
                                                  .idPropriedade
                                                  .toString(),
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
                                              value: value.idPropriedade
                                                  .toString(),
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
                                        border: Border.all(width: 1, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: ButtonTheme(
                                          alignedDropdown: true,
                                          child: DropdownButton<String>(
                                            hint: Text("Grupos"),
                                            isDense: true,
                                            isExpanded: true,
                                            value: listGrupoSelecionado.ID != null ? listGrupoSelecionado.ID.toString() : listGrupos[0].idGrupo.toString(),
                                            onChanged: (newValue) => {
                                              setState(() {
                                                listGrupoSelecionado.ID = int.parse("$newValue");
                                              }),
                                            },
                                            items: listGrupos.map<DropdownMenuItem<String>>((value) {
                                              return DropdownMenuItem<String>(
                                                value: value.idGrupo.toString(),
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
                                    child: TextFormField(
                                     /* validator: (value) {
                                        if (value == "" || value == 0) {
                                          return "Campo obrigatorio";
                                        }
                                        return null;
                                      },*/

                                      controller: _controllerDataEntrada,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        labelText: "Data Entrada",
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
                                              setState(() => _valueEntrada = data.toString());

                                            _controllerDataEntrada.text =  _valueEntrada.substring(8, 10) + '/' + _valueEntrada.substring(5, 7) +  '/' + _valueEntrada.substring(0, 4);
                                      
                                            print( _controllerDataEntrada.text);
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
                                    child: TextFormField(
                                      /*validator: ((value) {
                                        if (value == "" || value == 0) {
                                          return "Campo obrigatorio";
                                        }
                                        return null;
                                      }),*/
                                      controller: _controllerDataSaida,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        labelText: "Data Saída",
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
                                              setState(() => _valueSaida = data.toString());

                                            _controllerDataSaida.text =  _valueSaida.substring(8, 10) + '/' + _valueSaida.substring(5, 7) +  '/' + _valueSaida.substring(0, 4);
                                      
                                            print( _controllerDataSaida.text);
                                          },
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
                                      controller: _controllerRequerenteSaida,
                                      decoration: const InputDecoration(
                                        labelText: "Requerente de Saída",
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
                                    height: 40,
                                    child: TextFormField(
                                      controller: _controllerAreaEscopo,
                                      decoration: const InputDecoration(
                                        labelText: "Área Escopo",
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
                                    height: 40,
                                    child: TextFormField(
                                      controller: _controllerAreaAuditada,
                                      decoration: const InputDecoration(
                                        labelText: "Área Auditada",
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
                                    height: 40,
                                    child: TextFormField(
                                      controller: _controllerCicloTrabalho,
                                      decoration: const InputDecoration(
                                        labelText: "Ciclo Trabalho",
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
            onPressed: () => {appRepository.setPage(ControlePage())},
            child: Text("Cancelar"),
          ),
        ],
      ),
    );
  }

  _onClickSalvar() async {
    if (_controllerDataEntrada.text == "" || _controllerDataSaida.text == "") {
      _onClickDialog();
      return;
    }

    /*if (!_formKey.currentState!.validate()) {
      _onClickDialog();
      return;
    }*/

    

    var listFrac = listFracao.where((element) => element.ID == listFracaoSelecionado.Id).toList();
    var listEnti = listEntidades.where((element) => element.Id == listEntidadesSelecionado.Id) .toList();
    var listProp = listPropriedade.where((element) =>element.idPropriedade == listPropriedadeSelecionado.idPropriedade).toList();
    var listGrup = listGrupos.where((element) => element.idGrupo == listGrupoSelecionado.ID).toList();

    int? idFracao = listFrac[0].ID;
    int? idEntidades = listEnti[0].Id;
    int? idPropriedades = listProp[0].idPropriedade;
    int? idGrupos = listGrup[0].idGrupo;

    var DataEntrada =_controllerDataEntrada.text.substring(3, 5) + '/' + _controllerDataEntrada.text.substring(0, 2) +  '/' + _controllerDataEntrada.text.substring(6, 10);
    var DataSaida =_controllerDataSaida.text.substring(3, 5) + '/' + _controllerDataSaida.text.substring(0, 2) +  '/' + _controllerDataSaida.text.substring(6, 10);

    double AreaEscopo = double.parse(_controllerAreaEscopo.text);
    double AreaAuditada = double.parse(_controllerAreaAuditada.text);
    int CicloTrabalho = int.parse(_controllerCicloTrabalho.text);

    ControleApi controleApi = ControleApi();

    ControleModel oControle = ControleModel(
      ID: widget.controleModel.ID,
      idFracao: idFracao,
      idEntidade: idEntidades,
      idPropriedade: idPropriedades,
      idGrupo: idGrupos,
      DataEntrada: DataEntrada.toString(),
      DataSaida: DataSaida.toString(),
      RequerenteSaida: _controllerRequerenteSaida.text.toString(),
      AreaEscopo: AreaEscopo,
      AreaAuditada: AreaAuditada,
      CicloTrabalho: CicloTrabalho,
    );

    var messageReturn = await controleApi.updateControle(oControle);

    if (messageReturn["type"] == "S") {
      Fluttertoast.showToast(
          msg: messageReturn["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);

      AppModel app = Provider.of<AppModel>(context, listen: false);
      app.setPage(ControlePage());
    }
  }

  _onClickAdd() async {
    if (_controllerDataEntrada.text == "" || _controllerDataSaida.text == "") {
      _onClickDialog();
      return;
    }

    /*if (!_formKey.currentState!.validate()) {
      _onClickDialog();
      return;
    }*/
    
    var listFrac = listFracao.where((element) => element.ID == listFracaoSelecionado.Id).toList();
    var listEnti = listEntidades.where((element) => element.Id == listEntidadesSelecionado.Id) .toList();
    var listProp = listPropriedade.where((element) =>element.idPropriedade == listPropriedadeSelecionado.idPropriedade).toList();
    var listGrup = listGrupos.where((element) => element.idGrupo == listGrupoSelecionado.ID).toList();

    int? idFracao = listFrac[0].ID;
    int? idEntidades = listEnti[0].Id;
    int? idPropriedades = listProp[0].idPropriedade;
    int? idGrupos = listGrup[0].idGrupo;

    var DataEntrada =_controllerDataEntrada.text.substring(3, 5) + '/' + _controllerDataEntrada.text.substring(0, 2) +  '/' + _controllerDataEntrada.text.substring(6, 10);
    var DataSaida =_controllerDataSaida.text.substring(3, 5) + '/' + _controllerDataSaida.text.substring(0, 2) +  '/' + _controllerDataSaida.text.substring(6, 10);

    double AreaEscopo = double.parse(_controllerAreaEscopo.text);
    double AreaAuditada = double.parse(_controllerAreaAuditada.text);
    int CicloTrabalho = int.parse(_controllerCicloTrabalho.text);

    ControleApi controleApi = ControleApi();

    ControleModel oControle = ControleModel(
      ID: widget.controleModel.ID,
      idFracao: idFracao,
      idEntidade: idEntidades,
      idPropriedade: idPropriedades,
      idGrupo: idGrupos,
      DataEntrada: DataEntrada.toString(),
      DataSaida: DataSaida.toString(),
      RequerenteSaida: _controllerRequerenteSaida.text.toString(),
      AreaEscopo: AreaEscopo,
      AreaAuditada: AreaAuditada,
      CicloTrabalho: CicloTrabalho,
    );

    var messageReturn = await controleApi.createControle(oControle);

    if (messageReturn["type"] == "S") {
      Fluttertoast.showToast(
          msg: messageReturn["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      AppModel app = Provider.of<AppModel>(context, listen: false);
      app.setPage(ControlePage());
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
            height: 70,
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
