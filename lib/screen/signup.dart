import 'package:flutter/material.dart';
import 'auth_storage.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final first = TextEditingController();
  final last = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();
  final confirm = TextEditingController();

  bool showPass = false;
  bool showConfirm = false;

  String? error;

  bool validEmail(String e) =>
      e.endsWith("@gmail.com") || e.endsWith("@email.com");

  bool strong(String p) =>
      p.length >= 8 &&
          RegExp(r'[A-Z]').hasMatch(p) &&
          RegExp(r'[0-9]').hasMatch(p) &&
          RegExp(r'[!@#\$&*]').hasMatch(p);

  // NAME VALIDATION (still active)
  bool validName(String name) {
    return name.trim().length >= 4;
  }

  Future<void> signUp() async {
    setState(() => error = null);

    if (first.text.isEmpty ||
        last.text.isEmpty ||
        email.text.isEmpty ||
        pass.text.isEmpty ||
        confirm.text.isEmpty) {
      setState(() => error = "All fields required");
      return;
    }

    if (!validName(first.text)) {
      setState(() => error = "First name too short");
      return;
    }

    if (!validName(last.text)) {
      setState(() => error = "Last name too short");
      return;
    }

    if (!validEmail(email.text)) {
      setState(() => error = "Invalid email domain");
      return;
    }

    if (!strong(pass.text)) {
      setState(() => error = "Weak password");
      return;
    }

    if (pass.text != confirm.text) {
      setState(() => error = "Passwords do not match");
      return;
    }

    await AuthStorage.saveUser(
      email: email.text,
      password: pass.text,
      firstName: first.text,
      lastName: last.text,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [

              const Text("Sign Up", style: TextStyle(fontSize: 28)),

              TextField(
                controller: first,
                decoration: const InputDecoration(labelText: "First Name"),
              ),

              TextField(
                controller: last,
                decoration: const InputDecoration(labelText: "Last Name"),
              ),

              TextField(
                controller: email,
                decoration: const InputDecoration(labelText: "Email"),
              ),

              TextField(
                controller: pass,
                obscureText: !showPass,
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPass ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () => setState(() => showPass = !showPass),
                  ),
                ),
              ),

              TextField(
                controller: confirm,
                obscureText: !showConfirm,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      showConfirm ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () => setState(() => showConfirm = !showConfirm),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              if (error != null)
                Text(error!, style: const TextStyle(color: Colors.red)),

              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: signUp,
                child: const Text("Create Account"),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    },
                    child: const Text("Login"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}