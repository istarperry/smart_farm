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

  @override
  void initState() {
    super.initState();
    loadRememberedLogin();
  }

  // ✅ AUTO FILL ONLY (NO AUTO LOGIN)
  void loadRememberedLogin() async {
    final data = await AuthStorage.getRememberLogin();

    if (!mounted) return;

    setState(() {
      email.text = data["email"] ?? "";
      pass.text = data["password"] ?? "";
    });
  }

  // VALIDATION
  bool validInput(String value) {
    final emailValid =
        value.endsWith("@gmail.com") ||
            value.endsWith("@email.com");

    final phoneValid = RegExp(r'^[0-9]{10}$').hasMatch(value);

    return emailValid || phoneValid;
  }

  Future<void> login() async {
    setState(() => error = null);

    if (!validInput(email.text)) {
      setState(() {
        error = "Enter valid email or 10-digit phone number";
      });
      return;
    }

    final user = await AuthStorage.getUser();

    if (email.text == user["email"] &&
        pass.text == user["password"]) {

      await AuthStorage.setRemember(remember);

      if (remember) {
        await AuthStorage.setRememberLogin(
          email: email.text,
          password: pass.text,
        );
      }

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const DashboardPage(),
        ),
      );
    } else {
      setState(() => error = "Incorrect email/phone or password");
    }
  }

  InputDecoration fieldStyle(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Card(
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),

              child: Padding(
                padding: const EdgeInsets.all(25),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    const Icon(
                      Icons.agriculture,
                      size: 80,
                      color: Colors.green,
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),

                    const SizedBox(height: 25),

                    TextField(
                      controller: email,
                      decoration:
                      fieldStyle("Email or Phone Number"),
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: pass,
                      obscureText: !showPass,
                      decoration: fieldStyle("Password").copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            showPass
                                ? Icons.visibility
                                : Icons.visibility_off,
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
                          activeColor: Colors.green,
                          value: remember,
                          onChanged: (v) {
                            setState(() {
                              remember = v ?? false;
                            });
                          },
                        ),

                        const Text("Remember Me"),

                        const Spacer(),

                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const ForgotPasswordPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),

                    if (error != null)
                      Text(
                        error!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: login,
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

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
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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