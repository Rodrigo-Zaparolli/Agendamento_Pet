import 'package:agendamento_pet/controller/login_controller.dart';
import 'package:agendamento_pet/core/utils/all_widgets.dart';
import 'package:agendamento_pet/core/utils/colors.dart';
import 'package:agendamento_pet/core/utils/widget_stateful.dart';
import 'package:agendamento_pet/presentation/pages/login_page.dart';
import 'package:agendamento_pet/presentation/widgets/custom_app_bar_widget.dart';
import 'package:agendamento_pet/presentation/widgets/custom_buttom_widget.dart';
import 'package:agendamento_pet/presentation/widgets/custom_container_widget.dart';
import 'package:agendamento_pet/presentation/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState
    extends WidgetStateful<RegistrationPage, LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(
        backgroundColor: MColors.primaryWhiteSmoke,
        centerTile: false,
      ),
      backgroundColor: MColors.primaryWhiteSmoke,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: CustomContainerWidget(
          color: MColors.primaryWhite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 100.0),
                child: Text(
                  "Crie sua conta gratuita",
                  style: boldFont(MColors.textDark, 38.0),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  Text(
                    "Já possui uma conta? ",
                    style: normalFont(MColors.textGrey, 16.0),
                    textAlign: TextAlign.start,
                  ),
                  GestureDetector(
                    child: Text(
                      "Entre!",
                      style: normalFont(MColors.teal, 16.0),
                      textAlign: TextAlign.start,
                    ),
                    onTap: () {
                      controller.formKey.currentState?.reset();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Observer(
                builder: (_) => showAlert(controller),
              ),
              const SizedBox(height: 10.0),
              Form(
                key: controller.formKey,
                child: Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            "Nome",
                            style: normalFont(MColors.textGrey, null),
                          ),
                        ),
                        CustomTextFieldWidget(
                          controller: controller.ctrlNome,
                          labelText: "Nome",
                          onSaved: (val) => controller.name = val,
                          enabled: controller.isEnabled,
                          validator: controller.validateName,
                          obscureText: false,
                          enableSuggestions: true,
                          keyboardType: TextInputType.text,
                          inputFormatters: const [],
                          suffix: null,
                          textfieldBorder: 0.50,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            "Email",
                            style: normalFont(MColors.textGrey, null),
                          ),
                        ),
                        CustomTextFieldWidget(
                          controller: controller.ctrlEmail,
                          labelText: "e.g Remiola2034@gmail.com",
                          onSaved: (val) => controller.email = val,
                          enabled: controller.isEnabled,
                          validator: controller.validateEmail,
                          obscureText: false,
                          enableSuggestions: true,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters: const [],
                          suffix: null,
                          textfieldBorder: 0.50,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            "Senha",
                            style: normalFont(MColors.textGrey, null),
                          ),
                        ),
                        Observer(
                          builder: (context) => CustomTextFieldWidget(
                            controller: controller.ctrlSenha,
                            labelText: "Senha",
                            onSaved: (val) => controller.password = val,
                            enabled: controller.isEnabled,
                            validator: controller.validatePassword,
                            obscureText: controller.obscureText,
                            enableSuggestions: false,
                            keyboardType: TextInputType.text,
                            inputFormatters: const [],
                            suffix: SizedBox(
                              height: 20.0,
                              width: 40.0,
                              child: RawMaterialButton(
                                onPressed: controller.togglePasswordVisibility,
                                child: Icon(controller.obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                            textfieldBorder: 0.50,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      "Sua senha deve ter 6 ou mais caracteres, uma letra maiúscula e deve conter pelo menos um número.",
                      style: normalFont(MColors.blue, null),
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 20.0),
                        controller.isButtonDisabled == true
                            ? CustomButtomWidget(
                                buttonChild: const CircularProgressIndicator(),
                                onPressed: () {},
                                color: Colors.white)
                            : CustomButtomWidget(
                                buttonChild: Text(
                                  "Realizar Cadastro",
                                  style: boldFont(
                                    MColors.primaryWhite,
                                    16.0,
                                  ),
                                ),
                                onPressed: () => controller.signUp(context),
                                color: MColors.blue,
                              ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showAlert(LoginController loginController) {
    if (loginController.error != null) {
      return Container(
        height: 60,
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: MColors.primaryWhiteSmoke,
          border: Border.all(width: 1.0, color: Colors.redAccent),
          borderRadius: const BorderRadius.all(
            Radius.circular(4.0),
          ),
        ),
        child: Row(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Icon(
                Icons.error_outline,
                color: Colors.redAccent,
              ),
            ),
            Expanded(
              child: Text(
                loginController.error!,
                style: normalFont(Colors.redAccent, 15.0),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 0.0,
      );
    }
  }
}
