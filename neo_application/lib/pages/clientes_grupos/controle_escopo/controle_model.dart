class ControleModel {
  int? ID;
  int? idFracao;
  int? idEntidade;
  int?  idPropriedade;
  int?  idGrupo;
  String? DataEntrada;
  String? DataSaida;
  String? RequerenteSaida;
  double? AreaEscopo;
  double? AreaAuditada;
  int? CicloTrabalho;

  ControleModel(
      {this.ID,
      this.idFracao,
      this.idEntidade,
      this.idPropriedade,
      this.idGrupo,
      this.DataEntrada,
      this.DataSaida,
      this.RequerenteSaida,
      this.AreaEscopo,
      this.AreaAuditada,
      this.CicloTrabalho});

  ControleModel.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    idFracao = json['idFracao'];
    idEntidade = json['idEntidade'];
    idPropriedade = json['idPropriedade'];
    idGrupo = json['idGrupo'];
    DataEntrada = json['DataEntrada'];
    DataSaida = json['DataSaida'];
    RequerenteSaida = json['RequerenteSaida'];
    AreaEscopo = json['AreaEscopo'];
    AreaAuditada = json['AreaAuditada'];
    CicloTrabalho = json['CicloTrabalho'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.ID;
    data['idFracao'] = this.idFracao;
    data['idEntidade'] = this.idEntidade;
    data['idPropriedade'] = this.idPropriedade;
    data['idGrupo'] = this.idGrupo;
    data['DataEntrada'] = this.DataEntrada;
    data['DataSaida'] = this.DataSaida;
    data['RequerenteSaida'] = this.RequerenteSaida;
    data['AreaEscopo'] = this.AreaEscopo;
    data['AreaAuditada'] = this.AreaAuditada;
    data['CicloTrabalho'] = this.CicloTrabalho;
    return data;
  }
}