import 'package:chatapp/service/auth/auth_service.dart';
import 'package:chatapp/screen/Register_page.dart';
import 'package:chatapp/screen/home.dart';
import 'package:chatapp/util/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false; // To track loading state

  void login() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    final AuthService _authService = AuthService();
    String value = await _authService.signInWithEmailAndPassword(
        _emailController.text, _passwordController.text);

    setState(() {
      _isLoading = false; // Stop loading
    });

    SnackbarUtil.showSnackbar(context, value);
    if (value == "Login Success") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => homeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: _buildUI()),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            _headerText(),
            _showimgage(),
            _loginfield(),
            _loginbutton(),
            _signupinfo()
          ],
        ),
      ),
    );
  }

  Widget _showimgage() {
    return Container(
      width: 350, // Set a fixed width for the container
      height: 350, // Set a fixed height for the container
      child: Image.asset(
        'lib/asserts/login.png',
        width: 100, // Set the width of the image
        height: 100, // Set the height of the image
        fit: BoxFit.cover, // Optionally use BoxFit to control image scaling
      ),
    );
  }

  Widget _loginbutton() {
    return SizedBox(
      width: double.infinity, // Full width of the device
      height: 50, // Set height to 50 (adjust as needed)
      child: TextButton(
        onPressed: _isLoading ? null : login, // Disable button while loading
        style: TextButton.styleFrom(
          foregroundColor: Colors.black, // Text color
          backgroundColor: Colors.blue, // Background color
          side: const BorderSide(
            color: Color.fromARGB(255, 17, 29, 92), // Border color
            width: 2, // Border width
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: _isLoading
            ? CircularProgressIndicator(
                color: Colors.white,
              )
            : const Text("Login"),
      ),
    );
  }

  Widget _headerText() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              "It's been a while...",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginfield() {
    return Column(children: [
      const SizedBox(height: 18),
      TextField(
        controller: _emailController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Email',
        ),
      ),
      const SizedBox(height: 40),
      TextField(
        controller: _passwordController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Password',
        ),
      ),
      const SizedBox(height: 40),
    ]);
  }

  Widget _signupinfo() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Text(
              "Don't have an account?",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            child: Text(
              "Sign Up",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
