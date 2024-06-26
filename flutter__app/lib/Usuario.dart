import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Usuario(),
  ));
}

class Usuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage('https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/bae58b19-3adb-45a5-a03c-2a2830f73337/dfeymjz-7b2a2c21-ccb3-4856-b28e-42fb463457a7.png/v1/fill/w_817,h_978,strp/the_super_mario_bros__movie_mario_render_png_by_junior3dsymas_dfeymjz-pre.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTUyMSIsInBhdGgiOiJcL2ZcL2JhZTU4YjE5LTNhZGItNDVhNS1hMDNjLTJhMjgzMGY3MzMzN1wvZGZleW1qei03YjJhMmMyMS1jY2IzLTQ4NTYtYjI4ZS00MmZiNDYzNDU3YTcucG5nIiwid2lkdGgiOiI8PTEyNzAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.2MUxwqX-d5sMYEf0iPH3IoGwFtL4ypORE7ISPFY76CE'), // Replace with your profile image URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Mario',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10), // Space between the name and the icon
                GestureDetector(
                  onTap: () {
                    // Navigate to the edit profile screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditProfileScreen()),
                    );
                  },
                  child: Icon(
                    Icons.more_vert,
                    size: 36,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  GalleryItem(imageUrl: 'https://th.bing.com/th/id/OIP.cTBrgMaqrogZl4WNQYwfcAHaGq?&rs=1&pid=ImgDetMain'),
                  GalleryItem(imageUrl: 'https://i.pinimg.com/originals/d0/4a/d6/d04ad6a81f4dd3ca11ebf097e30afdfb.jpg'),
                  GalleryItem(imageUrl: 'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/943fc32c-852a-4b80-a885-ffb1a86e58dd/df1sqxg-590eacaa-bdc9-4c23-8bd3-d5413ebfa552.png/v1/fill/w_727,h_677/odyssey3_by_mariorenderart_df1sqxg-fullview.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwib2JpIjpbW3siaGVpZ2h0IjoiPD02NzcwIiwicGF0aCI6IlwvZlwvOTQzZmMzMmMtODUyYS00YjgwLWE4ODUtZmZiMWE4NmU1OGRkXC9kZjFzcXhnLTU5MGVhY2FhLWJkYzktNGMyMy04YmQzLWQ1NDEzZWJmYTU1Mi5wbmciLCJ3aWR0aCI6Ijw9NzI3In1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmltYWdlLm9wZXJhdGlvbnMiXX0.mwFLfv5O62q-YtLBd49mHf5uVUvLKK6-XP_r-Biqpd0'),
                  // Add more gallery items as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
      ),
      body: Center(
        child: Text(
          'Tela de Edição de Perfil',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class GalleryItem extends StatelessWidget {
  final String imageUrl;

  GalleryItem({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
