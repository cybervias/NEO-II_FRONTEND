import 'dart:convert';

class PropProdutoModel {
  int? ID;
  int? IDPropriedade;
  int? IDTipoManejo;

  PropProdutoModel({
    this.ID,
    this.IDPropriedade,
    this.IDTipoManejo,
  });

  PropProdutoModel copyWith({
    int? ID,
    int? IDPropriedade,
    int? IDTipoManejo,
  }) {
    return PropProdutoModel(
      ID: ID ?? this.ID,
      IDPropriedade: IDPropriedade ?? this.IDPropriedade,
      IDTipoManejo: IDTipoManejo ?? this.IDTipoManejo,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(ID != null){
      result.addAll({'ID': ID});
    }
    if(IDPropriedade != null){
      result.addAll({'IDPropriedade': IDPropriedade});
    }
    if(IDTipoManejo != null){
      result.addAll({'IDTipoManejo': IDTipoManejo});
    }
  
    return result;
  }

  factory PropProdutoModel.fromMap(Map<String, dynamic> map) {
    return PropProdutoModel(
      ID: map['ID']?.toInt(),
      IDPropriedade: map['IDPropriedade']?.toInt(),
      IDTipoManejo: map['IDTipoManejo']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PropProdutoModel.fromJson(String source) => PropProdutoModel.fromMap(json.decode(source));

  @override
  String toString() => 'PropProdutoModel(ID: $ID, IDPropriedade: $IDPropriedade, IDTipoManejo: $IDTipoManejo)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PropProdutoModel &&
      other.ID == ID &&
      other.IDPropriedade == IDPropriedade &&
      other.IDTipoManejo == IDTipoManejo;
  }

  @override
  int get hashCode => ID.hashCode ^ IDPropriedade.hashCode ^ IDTipoManejo.hashCode;
}
