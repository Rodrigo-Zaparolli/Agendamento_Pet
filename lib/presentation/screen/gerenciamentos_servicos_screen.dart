import 'package:flutter/material.dart';

class GerenciamentoDeServicosPage extends StatelessWidget {
  const GerenciamentoDeServicosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gerenciar Serviços')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Nome do Serviço'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Preço'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Duração'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implementar cadastro de serviço
              },
              child: const Text('Cadastrar Serviço'),
            ),
          ],
        ),
      ),
    );
  }
}
