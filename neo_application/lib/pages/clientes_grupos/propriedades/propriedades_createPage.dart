import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propManejo/propManejo_model.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propriedades_api.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propriedades_busy.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propriedades_model.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propriedades_page.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/tipoManejo/dropDownController.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/tipoProduto/dropDownController.dart';
import 'package:neo_application/pages/provider/app_provider.dart';
import 'package:neo_application/pages/utils/DecimalText.dart';
import 'package:neo_application/pages/utils/list_uf.dart';
import 'package:provider/provider.dart';
import 'tipoFloresta/dropDownController.dart';

class PropriedadesCreate extends StatefulWidget {
  var tipoAcao;
  var indice;

  PropriedadesCreate({Key? key, this.tipoAcao, this.indice}) : super(key: key);

  @override
  State<PropriedadesCreate> createState() => _PropriedadesCreateState();
}

class _PropriedadesCreateState extends State<PropriedadesCreate> {
  Size get size => MediaQuery.of(context).size;

  var listIndice;

  List ListTipoManejo = [
    {"ID": 1, "Descricao": "Descrição Teste 1"},
    {"ID": 2, "Descricao": "tipo manejo 1"},
    {"ID": 3, "Descricao": "tipo manejo 2"},
    {"ID": 4, "Descricao": "tipo manejo 3"}
  ];

//DOGLAS - 23/03
  List<PropManejoModel> listPropManejo = [];
  List<PropriedadesModel> listProp = [];

  DropDownController dropDownController = DropDownController();

  DropDownControllerFloresta dropDownControllerFloresta =
      DropDownControllerFloresta();

  DropDownControllerProduto dropDownControllerProduto =
      DropDownControllerProduto();

  PropriedadesBusy? propriedadesBusy;

  Uf? ufController = Uf();

  bool isLoading = false;
//DOGLAS - 23-03

  late PropriedadesModel oProp;

  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerCNPJ = TextEditingController();
  final TextEditingController _controllerXCoord = TextEditingController();
  final TextEditingController _controllerYCoord = TextEditingController();
  final TextEditingController _controllerAreaPropriedade =
      TextEditingController();
  final TextEditingController _controllerAreaTotal = TextEditingController();
  final TextEditingController _controllerAreaPlantada = TextEditingController();
  final TextEditingController _controllerAreaEstimaConser =
      TextEditingController();
  final TextEditingController _controllerAreaInfraestrutura =
      TextEditingController();
  final TextEditingController _controllerAreaOutro = TextEditingController();
  final TextEditingController _controllerLocalizacao = TextEditingController();

  late AppModel appRepository;
  double constWidth = 300;
  String? listUfSelecionado;
  String? valueSelected;

