import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Visual Journey',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;
  PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPageIndex < 2) {
        _currentPageIndex++;
      } else {
        _currentPageIndex = 0;
      }
      _pageController.animateToPage(
        _currentPageIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(35.0),
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/logoVJ.png',
                    height: 50,
                  ),
                  IconButton(
                    icon: Icon(Icons.menu),
                    tooltip: localizations.openAppDrawerTooltip,
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                ],
              ),
            ),
            // Carrossel de imagens
            Container(
              height: 200,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                children: [
                  Image.asset(
                    'assets/images/banerAnimado1.gif',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assets/images/banerAnimado2.gif',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assets/images/banerAnimado3.gif',
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            // Carrossel de fotógrafos
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Encontre um Fotógrafo',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('caminho/para/imagem1.jpg'),
                      ),
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('caminho/para/imagem2.jpg'),
                      ),
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('caminho/para/imagem3.jpg'),
                      ),
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('caminho/para/imagem4.jpg'),
                      ),
                      // Adicionar mais CircleAvatars conforme necessário
                    ],
                  ),

                  // Adicionar seu carrossel de fotógrafos aqui
                ],
              ),
            ),
            // Carrossel de fotos
            Container(
              color: Color(0x55555534),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Fotos de Fotógrafos',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 220),

                  // Adicionar seu carrossel de fotos aqui
                ],
              ),
            ),
            // Footer
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.grey[300],
              child: Column(
                children: [
                  Text(
                    '© 2024 Seu Site. Todos os direitos reservados.',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(FontAwesome.instagram),
                        onPressed: () {
                          // Abra a página do Instagram
                        },
                      ),
                      IconButton(
                        icon: Icon(FontAwesome.twitter),
                        onPressed: () {
                          // Abra a página do Twitter
                        },
                      ),
                      IconButton(
                        icon: Icon(FontAwesome.facebook),
                        onPressed: () {
                          // Abra a página do Facebook
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
            ),
            ListTile(
              title: Text('Login'),
              onTap: () {
                // Implemente a lógica para abrir a tela de login
              },
            ),
            ListTile(
              title: Text('Cadastro'),
              onTap: () {
                // Implemente a lógica para abrir a tela de cadastro
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                // Implemente a lógica para abrir a tela "Sobre"
              },
            ),
          ],
        ),
      ),
    );
  }
}
