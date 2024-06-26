import 'package:flutter/material.dart';

class Explorer extends StatefulWidget {
  @override
  _ExplorerState createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer> {
  // Controllers para os filtros
  TextEditingController _ufFilterController = TextEditingController();
  TextEditingController _cityFilterController = TextEditingController();
  TextEditingController _categoryFilterController = TextEditingController();

  // Lista de fotógrafos (substitua pela sua própria estrutura de dados)
  List<Photographer> photographers = [
    Photographer('João', 'joao@example.com', 'SP', 'São Paulo', 'Retrato'),
    Photographer('Maria', 'maria@example.com', 'RJ', 'Rio de Janeiro', 'Casamento'),
    Photographer('Pedro', 'pedro@example.com', 'MG', 'Belo Horizonte', 'Eventos'),
  ];

  List<Photographer> filteredPhotographers = []; // Lista filtrada inicialmente todos os fotógrafos

  @override
  void initState() {
    super.initState();
    filteredPhotographers = photographers; // Inicialmente, mostra todos os fotógrafos
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Explorer',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Image.asset(
            'assets/images/logoVJ.png',
            height: 30,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filtros
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.grey.shade200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // UF
                SizedBox(
                  width: 120,
                  child: TextFormField(
                    controller: _ufFilterController,
                    decoration: InputDecoration(
                      labelText: 'UF',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                // Cidade
                SizedBox(
                  width: 120,
                  child: TextFormField(
                    controller: _cityFilterController,
                    decoration: InputDecoration(
                      labelText: 'Cidade',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                // Categoria
                SizedBox(
                  width: 120,
                  child: TextFormField(
                    controller: _categoryFilterController,
                    decoration: InputDecoration(
                      labelText: 'Categoria',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                // Botão de Filtrar
                ElevatedButton(
                  onPressed: () {
                    applyFilters();
                  },
                  child: Text('Filtrar'),
                ),
              ],
            ),
          ),
          // Lista de Fotógrafos
          Expanded(
            child: ListView.builder(
              itemCount: filteredPhotographers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredPhotographers[index].name),
                  subtitle: Text(filteredPhotographers[index].city + ', ' + filteredPhotographers[index].uf),
                  // Mais detalhes conforme necessário
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Método para aplicar filtros com base nos critérios selecionados
  void applyFilters() {
    setState(() {
      filteredPhotographers = photographers.where((photographer) {
        final ufMatches = _ufFilterController.text.isEmpty || photographer.uf.toLowerCase().contains(_ufFilterController.text.toLowerCase());
        final cityMatches = _cityFilterController.text.isEmpty || photographer.city.toLowerCase().contains(_cityFilterController.text.toLowerCase());
        final categoryMatches = _categoryFilterController.text.isEmpty || photographer.category.toLowerCase().contains(_categoryFilterController.text.toLowerCase());
        return ufMatches && cityMatches && categoryMatches;
      }).toList();
    });
  }
}

// Modelo de fotógrafo (substitua pelo seu próprio modelo)
class Photographer {
  final String name;
  final String email;
  final String uf;
  final String city;
  final String category;

  Photographer(this.name, this.email, this.uf, this.city, this.category);
}
