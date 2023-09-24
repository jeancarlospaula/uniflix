import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uniflix/model/filme.dart';

class FilmeApi {
  String respostaApi = '''
  [
    {
      "id": 1,
      "titulo": "Homem de Ferro 2",
      "resumo": "Filme do Homem de Ferro",
      "atores": "Robert Downey",
      "capa": "https://upload.wikimedia.org/wikipedia/pt/0/00/Iron_Man_poster.jpg",
      "duracao": 140
    },
    {
      "id": 2,
      "titulo": "Homem-Aranha: De Volta ao Lar",
      "resumo": "Filme do Homem-Aranha",
      "atores": "Tom Holland",
      "capa": "https://upload.wikimedia.org/wikipedia/en/f/f9/Spider-Man_Homecoming_poster.jpg",
      "duracao": 133
    },
    {
      "id": 3,
      "titulo": "Mulher-Maravilha",
      "resumo": "Filme da Mulher-Maravilha",
      "atores": "Gal Gadot",
      "capa": "https://upload.wikimedia.org/wikipedia/pt/9/9f/Mulher_Maravilha_2009.jpg",
      "duracao": 141
    },
    {
      "id": 4,
      "titulo": "Pantera Negra",
      "resumo": "Filme do Pantera Negra",
      "atores": "Chadwick Boseman",
      "capa": "https://img.elo7.com.br/product/original/37EBEF7/painel-1x65cm-pantera-negra-wakanda-festa-expressa.jpg",
      "duracao": 134
    },
    {
      "id": 5,
      "titulo": "Capitã Marvel",
      "resumo": "Filme da Capitã Marvel",
      "atores": "Brie Larson",
      "capa": "https://upload.wikimedia.org/wikipedia/pt/5/59/Captain_Marvel_%282018%29.jpg",
      "duracao": 123
    },
    {
      "id": 6,
      "titulo": "Homem-Aranha: Longe de Casa",
      "resumo": "Filme do Homem-Aranha",
      "atores": "Tom Holland",
      "capa": "https://www.global-esports.news/wp-content/uploads/2022/06/Spider-Man-Remastered.png",
      "duracao": 129
    }
  ]
''';

  String apiUrl =
      'https://my-json-server.typicode.com/jeancarlospaula/fake_api/db';

  Future<List<Filme>> getFilmesOffline() async {
    final json = jsonDecode(respostaApi);

    final mapsFilme = json.cast<Map<String, dynamic>>();

    List<Filme> listFilmes = [];

    for (var map in mapsFilme) {
      Filme filme = Filme.fromJson(map);
      listFilmes.add(filme);
    }

    await Future.delayed(const Duration(seconds: 1));

    return listFilmes;
  }

  Future<List<Filme>> getFilmes() async {
    final response = await http.get(Uri.parse(apiUrl));
    print(response.body);
    if (response.statusCode != 200) {
      throw Exception('Erro ao obter dados da API');
    }

    final json = jsonDecode(response.body);
    final mapsFilme = json.cast<Map<String, dynamic>>();

    List<Filme> listFilmes = [];

    for (var filme in mapsFilme) {
      Filme filmeObj = Filme.fromJson(filme);
      listFilmes.add(filmeObj);
    }

    return listFilmes;
  }

  // Método para obter a lista de personagens da API online
  Future<List<Filme>> getFilmes2() async {
    // Faz uma requisição HTTP GET à API
    final response = await http.get(Uri.parse(apiUrl));

    // Verifica se a requisição foi bem-sucedida (código de status 200)
    if (response.statusCode == 200) {
      // Decodifica o JSON da resposta e extrai a lista de personagens
      final json = jsonDecode(response.body);
      final mapsPersonagens = json.cast<Map<String, dynamic>>();

      // Lista para armazenar os objetos Personagem
      List<Filme> listFilme = [];

      // Converte cada mapa de personagem em um objeto Personagem
      for (var map in mapsPersonagens) {
        // Cria um objeto Personagem usando o método fromJson
        Filme filme = Filme.fromJson(map);

        // Atualiza o URL do avatar com parâmetros de autenticação

        // Adiciona o personagem à lista
        listFilme.add(filme);
      }

      // Retorna a lista de personagens obtida da API
      return listFilme;
    } else {
      // Caso a requisição não seja bem-sucedida, lança uma exceção
      throw Exception('Falha ao obter informações da API');
    }
  }
}
