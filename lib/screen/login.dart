import 'package:flutter/material.dart';
import 'auth_storage.dart';
import '../dashboard/dashboard.dart';
import 'forgetpassword.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final pass = TextEditingController();

  bool remember = false;
  bool showPass = false;

  String? error;

  Future<void> login() async {
    final user = await AuthStorage.getUser();

    if (email.text == user["email"] &&
        pass.text == user["password"]) {

      await AuthStorage.setRemember(remember);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainDashboard()),
      );
    } else {
      setState(() => error = "Failed to login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [

              const SizedBox(height: 30),

              const Text(
                "Login",
                style: TextStyle(fontSize: 28),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: email,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: pass,
                obscureText: !showPass,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPass ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        showPass = !showPass;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Checkbox(
                    value: remember,
                    onChanged: (v) => setState(() => remember = v!),
                  ),
                  const Text("Remember Me"),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ForgotPasswordPage(),
                        ),
                      );
                    },
                    child: const Text("Forgot Password?"),
                  ),
                ],
              ),

              if (error != null)
                Text(
                  error!,
                  style: const TextStyle(color: Colors.red),
                ),

              const SizedBox(height: 20),

              // 🟢 GREEN LOGIN BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.all(15),
                  ),
                  onPressed: login,
                  child: const Text("Login"),
                ),
              ),

              const SizedBox(height: 20),

              // 🔁 DON'T HAVE ACCOUNT → SIGN UP
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SignUpPage(),
                        ),
                      );
                    },
                    child: const Text("Sign Up"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}