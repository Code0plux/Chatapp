import 'dart:io';
import 'package:chatapp/screen/home.dart';
import 'package:chatapp/service/auth/auth_service.dart';
import 'package:chatapp/screen/login_page.dart';
import 'package:chatapp/service/mediaservice.dart';
import 'package:chatapp/util/snackbar.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  File? _image;
  final Mediaservice _mediaservice = Mediaservice();
  bool isloading = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  void register() async {
    final AuthService _authService = AuthService();
    if (_passwordController1.text != _passwordController2.text) {
      SnackbarUtil.showSnackbar(context, "Passwords do not match");
    }
    setState(() {
      isloading = true;
    });
    String value = await _authService.signUpWithEmailAndPassword(
        _emailController.text, _passwordController1.text, _nameController.text);
    SnackbarUtil.showSnackbar(context, value);

    setState(() {
      isloading = false;
    });
    if (value == 'Sign Up Success') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const homeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child: _buildUI()),
    );
  }

  Widget _showimgage() {
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      width: 200, // Set a fixed width for the container
      height: 200, // Set a fixed height for the container
      child: Image.asset(
        'lib/asserts/register.png',
        // Optionally use BoxFit to control image scaling
      ),
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
            _Formfield(),
            _loginbutton(),
            _signupinfo()
          ],
        ),
      ),
    );
  }

  Widget _loginbutton() {
    return SizedBox(
      width: double.infinity, // Full width of the device
      height: 50, // Set height to 50 (adjust as needed)
      child: TextButton(
        onPressed: register,
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
        child: isloading
            ? CircularProgressIndicator(
                color: Colors.white,
              )
            : const Text("Register"),
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
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Text(
              "Lets get started!",
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

  Widget _Formfield() {
    return SizedBox(
        child: Column(children: [
      const SizedBox(height: 30),
      TextField(
        controller: _nameController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Name',
        ),
      ),
      const SizedBox(height: 40),
      TextField(
        controller: _emailController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Email',
        ),
      ),
      const SizedBox(height: 40),
      TextField(
        controller: _passwordController1,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Password',
        ),
      ),
      const SizedBox(height: 40),
      TextField(
        controller: _passwordController2,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Confirm Password',
        ),
      ),
      const SizedBox(height: 40)
    ]));
  }

  Widget _prpfileImage() {
    return GestureDetector(
      onTap: () async {
        await _mediaservice.GetImageFromGalary().then((value) {
          setState(() {
            _image = value;
          });
        });
        // ignore: invalid_use_of_visible_for_testing_member
      },
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.15,
        backgroundImage: _image != null
            ? FileImage(_image!)
            : NetworkImage(
                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")
                as ImageProvider,
      ),
    );
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
              "Already have an account?",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            child: Text(
              "Log in",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
              print("Log in");
            },
          ),
        ],
      ),
    );
  }
}
