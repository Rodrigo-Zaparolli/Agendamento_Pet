// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pet _$PetFromJson(Map<String, dynamic> json) => Pet(
      id: json['id'] as String,
      nome: json['nome'] as String,
      raca: json['raca'] as String,
      porte: json['porte'] as String,
      nascimento: json['nascimento'] as String,
      idade: json['idade'] as String,
      peso: json['peso'] as String,
      sexo: json['sexo'] as String,
      tipo: json['tipo'] as String,
    );

Map<String, dynamic> _$PetToJson(Pet instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'raca': instance.raca,
      'porte': instance.porte,
      'nascimento': instance.nascimento,
      'idade': instance.idade,
      'peso': instance.peso,
      'sexo': instance.sexo,
      'tipo': instance.tipo,
    };
