import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Adduser2 extends StatefulWidget {
  const Adduser2({super.key});

  @override
  State<Adduser2> createState() => _AdduserState();
}

class _AdduserState extends State<Adduser2> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController namaDepanController = TextEditingController();
  final TextEditingController namaBelakangController = TextEditingController();

  Future<void> addUserData(
      String email, String first_name, String last_name) async {
    var url = "https://reqres.in/api/users/2";
    final response = await http.post(Uri.parse(url), body: {
      "email": email,
      "first_name": first_name,
      "last_name": last_name,
    });
    log(response.body);
  }

  void clearForm() {
    emailController.text = "";
    namaDepanController.text = "";
    namaBelakangController.text = "";
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Berhasil Mengirim Data"),
        content: const Text("Data telah berhasil dikirim ke server."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Add User",
                style:
                    GoogleFonts.montserrat(color: Colors.black, fontSize: 20),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                  hintText: "Masukan Email",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: namaDepanController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nama Depan",
                  hintText: "Nama depan anda",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: namaBelakangController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nama Belakang",
                  hintText: "Nama Belakang Anda",
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final email = emailController.text;
                    if (email.isNotEmpty && email.contains('@')) {
                      await addUserData(
                        email,
                        namaDepanController.text,
                        namaBelakangController.text,
                      );
                      clearForm();
                      showSuccessDialog();
                    } else {
                      // Show error message if email is invalid
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Email tidak valid"),
                      ));
                    }
                  },
                  child: const Text("Kirim"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
