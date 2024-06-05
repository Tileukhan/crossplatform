import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finalversion/pages/get_started.dart';
import 'registration_screen.dart'; // Ensure you have this import if RegistrationScreen is in another file

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  final _auth = FirebaseAuth.instance;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final newUser = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
        if (newUser != null) {
          print('Login Successful');
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => GetStarted()));
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF161b58), Color(0xFF34dbfe)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0.4, 0.7],
            tileMode: TileMode.repeated,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/loginscreen.webp',
                      height: 350,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      onSaved: (value) => _email = value!,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                      ),
                      validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      onSaved: (value) => _password = value!,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                      ),
                      validator: (value) => value!.isEmpty ? 'Please enter your password' : null,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submit,
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF00d8d6),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegistrationScreen()));
                      },
                      child: Text("Don't have an account? Register"),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white, // Text color
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
