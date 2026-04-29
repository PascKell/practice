import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchPokemon() async {
  final response = await http.get(
    Uri.parse('https://pakeller.de/getPokedex.php'),
  );

  if (response.statusCode == 200) {
    print("Daten wurden erfolgreich geladen");
    print(response.body.toString());
    return json.decode(response.body);
  } else {
    throw Exception('Fehler beim Laden');
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pokédex')),
      body: FutureBuilder<List<dynamic>>(
        future: fetchPokemon(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Fehler: ${snapshot.error}'));
          }

          final data = snapshot.data!;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final pokemon = data[index];

              return ListTile(
                title: Text(pokemon['name']),
                subtitle: Text("#${pokemon['nummer']}"),
                onTap: () {
                  print(pokemon['url']);
                },
              );
            },
          );
        },
      ),
    );
  }
}