import 'package:agendamento_pet/core/utils/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MColors.primaryWhiteSmoke,
      child: Center(
        child: SizedBox(
          height: 45.0,
          child:
              Image.asset("assets/images/petshop-footprint-logo-transBg.png"),
        ),
      ),
    );
  }
}
