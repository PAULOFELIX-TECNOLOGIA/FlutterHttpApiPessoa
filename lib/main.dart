/*Observação
C:\flutter\packages\flutter_tools\lib\src\web 
alterar o arquivo chome.dart 
desativando //'--disable-extensions',
e adicionando '--+, */

/*
https://www.youtube.com/watch?v=3mlgF5TaSD8
*/
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cpf_controller = TextEditingController();
  final nome_controller = TextEditingController();
  final profissao_controller = TextEditingController();
  final List<User> _usersList = [];
  String serverMsg = '';

  void fetchUsuarios() async {
    try {
      http.Response response = await http.get(
        Uri.parse(
          'http://localhost/apipessoa/controle.php?getPessoa',
        ),
      );
      if (response.statusCode == 200) {
        _usersList.clear();
        for (final jsonItem in jsonDecode(response.body)) {
          _usersList.add(User.fromJson(jsonItem));
        }
        setState(() {});
      }
      setState(() {});
    } catch (error) {
      serverMsg = error.toString();
      setState(() {});
    }
  }

  void postUsuarios() async {
    try {
      final response = await http.post(
          Uri.parse(
            'http://localhost/apipessoa/controle.php?cadPessoa',
          ),
          body: {
            'cpf': cpf_controller.text,
            'nome': nome_controller.text,
            'profissao': profissao_controller.text
          }.convertToJson());

      cpf_controller.text = '';
      nome_controller.text = '';
      profissao_controller.text = '';

      if (response.statusCode == 200) {
        serverMsg = "Cadastrado com sucesso";
        postUsuarios();
      } else
        serverMsg = "Erro ao cadastrar";
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(hintText: 'Cpf'),
                      controller: cpf_controller,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    TextField(
                      decoration: const InputDecoration(hintText: 'Nome'),
                      controller: nome_controller,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    TextField(
                      decoration: const InputDecoration(hintText: 'Profissão'),
                      controller: profissao_controller,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _usersList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.grey.shade100,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _usersList[index].cpf_pessoa,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                            Text(
                              _usersList[index].nome_pessoa,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                            Text(
                              _usersList[index].profissao_pessoa,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  highlightColor: Colors.green.withOpacity(0.4),
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit,
                                      color: Colors.green),
                                ),
                                IconButton(
                                  highlightColor: Colors.red.withOpacity(0.4),
                                  onPressed: () {
                                    postUsuarios();
                                  },
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    })),
            const SizedBox(
              height: 30,
            ),
            Text(
              serverMsg,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class User {
  String cpf_pessoa, nome_pessoa, profissao_pessoa;

  User({
    required this.cpf_pessoa,
    required this.nome_pessoa,
    required this.profissao_pessoa,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      cpf_pessoa: (json['cpf_pessoa']),
      nome_pessoa: (json['nome_pessoa']),
      profissao_pessoa: (json['profissao_pessoa']),
    );
  }
}

extension on Map {
  String convertToJson() => jsonEncode(this);
}
