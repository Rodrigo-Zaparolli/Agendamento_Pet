import 'package:agendamento_pet/controller/login_controller.dart';
import 'package:agendamento_pet/core/utils/all_widgets.dart';
import 'package:agendamento_pet/core/utils/colors.dart';
import 'package:agendamento_pet/core/utils/widget_stateful.dart';
import 'package:agendamento_pet/presentation/widgets/custom_app_bar_widget.dart';
import 'package:agendamento_pet/presentation/widgets/custom_buttom_widget.dart';
import 'package:agendamento_pet/presentation/widgets/custom_container_widget.dart';
import 'package:agendamento_pet/presentation/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState
    extends WidgetStateful<ResetPasswordPage, LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.primaryWhiteSmoke,
      appBar: const CustomAppBarWidget(
        backgroundColor: MColors.primaryWhiteSmoke,
        centerTile: false,
      ),
      body: SingleChildScrollView(
        child: CustomContainerWidget(
          color: MColors.primaryWhite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 30.0),
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  "Esqueceu sua senha?",
                  style: boldFont(MColors.textDark, 38.0),
                  textAlign: TextAlign.start,
                ),
              ),

              const SizedBox(height: 10.0),
              Observer(
                builder: (_) => showAlert(controller),
              ),

              const SizedBox(height: 10.0),

              //FORM
              Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "Digite o endereço de e-mail associado à sua conta.",
                        style: normalFont(MColors.textGrey, 16.0),
                        textAlign: TextAlign.start,
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
                      inputFormatters: [],
                      suffix: null,
                      textfieldBorder: 0.50,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      "Enviaremos um link para redefinir sua senha para esse e-mail.",
                      style: normalFont(MColors.blue, null),
                    ),
                    const SizedBox(height: 20.0),
                    controller.isButtonDisabled == true
                        ? CustomButtomWidget(
                            buttonChild: const CircularProgressIndicator(),
                            onPressed: () {},
                            color: Colors.white)
                        : CustomButtomWidget(
                            buttonChild: Text(
                              "Redefinir senha",
                              style: boldFont(
                                MColors.primaryWhite,
                                16.0,
                              ),
                            ),
                            onPressed: () => controller.isButtonDisabled
                                ? null
                                : controller.redefinir(),
                            color: MColors.blue,
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
