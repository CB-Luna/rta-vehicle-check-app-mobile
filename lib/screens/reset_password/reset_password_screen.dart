import 'package:bizpro_app/screens/screens.dart';
import 'package:bizpro_app/screens/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:bizpro_app/theme/theme.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController emailAddressController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final String forgotPassword = """
    mutation(\$email: String!) {
      forgotPassword(email: \$email) {
        ok
      }
    }
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B75F5),
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
        title: Text(
          'Recuperar Contraseña',
          style: AppTheme.of(context).bodyText1.override(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 18,
              ),
        ),
        actions: const [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: const Color(0xFFEBEFF3),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie_animations/forgot_password.json',
                  width: 200,
                  height: 150,
                  fit: BoxFit.cover,
                  animate: true,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                  child: Text(
                    'Problemas para entrar?',
                    style: AppTheme.of(context).title1.override(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                    child: Text(
                      'Ingresa tu dirección de correo\nelectrónico. Te enviaremos un enlace\npara reestablecer tu contraseña.',
                      textAlign: TextAlign.center,
                      style: AppTheme.of(context).bodyText2.override(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: AppTheme.of(context).secondaryBackground,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 5,
                    color: Color(0x4D101213),
                    offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                controller: emailAddressController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  labelStyle: AppTheme.of(context).bodyText2,
                  hintText: 'Ingresa tu correo electrónico...',
                  hintStyle: AppTheme.of(context).bodyText1.override(
                        fontFamily: 'Lexend Deca',
                        color: const Color(0xFF57636C),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0x00000000),
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: AppTheme.of(context).secondaryBackground,
                  contentPadding:
                      const EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                ),
                style: AppTheme.of(context).bodyText1,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
            child: Mutation(
                options: MutationOptions(
                  document: gql(forgotPassword),
                  onCompleted: (_) async {
                    print('Completado. Correo: ${emailAddressController.text}');
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PasswordEmailSentScreen(),
                      ),
                    );
                  },
                  onError: (OperationException? exception) {
                    if (exception == null) return;
                    if (exception.graphqlErrors.isEmpty) return;
                    final message = exception.graphqlErrors[0].message;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: $message'),
                      ),
                    );
                  },
                ),
                builder: (RunMutation runMutation, QueryResult? result) {
                  return CustomButton(
                    onPressed: () async {
                      if (emailAddressController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Email required!',
                            ),
                          ),
                        );
                        return;
                      }

                      runMutation({
                        'email': emailAddressController.text,
                      });
                    },
                    text: 'Enviar enlace de acceso',
                    options: ButtonOptions(
                      width: 270,
                      height: 50,
                      color: const Color(0xFF2CC3F4),
                      textStyle: AppTheme.of(context).subtitle2.override(
                            fontFamily: 'Poppins',
                            color: AppTheme.of(context).secondaryBackground,
                          ),
                      elevation: 3,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}