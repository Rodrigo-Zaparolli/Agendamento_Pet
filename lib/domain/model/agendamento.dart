import 'package:agendamento_pet/domain/model/servico.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Agendamento {
  String? id;
  String petId;
  String userId; // ID do usuário associado ao agendamento
  String petNome;
  String raca;
  String idade;
  String peso;
  String sexo;
  DateTime dataHora;
  Servico servico;

  Agendamento({
    this.id,
    required this.petId,
    required this.userId,
    required this.petNome,
    required this.raca,
    required this.idade,
    required this.peso,
    required this.sexo,
    required this.dataHora,
    required this.servico,
  });

  // Converter para JSON para salvar no Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id, // Incluindo o id para o caso de atualização
      'petId': petId,
      'userId': userId,
      'petNome': petNome,
      'raca': raca,
      'idade': idade,
      'peso': peso,
      'sexo': sexo,
      'dataHora': Timestamp.fromDate(dataHora),
      'servico': servico.toJson(),
    };
  }

  // Criar a partir de um Map (ou LinkedMap)
  factory Agendamento.fromMap(Map<String, dynamic> data) {
    return Agendamento(
      id: data['id'], // id pode ser nulo se não estiver presente
      petId: data['petId'] ?? '',
      userId: data['userId'] ?? '', // Garantindo um valor padrão
      petNome: data['petNome'] ?? '',
      raca: data['raca'] ?? '',
      idade: data['idade'] ?? '',
      peso: data['peso'] ?? '',
      sexo: data['sexo'] ?? '',
      dataHora: (data['dataHora'] as Timestamp?)?.toDate() ?? DateTime.now(),
      servico:
          Servico.fromMap(data['servico'] ?? {}), // Garantindo um objeto padrão
    );
  }

  // Criar a partir de um documento do Firestore
  factory Agendamento.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Agendamento(
      id: doc.id,
      petId: data['petId'] ?? '',
      userId: data['userId'] ?? '',
      petNome: data['petNome'] ?? '',
      raca: data['raca'] ?? '',
      idade: data['idade'] ?? '',
      peso: data['peso'] ?? '',
      sexo: data['sexo'] ?? '',
      dataHora: (data['dataHora'] as Timestamp?)?.toDate() ?? DateTime.now(),
      servico: Servico.fromMap(data['servico'] ?? {}),
    );
  }
}
