import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ) //MaterialApp
      );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController precoEtanolController = new TextEditingController();
  TextEditingController precoGasolinaController = new TextEditingController();
  TextEditingController carroConsumoGasolina = new TextEditingController();
  TextEditingController carroConsumoEtanol = new TextEditingController();
  TextEditingController valorAbastecer = new TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _info = "Informe os preços dos combustiveis";
  String _medioValorGasolina = "";
  String _medioValorEtanol =""; 
  void _resetFields() {
    precoEtanolController.text = "";
    precoGasolinaController.text = "";
    carroConsumoGasolina.text = "";
    carroConsumoEtanol.text = "";
    setState(() {
      _info = _info;
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculoCombustivelMedio() {
    setState(() {
      double combustivelMedioGasolina = double.parse(carroConsumoGasolina.text);
      double combustivelMedioEtanol = double.parse(carroConsumoEtanol.text);
      double precoEtanol = double.parse(precoEtanolController.text);
      double precoGasolina = double.parse(precoGasolinaController.text);
      double abastecer = double.parse(valorAbastecer.text);
      //quero andar 700km pra cada 14 km 
      double valorMedioGasolina =  abastecer / combustivelMedioGasolina ;
      double valorMedioEtanol =  abastecer / combustivelMedioEtanol ;
      double precoMedioGasolina = valorMedioGasolina * precoGasolina;
      double precoMedioEtanol = valorMedioEtanol * precoEtanol;
      _medioValorGasolina =  "O valor gasto com Gasolina é " + precoMedioGasolina.toStringAsFixed(2) + " BRL";
      _medioValorEtanol =  "O valor gasto com Etanol é " + precoMedioEtanol.toStringAsFixed(2) + " BRL";
    });
  }

  void _calculaMelhorCombustivel() {
    setState(() {
      double precoEtanol = double.parse(precoEtanolController.text);
      double precoGasolina = double.parse(precoGasolinaController.text);

      double coeficiente = precoEtanol / precoGasolina;
      _info = (coeficiente <= 0.7)
          ? "Melhor abastecer com etanol"
          : "Melhor abastecer com Gasolina";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Qual Combustível?"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
          ],
          backgroundColor: Colors.blueGrey,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.local_gas_station, size: 100.0, color: Colors.blueGrey),
                TextFormField(
                  controller: precoGasolinaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Gasolina R\$",
                      labelStyle: TextStyle(color: Colors.blueGrey)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20.0),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe o preço da Gasolina!';
                    } else if (value.length == 0 ||
                        double.parse(value) == 0.0) {
                      return ('Informe um valor superior a zero para Gasolina');
                    }
                  },
                ),
                TextFormField(
                  controller: precoEtanolController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Etanol R\$",
                      labelStyle: TextStyle(color: Colors.blueGrey)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20.0),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe o preço do Etanol';
                    } else if (value.length == 0 ||
                        double.parse(value) == 0.0) {
                      return ('Informe um valor superior a zero para o Etanol');
                    }
                  },
                ),
                TextFormField(
                  controller: carroConsumoGasolina,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Consumo médio do seu veiculo em KM/L em Gasolina",
                      labelStyle: TextStyle(color: Colors.blueGrey)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20.0),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe o consumo médio';
                    } else if (value.length == 0 ||
                        double.parse(value) == 0.0) {
                      return ('Informe um valor superior a zero');
                    }
                  },
                ),
                TextFormField(
                  controller: carroConsumoEtanol,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Consumo médio do seu veiculo em KM/L em Etanol",
                      labelStyle: TextStyle(color: Colors.blueGrey)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20.0),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe o consumo médio';
                    } else if (value.length == 0 ||
                        double.parse(value) == 0.0) {
                      return ('Informe um valor superior a zero');
                    }
                  },
                ),
                TextFormField(
                  controller: valorAbastecer,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Quanto quer rodar em KM/L?",
                      labelStyle: TextStyle(color: Colors.blueGrey)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20.0),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe o quanto quer abastecer';
                    } else if (value.length == 0 ||
                        double.parse(value) == 0.0) {
                      return ('Informe um valor superior a zero');
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                      height: 50.0,
                      child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _calculaMelhorCombustivel();
                              _calculoCombustivelMedio();
                            }
                          },
                          child: Text("Calcular",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0)),
                          color: Colors.blueGrey)),
                ),
                Card(
                    child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  child: Container(
                    height: 50.0,
                    child: Text(
                      _info,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blueGrey, fontSize: 20.0),
                    ),
                  ),
                )),
                Card(
                    child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  child: Container(
                    height: 50.0,
                    child: Text(
                      _medioValorGasolina,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blueGrey, fontSize: 20.0),
                    ),
                  ),
                )),
                Card(
                    child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  child: Container(
                    height: 50.0,
                    child: Text(
                      _medioValorEtanol,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blueGrey, fontSize: 20.0),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ));
  }
}
