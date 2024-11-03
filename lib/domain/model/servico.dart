import 'package:cloud_firestore/cloud_firestore.dart';

class Servico {
  String id;
  String tipo;
  String porte;
  String nome;
  double preco;
  int duracao;

  Servico({
    required this.id,
    required this.tipo,
    required this.porte,
    required this.nome,
    required this.preco,
    required this.duracao,
  });

  // Converter para JSON para salvar no Firestore
  Map<String, dynamic> toJson() {
    return {
      'tipo': tipo,
      'porte': porte,
      'nome': nome,
      'preco': preco,
      'duracao': duracao,
    };
  }

  // Criar a partir de um Map (ou LinkedMap)
  factory Servico.fromMap(Map<String, dynamic> data) {
    return Servico(
      id: data['id'] ?? '',
      tipo: data['tipo'] ?? '',
      porte: data['porte'] ?? '',
      nome: data['nome'] ?? '',
      preco: (data['preco'] ?? 0).toDouble(),
      duracao: (data['duracao'] ?? 0).toInt(),
    );
  }

  // Criar a partir de um DocumentSnapshot
  factory Servico.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Servico(
      id: doc.id,
      tipo: data['tipo'],
      porte: data['porte'],
      nome: data['nome'] ?? '',
      preco: (data['preco'] ?? 0).toDouble(),
      duracao: (data['duracao'] ?? 0).toInt(),
    );
  }
}
