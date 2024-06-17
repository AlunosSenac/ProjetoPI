import 'package:flutter/material.dart';
import 'LoginPage.dart'; 

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _photoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro',
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('assets/images/registro.jpg'),
        
            ),

            
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Cadastro',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              SizedBox(
                height: 42.0,
                width: 350.0,
                child:TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                ),
              ),
              SizedBox(height: 10.0),
              SizedBox(
                height: 42.0,
                width: 350.0,
                child:TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              SizedBox(
                height: 42.0,
                width: 350.0,
                child:TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Telefone',
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                      ),
                    keyboardType: TextInputType.phone,
                ),
              ),
              SizedBox(height: 10.0),
              SizedBox(
                height: 42.0,
                width: 350.0,
                child:TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Usuário',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              SizedBox(
                height: 42.0,
                width: 350.0,
                child:TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                ),
              ),
              SizedBox(height: 10.0),
              SizedBox(
              height: 42.0, 
              width: 350.0, 
                child:TextFormField(
                controller: _photoController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Foto de Perfil',
                  prefixIcon: Icon(Icons.photo),
                  border: OutlineInputBorder(),
                  hintText: 'Adicionar foto',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () {},
                  ),
                ),
              ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  String name = _nameController.text;
                  String email = _emailController.text;
                  String phone = _phoneController.text;
                  String address = _addressController.text;
                  String password = _passwordController.text;
                  String photoPath = _photoController.text;

                  print('Nome: $name');
                  print('E-mail: $email');
                  print('Telefone: $phone');
                  print('Endereço: $address');
                  print('Senha: $password');
                  print('Foto de Perfil: $photoPath');
                },
                child: Text('Cadastrar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  'Já possui cadastro? Faça seu Login',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
