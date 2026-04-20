import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // super.key digunakan untuk mengirimkan bahwa key yang diberikan 
  // widget ini unik dan tidak bentrok dengan widget lain dalam pohon wiget.
  const MyApp({super.key});

// widget builder
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  // global key
  final _formKey = GlobalKey<FormState>();
  // membuat controller
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

// fungsi login
  void login() {
    // jika login berhasil
    if (_formKey.currentState!.validate()) {
      String username = usernameController.text;
      String password = passwordController.text;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(username: username),
        ),
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(content: Text('Login berhasil $username')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Login',
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // input untuk username
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  // pengkondisian pertama
                  if (value == null || value.isEmpty) {
                    return 'Username wajib diisi';
                  }
                  if (value.length < 4) {
                    return 'Username minimal 4 karakter';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  // pengkondisian pertama
                  if (value == null || value.isEmpty) {
                    return 'Password wajib diisi';
                  }
                  if (value.length < 4) {
                    return 'Password minimal 4 karakter';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12,),
              ElevatedButton(
                onPressed: login,
                child: Text("Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}