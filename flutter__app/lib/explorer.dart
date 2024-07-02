import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter__app/userProfilePage.dart'; // Importe a página do perfil

class Explorer extends StatefulWidget {
  @override
  _ExplorerState createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer> {
  TextEditingController _nameFilterController = TextEditingController();
  TextEditingController _ufFilterController = TextEditingController();
  TextEditingController _cityFilterController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> filteredPhotographers = [];

  @override
  void initState() {
    super.initState();
    applyFilters(); // Inicialmente, mostra todos os fotógrafos
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
                // Nome
                Flexible(
                  child: TextFormField(
                    controller: _nameFilterController,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // UF
                Flexible(
                  child: TextFormField(
                    controller: _ufFilterController,
                    decoration: InputDecoration(
                      labelText: 'UF',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // Cidade
                Flexible(
                  child: TextFormField(
                    controller: _cityFilterController,
                    decoration: InputDecoration(
                      labelText: 'Cidade',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // Botão de Filtrar
                SizedBox(
                  height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                          foregroundColor: Color(0xFFFCFDF9),
                          backgroundColor: Color(0xFF435364),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                  ),
                  onPressed: () {
                    applyFilters();
                  },
                  child: Text('Filtrar',
                  style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold
                          ),
                  ),
                ),
                ),
              ],
            ),
          ),
          // Lista de Fotógrafos
          Expanded(
            child: ListView.builder(
              itemCount: filteredPhotographers.length,
              itemBuilder: (context, index) {
                var photographerData = filteredPhotographers[index].data() as Map<String, dynamic>;
                return GestureDetector(
                  onTap: () {
                    navigateToProfilePage(photographerData); // Navegar para o perfil ao clicar
                  },
                  child: ListTile(
                    title: Text(photographerData['name']),
                    subtitle: Text('${photographerData['city']}, ${photographerData['UF']}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Método para aplicar filtros com base nos critérios selecionados
  void applyFilters() async {
    Query query = _firestore.collection('users');

    if (_nameFilterController.text.isNotEmpty) {
      String searchTerm = _nameFilterController.text.toLowerCase();
      query = query.where('name', isGreaterThanOrEqualTo: searchTerm)
                   .where('name', isLessThan: searchTerm + 'z');
    }
    if (_ufFilterController.text.isNotEmpty) {
      query = query.where('UF', isEqualTo: _ufFilterController.text);
    }
    if (_cityFilterController.text.isNotEmpty) {
      query = query.where('city', isEqualTo: _cityFilterController.text);
    }

    try {
      var querySnapshot = await query.get();
      setState(() {
        filteredPhotographers = querySnapshot.docs;
      });
    } catch (e) {
      print('Erro ao executar a consulta: $e');
    }
  }

  // Método para navegar para a página de perfil do fotógrafo
  void navigateToProfilePage(Map<String, dynamic> photographerData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfilePage(
          userId: photographerData['uid'], // Passando userId para UserProfilePage
          userName: photographerData['name'],
          userPhotoUrl: photographerData['photoURL'],
          whatsappNumber: photographerData['phone'],
          city: photographerData['city'],
          uf: photographerData['UF'],
          nick: photographerData['user']
        ),
      ),
    );
  }
}
