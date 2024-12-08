import 'package:e_resto/login.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      // Aksi jika form valid
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Layer 1: Background
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: const Color.fromARGB(255, 2, 106, 5),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background image
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/background.png',
                    fit: BoxFit.cover, // Mengisi seluruh layar
                  ),
                ),
                // Logo di bagian atas tengah
                Positioned(
                  top: 50, // Jarak dari atas layar
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      // Logo tetap di tengah
                      Image.asset(
                        'assets/images/logo_warteg.png',
                        width: 170, // Ukuran logo
                      ),
                      const SizedBox(height: 17),
                      // Teks di sebelah kiri
                      const Align(
                        alignment: Alignment.centerLeft, // Teks di sebelah kiri
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 25), // Memberikan sedikit jarak dari kiri
                          child: Text(
                            'Buat Akun\n Barumu!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height *
                        0.6, // Mengatur tinggi menjadi 60% dari layar
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Username
                          TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Username harus diisi';
                              }
                              // Validasi username (misalnya, panjang minimal 5 karakter)
                              if (value.length < 5) {
                                return 'Username harus lebih dari 5 karakter';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),

                          // Email
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email harus diisi';
                              }
                              // Validasi format email
                              String pattern =
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                              RegExp regExp = RegExp(pattern);
                              if (!regExp.hasMatch(value)) {
                                return 'Format email tidak valid';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),

                          // No. HP
                          TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              labelText: 'No. Hp',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'No. Hp harus diisi';
                              }
                              // Validasi nomor telepon (hanya angka dan panjang minimal 10 digit)
                              String pattern = r'^\d{10,}$';
                              RegExp regExp = RegExp(pattern);
                              if (!regExp.hasMatch(value)) {
                                return 'Nomor telepon harus terdiri dari angka dan minimal 10 digit';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),

                          // Password
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password harus diisi';
                              }
                              // Validasi password (misalnya, minimal 8 karakter)
                              if (value.length < 8) {
                                return 'Password harus lebih dari 7 karakter';
                              }
                              return null;
                            },
                          ),
                          // Expanded untuk memastikan tombol tetap di bawah form
                          const SizedBox(height: 15),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 2, 106, 5),
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: _signUp,
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
