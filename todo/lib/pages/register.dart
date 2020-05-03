import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/behaviors/hiddenScrollBehavior.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _email;
  String _password;

  bool _isRegistering = false;
  _register()async{
    if(_isRegistering) return;
    setState(() {
      _isRegistering = true;
    });

    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Registrando usuario")));

    final form = _formKey.currentState;

    if(!form.validate()){
      _scaffoldKey.currentState.hideCurrentSnackBar();
      setState(() {
        _isRegistering = false;
      });
      return;
    }
    form.save();
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
      Navigator.of(context).pushReplacementNamed('/maintabs');
    }catch(e){
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(e.message),
        duration: Duration(seconds: 10),
        action: SnackBarAction(label: "Dismiss", onPressed: (){
          _scaffoldKey.currentState.hideCurrentSnackBar();
        }),
      ));
    }finally{
      _isRegistering = false;
    }
    

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Registro'),
        ),
        body: Container(
            padding: EdgeInsets.all(10.0),
            child: ScrollConfiguration(
                behavior: HiddenScrollBehavior(),
                child: Form(
                  key: _formKey,                
                child: ListView(children: <Widget>[
                  FlutterLogo(
                    style: FlutterLogoStyle.markOnly,
                    size: 200.0,
                  ),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: "Email"),
                    validator: (val){
                      if(val.isEmpty){
                        return 'Ingres el correo';
                      }else{
                        return null;
                      }
                    },
                    onSaved: (val){
                      setState(() {
                        _email = val;
                      });
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(labelText: "Contraseña"),
                    validator: (val){
                      if(val.isEmpty){
                        return 'Ingresa el password';
                      }else{
                        return null;
                      }
                    },
                    onSaved: (val){
                      setState(() {
                        _password = val;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Bienvenido',
                      style:
                          TextStyle(color: Color.fromARGB(255, 200, 200, 200)),
                    ),
                  )
                ],
                ),
                )
                ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: (){
                    _register();
                  },
                  child: Icon(Icons.person_add),
                ),
                persistentFooterButtons: <Widget>[
                  FlatButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed('/login');
                      },
                    child: Text("Tengo una cuenta p bandido"))
                ],
                );
  }
}
