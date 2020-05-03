import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/behaviors/hiddenScrollBehavior.dart';

class ForgotPWD extends StatefulWidget {
  @override
  _ForgotPWDState createState() => _ForgotPWDState();
}

class _ForgotPWDState extends State<ForgotPWD> {

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _email;
  bool _isSendingForgotPWD = false;

  _forgotPWD() async{
    if(_isSendingForgotPWD) return;
    setState(() {
      _isSendingForgotPWD = true;
    });
       final form = _formKey.currentState;

    if(!form.validate()){
      _scaffoldKey.currentState.hideCurrentSnackBar();
      setState(() {
        _isSendingForgotPWD = false;
      });
      return;
    }
    form.save();

        try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Reciba tu inbox"),
        duration: Duration(seconds: 10),
      ));
    }catch(e){
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(e.message),
        duration: Duration(seconds: 10),
        action: SnackBarAction(label: "Dismiss", onPressed: (){
          _scaffoldKey.currentState.hideCurrentSnackBar();
        }),
      ));
    }finally{
      _isLoggingin = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Olvide"),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: ScrollConfiguration(
            behavior: HiddenScrollBehavior(),
            child: ListView(
              children: <Widget>[
                FlutterLogo(style: FlutterLogoStyle.markOnly, size: 100.0,),
                Padding(padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text("Ingrese su correo para recuperar la contrasenia"),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
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
                )
              ],
            ),),
          
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            _forgotPWD();
          },
          child: Icon(Icons.restore),),
        );
  }
}
