import 'package:cloud_firestore/cloud_firestore.dart';

class Servico {
  final String id;
  final String nome;
  final double preco;
  final int duracao;

  Servico({
    required this.id,
    required this.nome,
    required this.preco,
    required this.duracao,
  });

  // Converter para JSON para salvar no Firestore
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'preco': preco,
      'duracao': duracao,
    };
  }

  // Criar a partir de um Map (ou LinkedMap)
  factory Servico.fromMap(Map<String, dynamic> data) {
    return Servico(
      id: data['id'] ?? '',
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
      nome: data['nome'] ?? '',
      preco: (data['preco'] ?? 0).toDouble(),
      duracao: (data['duracao'] ?? 0).toInt(),
    );
  }
}
