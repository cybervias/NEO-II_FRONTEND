import 'dart:convert';

class TipoProdutoModel {
  int? ID;
  String? Descricao;

  TipoProdutoModel({
    this.ID,
    this.Descricao,
  });

  TipoProdutoModel copyWith({
    int? ID,
    String? Descricao,
  }) {
    return TipoProdutoModel(
      ID: ID ?? this.ID,
      Descricao: Descricao ?? this.Descricao,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(ID != null){
      result.addAll({'ID': ID});
    }
    if(Descricao != null){
      result.addAll({'Descricao': Descricao});
    }
  
    return result;
  }

  factory TipoProdutoModel.fromMap(Map<String, dynamic> map) {
    return TipoProdutoModel(
      ID: map['ID']?.toInt(),
      Descricao: map['Descricao'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TipoProdutoModel.fromJson(String source) => TipoProdutoModel.fromMap(json.decode(source));

  @override
  String toString() => 'TipoProdutoModel(ID: $ID, Descricao: $Descricao)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TipoProdutoModel &&
      other.ID == ID &&
      other.Descricao == Descricao;
  }

  @override
  int get hashCode => ID.hashCode ^ Descricao.hashCode;
}
