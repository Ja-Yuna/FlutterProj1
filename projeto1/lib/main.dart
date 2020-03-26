import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightControler = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = "Informe seus dados";

  void resetFields() {
    weightControler.text = "";
    heightController.text = "";
  }

  void _calculate() {
    setState(() {
      {
        double weight = double.parse(weightControler.text);
        double height = double.parse(heightController.text) / 100;
        double imc = weight / (height * height);
        print(imc);
        if (imc < 18.6) {
          _infoText = "Abaixo do peso(${imc.toStringAsPrecision(3)})";
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora IMC"),
          centerTitle: true,
          backgroundColor: Colors.pink,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Icon(Icons.person_outline, size: 120.0, color: Colors.blue),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Peso kg",
                          labelStyle: TextStyle(color: Colors.lightBlue)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.yellow, fontSize: 25.0),
                      controller: weightControler,
                      validator: (value){
                        if(value.isEmpty){
                          return "Insira seu peso";
                        }
                      }

                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Altura(cm)",
                          labelStyle: TextStyle(color: Colors.lightBlue)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.yellow, fontSize: 25.0),
                      controller: heightController,
                        validator: (value){
                          if(value.isEmpty){
                            return "Insira sua altura";
                          }
                        }
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Container(
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _calculate();
                            }
                          },
                          child: Text(
                            "Calcular",
                            style: TextStyle(color: Colors.white, fontSize: 25.0),
                          ),
                          color: Colors.pink,
                        ),
                      ),
                    ),
                    Text(
                      _infoText,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.pink, fontSize: 25.0),
                    ),
                  ]
              ),
            )
        )
    );
  }
}
