import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../models/usuario_model.dart';

class ListaUsuarios extends StatefulWidget {
  const ListaUsuarios({super.key});

  @override
  State<ListaUsuarios> createState() {
    return ListaUsuariosState();
  }
}

class ListaUsuariosState extends State<ListaUsuarios> {
  TextEditingController nomeControl = TextEditingController();
  TextEditingController telefoneControl = TextEditingController();
  TextEditingController emailControl = TextEditingController();
  TextEditingController dataNascimentoControl = TextEditingController();

  List<Usuario> listaUsuarios = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Usuários")),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextFormField(
              controller: nomeControl,
              decoration: const InputDecoration(
                labelText: "Nome",
                icon: Icon(Icons.person),
              ),
            ),
            TextFormField(
              controller: telefoneControl,
              decoration: const InputDecoration(
                labelText: "Telefone",
                icon: Icon(Icons.phone),
              ),
            ),
            TextFormField(
              controller: emailControl,
              decoration: const InputDecoration(
                labelText: "E-mail",
                icon: Icon(Icons.email),
              ),
            ),
            TextFormField(
              controller: dataNascimentoControl,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Data de Nascimento",
                icon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2022),
                  lastDate: DateTime(2030),
                );
                if (pickedDate != null) {
                  String dataFormatada =
                      DateFormat('dd/MM/yyyy').format(pickedDate);
                  setState(() {
                    dataNascimentoControl.text = dataFormatada;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int randomId =
                    Random().nextInt(71); // Gere um ID aleatório de 0 a 70
                Usuario newUser = Usuario(
                  nome: nomeControl.text,
                  telefone: telefoneControl.text,
                  email: emailControl.text,
                  dataNascimento: dataNascimentoControl.text,
                  fotoUrl: 'https://i.pravatar.cc/300?img=$randomId',
                );
                setState(() {
                  listaUsuarios.add(newUser);
                  // Limpe os campos após a adição do usuário
                  nomeControl.clear();
                  telefoneControl.clear();
                  emailControl.clear();
                  dataNascimentoControl.clear();
                });
              },
              child: const Text("Adicionar Usuário"),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: listaUsuarios.length,
                itemBuilder: (context, index) {
                  Usuario user = listaUsuarios[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.fotoUrl),
                    ),
                    title: Text(user.nome),
                    subtitle: Text(user.email),
                    trailing: Text(
                      user.dataNascimento,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Usuários")),
      body: ListView.builder(
        itemCount: _lista.length, // Tamanho da lista
        // context: contexto da aplicação (tela atual)
        // index: índice de cada item, iterado de 0 até n-1 (n = tamanho da lista)
        itemBuilder: (context, index) {
          return ListTile(
            leading: ClipOval(
              child: Image.network(_lista[index].urlFoto),
            ),
            title: Text(_lista[index].nome),
            subtitle: Text(_lista[index].email)
          );
        }
      )
    );
  }

}*/