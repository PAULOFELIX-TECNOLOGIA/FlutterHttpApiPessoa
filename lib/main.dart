//https://www.google.com/search?q=consulta+flutter+http+php&sca_esv=f602dc89620483ed&ei=qLUSZ5qaCufI1sQPxK3U8AY&ved=0ahUKEwiajvXi05iJAxVnpJUCHcQWFW4Q4dUDCA8&uact=5&oq=consulta+flutter+http+php&gs_lp=Egxnd3Mtd2l6LXNlcnAiGWNvbnN1bHRhIGZsdXR0ZXIgaHR0cCBwaHAyCBAAGIAEGKIESM9DULMHWKw4cAJ4AJABAJgBjAGgAbYKqgEEMC4xMbgBA8gBAPgBAZgCDKAC9AnCAgoQABiwAxjWBBhHmAMAiAYBkAYIkgcEMi4xMKAH8Ro&sclient=gws-wiz-serp#fpstate=ive&vld=cid:695b9964,vid:F_E2jh7FwBQ,st:0
//https://github.com/MahdiSharifiFar/flutter_crud_php/blob/main/lib/home_page.dart
//https://www.youtube.com/watch?v=A7sCaN4wnQ4&list=PLKbhw6n2iYKhv-8tBAw6FTsTMuM1OgjC7&index=4

/*Observação
C:\flutter\packages\flutter_tools\lib\src\web 
alterar o arquivo chome.dart 
desativando //'--disable-extensions',
e adicionando '--disable-web-security', */

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
              height: 110,
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Column(
                  children: [
                    const TextField(
                      decoration: InputDecoration(hintText: 'CPF'),
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
                                  onPressed: () {},
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

/*class User {
  String cpf_pessoa,
  nome_pessoa,
  profissao_pessoa,
  email_contato,
  telefone_contato;

  User(
      {required this.cpf_pessoa,
      required this.nome_pessoa,
      required this.profissao_pessoa,
      required email_contato,
      required this.telefone_contato});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      cpf_pessoa: (json['cpf_pessoa']),
      nome_pessoa: (json['nome_pessoa']),
      profissao_pessoa: (json['profissao_pessoa']),
      telefone_contato: (json['telefone_pessoa']),
      email_contato: (json['email_pessoa']),
    );
  }
}*/
extension on Map {
  String convertToJson() => jsonEncode(this);
}
