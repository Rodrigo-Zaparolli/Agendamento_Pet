import 'package:agendamento_pet/core/utils/colors.dart';
import 'package:agendamento_pet/presentation/widgets/custom_container_widget.dart';
import 'package:flutter/material.dart';

class PetsScreen extends StatelessWidget {
  const PetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainerWidget(
      color: MColors.cian,
      child: const Center(
        child: Text("Pets"),
      ),
    );
  }
}
