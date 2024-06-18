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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/registro.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child:SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(50.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(144, 78, 74, 74),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 5,
                  blurRadius: 3,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
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
                        labelStyle: TextStyle(color: Colors.white), 
                        prefixIcon: Icon(Icons.person, color: Colors.white,),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,),
                        ),
                      ),
                  ),
                ),
                SizedBox(height: 10.0),
                SizedBox(
                  height: 42.0,
                  width: 350.0,
                  child:TextFormField(
                    style: TextStyle(color: Colors.white,),
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      labelStyle: TextStyle(color: Colors.white), 
                        
                      prefixIcon: Icon(Icons.email, color: Colors.white,),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white,),
                      ),
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
                        labelStyle: TextStyle(color: Colors.white), 
                        prefixIcon: Icon(Icons.phone, color: Colors.white,),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,),
                        ),
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
                      labelStyle: TextStyle(color: Colors.white), 
                      prefixIcon: Icon(Icons.person, color: Colors.white,),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white,),
                      ),
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
                        labelStyle: TextStyle(color: Colors.white), 
                        prefixIcon: Icon(Icons.lock, color: Colors.white,),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,),
                        ),
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
                    labelStyle: TextStyle(color: Colors.white), 
                    prefixIcon: Icon(Icons.photo, color: Colors.white,),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white,),
                      ),
                    hintText: 'Adicionar foto',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.camera_alt, color: Colors.white,),
                      onPressed: () {},
                    ),
                  ),
                ),
                ),
                SizedBox(height: 10.0),
                SizedBox(
                        width: 350, 
                        height: 42, 
                child: ElevatedButton(
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
                            foregroundColor: Color(0xFFFCFDF9), 
                            backgroundColor: Color(0xFF435364), 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
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
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
        ),
        ),
      ),
      ),
    );
  }
}