  @override
  Widget build(BuildContext context) {
    appRepository = Provider.of<AppModel>(context);
    propriedadesBusy = Provider.of<PropriedadesBusy>(context);
    return Scaffold(
      body: _body(),
      appBar: AppBar(
        title: Text("Criar Nova Propriedade"),
        backgroundColor: Color.fromRGBO(68, 76, 87, 2),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
    );
  }

  _setText() async {
    listIndice = widget.indice;
  }

  _body() {
    return FutureBuilder(
      future: PropriedadesApi().getListPropriedades(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Erro ao carregar os dados"));
        }
        if (snapshot.hasData) {
          listProp = snapshot.data;

          List<String> listUfs = Uf().listUfs();
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
                          SizedBox(
                            width: constWidth,
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
                            height: 20,
                          ),
                          SizedBox(
                            width: constWidth,
                            height: 30,
                            child: TextFormField(
                              controller: _controllerCNPJ,
                              decoration: const InputDecoration(
                                labelText: "CNPJ",
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: constWidth,
                            height: 30,
                            child: TextFormField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+.?\d{0,2}'))
                              ],
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              controller: _controllerXCoord,
                              decoration: const InputDecoration(
                                labelText: "XCoord",
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: constWidth,
                            height: 30,
                            child: TextFormField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+.?\d{0,2}'))
                              ],
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              controller: _controllerYCoord,
                              decoration: const InputDecoration(
                                labelText: "YCoord",
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: constWidth,
                            height: 30,
                            child: TextFormField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+.?\d{0,2}'))
                              ],
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              controller: _controllerAreaPropriedade,
                              decoration: const InputDecoration(
                                labelText: "Área da Propriedade",
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: constWidth,
                            height: 30,
                            child: TextFormField(
                              controller: _controllerAreaTotal,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+.?\d{0,2}'))
                              ],
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              decoration: const InputDecoration(
                                labelText: "Área Total",
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: constWidth,
                            height: 30,
                            child: TextFormField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+.?\d{0,2}'))
                              ],
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              controller: _controllerAreaPlantada,
                              decoration: const InputDecoration(
                                labelText: "Área Plantada",
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: constWidth,
                            height: 30,
                            child: TextFormField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+.?\d{0,2}'))
                              ],
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              controller: _controllerAreaEstimaConser,
                              decoration: const InputDecoration(
                                labelText: "Área Estimada de Conservação",
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: constWidth,
                            height: 30,
                            child: TextFormField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+.?\d{0,2}'))
                              ],
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              controller: _controllerAreaInfraestrutura,
                              decoration: const InputDecoration(
                                labelText: "Área de Infraestrutura",
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: constWidth,
                            height: 30,
                            child: TextFormField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+.?\d{0,2}'))
                              ],
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              controller: _controllerAreaOutro,
                              decoration: const InputDecoration(
                                labelText: " Outras Áreas",
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: constWidth,
                            height: 30,
                            child: TextFormField(
                              controller: _controllerLocalizacao,
                              decoration: const InputDecoration(
                                labelText: "Localização",
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: constWidth,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  hint: Text("UF"),
                                  isDense: true,
                                  isExpanded: true,
                                  value: listUfSelecionado,
                                  onChanged: (newValue) => {
                                    setState(() {
                                      valueSelected = newValue;
                                      listUfSelecionado = valueSelected;
                                    })
                                  },
                                  items: listUfs.map((String value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
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
                           _Buttons(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const Center(
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
            onPressed: () => _onClickAdd(),
            child: Text("Adicionar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(246, 34, 37, 44)),
            onPressed: () => {appRepository.setPage(PropriedadesPage())},
            child: Text("Cancelar"),
          ),
        ],
      ),
    );
  }

  _onClickAdd() async {
    if (_controllerNome.text == "" ||
        _controllerCNPJ.text == "" ||
        _controllerXCoord.text == "" ||
        _controllerYCoord.text == "") {
      _onClickDialog();
      return;
    }

   
    double areaPropriedade;
    double areaTotal;
    double areaPlantada;
    double areaEstimaConservacao;
    double areaInfraestrutura;
    double areaOutrosUsos;

    double xCoord = double.parse(_controllerXCoord.text.replaceAll(",", "."));
    
    double yCoord = double.parse(_controllerYCoord.text.replaceAll(",", "."));

    if (_controllerAreaPropriedade.text.isEmpty) {
      areaPropriedade = 0;
    } else {
      areaPropriedade = double.parse(_controllerAreaPropriedade.text.replaceAll(",", "."));
    }

    if (_controllerAreaTotal.text.isEmpty) {
      areaTotal = 0;
    } else {
      areaTotal = double.parse(_controllerAreaTotal.text.replaceAll(",", "."));
    }

    if (_controllerAreaPlantada.text.isEmpty) {
      areaPlantada = 0;
    } else {
      areaPlantada = double.parse(_controllerAreaPlantada.text.replaceAll(",", "."));
    }

    if (_controllerAreaEstimaConser.text.isEmpty) {
      areaEstimaConservacao = 0;
    } else {
      areaEstimaConservacao = double.parse(_controllerAreaEstimaConser.text.replaceAll(",", "."));
    }

    if (_controllerAreaInfraestrutura.text.isEmpty) {
      areaInfraestrutura = 0;
    } else {
      areaInfraestrutura = double.parse(_controllerAreaInfraestrutura.text.replaceAll(",", "."));
    }

    if (_controllerAreaOutro.text.isEmpty) {
      areaOutrosUsos = 0;
    } else {
      areaOutrosUsos = double.parse(_controllerAreaOutro.text.replaceAll(",", "."));
    }

    PropriedadesApi propriedadesApi = PropriedadesApi();

    PropriedadesModel oProp = PropriedadesModel(
        Nome: _controllerNome.text,
        CNPJ: _controllerCNPJ.text,
        XCoord: xCoord,
        yCoord: yCoord,
        AreaPropriedade: areaPropriedade,
        AreaTotal: areaTotal,
        AreaPlantada: areaPlantada,
        AreaEstimaConservacao: areaEstimaConservacao,
        AreaInfraestrutura: areaInfraestrutura,
        AreaOutrosUsos: areaOutrosUsos,
        Localizacao: _controllerLocalizacao.text ?? "",
        UF: listUfSelecionado ?? ""
        );

    var messageReturn = await propriedadesApi.createPropriedade(oProp);

    if (messageReturn["type"] == "S") {
      Fluttertoast.showToast(
          msg: messageReturn["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 10,
          fontSize: 16.0);
      AppModel app = Provider.of<AppModel>(context, listen: false);
      app.setPage(PropriedadesPage());
    }else {
      Fluttertoast.showToast(
          msg: messageReturn["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 10,
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
                  "Preencha os campos obrigatorios. \n\n    Nome, CNPJ, XCoord, YCoord."),
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
