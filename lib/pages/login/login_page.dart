import 'package:provider/provider.dart';
import 'package:estoque_frontend/pages/login/components/background_login.dart';
import 'package:estoque_frontend/pages/login/components/button_login.dart';
import 'package:estoque_frontend/pages/login/components/container_login.dart';
import 'package:estoque_frontend/pages/login/components/textfield_login.dart';
import 'package:estoque_frontend/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _visibilityPassword = false;
  bool _loading = false;
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerUser     = TextEditingController();


  void _changeVisibilityPassword() => setState(() => _visibilityPassword = !_visibilityPassword);
  void _changeLoadingStatus() => setState(() => _loading = !_loading);

  Future<void> _onButtonLoginPressed() async {
    if(_formKey.currentState!.validate()){
      try {
      await context
          .read<AuthService>()
          .login(email: _controllerUser.text, senha: _controllerPassword.text);
    } catch (e) {
     
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }

    }

  }


  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          const ComponentBackgroundImageLogin(),
          Center(
            child: ContainerLogin(
              width: _width,
              height: _height,
              childContent: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Login", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),),
                  Form(
                    key: _formKey,
                    child: Column(
                    children: [
                      ComponentTextfieldLogin( 
                        controller: _controllerUser,
                        validator: (value) {
                          if (value!.isEmpty)                           return "*Campo Obrigatório";
                          else                                          return null;
                          },
                        hint: "Usuário",),
                      
                      ComponentTextfieldLogin( 
                        controller: _controllerPassword,
                        obscure: !_visibilityPassword,
                        hint: "Senha",
                        validator: (value) {
                          if (value!.isEmpty)                           return "*Campo Obrigatório";
                          else                                          return null;
                          },
                        suffixIcon: IconButton(
                          icon: Icon(
                            _visibilityPassword 
                            ? Icons.visibility
                            : Icons.visibility_off, 
                            size: 20,),
                          onPressed: () => _changeVisibilityPassword(),
                        ),
                       )


                    ],
                  )),
                  ComponentButtonLogin(
                    loading: _loading,
                    changeLoadingStatus: () =>  _changeLoadingStatus(),
                    onPressed: () async => await _onButtonLoginPressed(), 
                    width: _width *0.18, 
                    text: "Entrar",),

                ],
              ),
            )
          )
        ],
      )
    );
  }
}