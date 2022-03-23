import 'dart:convert';

class PropriedadesModel {
  int? idPropriedade;
  String? Nome;
  String? CNPJ;
  int? XCoord;
  int? yCoord;
  double? AreaPropriedade;
  double? AreaTotal;
  double? AreaPlantada;
  double? AreaEstimaConservacao;
  double? AreaInfraestrutura;
  double? AreaOutrosUsos;
  String? Localizacao;
  String? UF;
  var propManejo;
  var tipoManejo;
  var propFloresta;
  var tipoFloresta;
  var propProdutos;
  var produtos; 

  PropriedadesModel({
    this.idPropriedade,
    this.Nome,
    this.CNPJ,
    this.XCoord,
    this.yCoord,
    this.AreaPropriedade,
    this.AreaTotal,
    this.AreaPlantada,
    this.AreaEstimaConservacao,
    this.AreaInfraestrutura,
    this.AreaOutrosUsos,
    this.Localizacao,
    this.UF,
    this.propManejo,
    this.tipoManejo,
    this.propFloresta,
    this.tipoFloresta,
    this.propProdutos,
    this.produtos,

  });

  Map<String, dynamic> toMap() {
    return {
      'idPropriedade': idPropriedade,
      'Nome': Nome,
      'CNPJ': CNPJ,
      'XCoord': XCoord,
      'yCoord': yCoord,
      'AreaPropriedade': AreaPropriedade,
      'AreaTotal': AreaTotal,
      'AreaPlantada': AreaPlantada,
      'AreaEstimaConservacao': AreaEstimaConservacao,
      'AreaInfraestrutura': AreaInfraestrutura,
      'AreaOutrosUsos': AreaOutrosUsos,
      'Localizacao': Localizacao,
      'UF': UF,
      'propManejo': propManejo,
      'tipoManejo': tipoManejo,
      'propFloresta': propFloresta,
      'tipoFloresta': tipoFloresta,
      'propProdutos': propProdutos,
      'produtos': produtos,
    };
  }

  factory PropriedadesModel.fromMap(Map<String, dynamic> map) {
    return PropriedadesModel(
      idPropriedade: map['idPropriedade']?.toInt(),
      Nome: map['Nome'],
      CNPJ: map['CNPJ'],
      XCoord: map['XCoord']?.toInt(),
      yCoord: map['yCoord']?.toInt(),
      AreaPropriedade: map['AreaPropriedade']?.toDouble(),
      AreaTotal: map['AreaTotal']?.toDouble(),
      AreaPlantada: map['AreaPlantada']?.toDouble(),
      AreaEstimaConservacao: map['AreaEstimaConservacao']?.toDouble(),
      AreaInfraestrutura: map['AreaInfraestrutura']?.toDouble(),
      AreaOutrosUsos: map['AreaOutrosUsos']?.toDouble(),
      Localizacao: map['Localizacao'],
      UF: map['UF'],
      propManejo: map['propManejo'],
      tipoManejo: map['tipoManejo'],
      propFloresta: map['propFloresta'],
      tipoFloresta: map['tipoFloresta'],
      propProdutos: map['propProdutos'],
      produtos: map['produtos'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PropriedadesModel.fromJson(String source) =>
      PropriedadesModel.fromMap(json.decode(source));
}
