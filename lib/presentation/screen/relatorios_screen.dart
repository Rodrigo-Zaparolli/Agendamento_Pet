import 'package:agendamento_pet/core/utils/colors.dart';
import 'package:agendamento_pet/presentation/widgets/custom_container_widget.dart';
import 'package:flutter/material.dart';

class RelatoriosScreen extends StatelessWidget {
  const RelatoriosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainerWidget(
        color: MColors.cian,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DropdownButtonFormField(
                items:
                    ['Agendamentos', 'Clientes', 'Serviços'].map((relatorio) {
                  return DropdownMenuItem(
                      value: relatorio, child: Text(relatorio));
                }).toList(),
                onChanged: (value) {},
                decoration:
                    const InputDecoration(labelText: 'Tipo de Relatório'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implementar geração de relatório
                },
                child: const Text('Gerar Relatório'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
