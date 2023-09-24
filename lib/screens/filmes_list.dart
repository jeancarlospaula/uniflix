// Importando as bibliotecas necessárias
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uniflix/http/filme_api.dart'; // Importando a classe FilmeApi do seu código.
import '../model/filme.dart'; // Importando a classe Filme do seu modelo.

// Definindo o widget FilmesList que é um Stateful widget.
class FilmesList extends StatefulWidget {
  const FilmesList({Key? key}) : super(key: key);

  @override
  State<FilmesList> createState() => _FilmesListState();
}

// Definindo o estado do widget FilmesList.
class _FilmesListState extends State<FilmesList> {
  List<Filme> filmesList = [];

  // Método para obter os filmes a partir da API.
  getFilmes() async {
    FilmeApi api = FilmeApi();
    //final filmes = await api.getFilmesOffline();
    final filmes = await api.getFilmes2();
    for (var filme in filmes) {
      print(filme);
    }
    setState(() {
      filmesList = filmes;
    });
  }

  @override
  Widget build(BuildContext context) {
    getFilmes(); // Chamando o método getFilmes() para buscar os filmes.
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 229, 9, 20),
          title: const Text(
            'Uniflix',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          color: Colors.black, // Definindo a cor de fundo preto.
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: filmesList.length, // Número de itens na grade.
            itemBuilder: (context, index) {
              Filme filme =
                  filmesList[index]; // Pegando o filme atual da lista.
              return Card(
                child: Column(
                  children: [
                    Image.network(
                      filme.capa,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Text(filme.titulo.toString(),
                        style: TextStyle(
                            fontSize: 18)), // Mostrando o título do filme.
                    ListTile(
                      leading:
                          Text(filme.id.toString()), // Mostrando o ID do filme.
                      subtitle:
                          Text(filme.resumo), // Mostrando o resumo do filme.
                      trailing: Text(filme.duracao
                          .toString()), // Mostrando a duração do filme.
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
