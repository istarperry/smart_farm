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

  // EMAIL OR PHONE VALIDATION
  bool validInput(String value) {
    bool emailValid =
        value.endsWith("@gmail.com") ||
            value.endsWith("@email.com");

    bool phoneValid =
    RegExp(r'^[0-9]{10}$').hasMatch(value);

    return emailValid || phoneValid;
  }

  // PASSWORD VALIDATION
  bool strong(String p) =>
      p.length >= 8 &&
          RegExp(r'[A-Z]').hasMatch(p) &&
          RegExp(r'[0-9]').hasMatch(p) &&
          RegExp(r'[!@#\$&*]').hasMatch(p);

  // NAME VALIDATION
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

    if (!validInput(email.text)) {
      setState(() => error =
      "Enter valid email or 10-digit phone number");
      return;
    }

    if (!strong(pass.text)) {
      setState(() => error =
      "Password must contain:\n8 characters, capital letter, number and symbol");
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

  // TEXTFIELD STYLE
  InputDecoration fieldStyle(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9), // farming green background

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

                    // FARM ICON
                    const Icon(
                      Icons.agriculture,
                      size: 80,
                      color: Colors.green,
                    ),

                    const SizedBox(height: 10),

                    // TITLE
                    const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // FIRST NAME
                    TextField(
                      controller: first,
                      decoration: fieldStyle("First Name"),
                    ),

                    const SizedBox(height: 15),

                    // LAST NAME
                    TextField(
                      controller: last,
                      decoration: fieldStyle("Last Name"),
                    ),

                    const SizedBox(height: 15),

                    // EMAIL OR PHONE
                    TextField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                      fieldStyle("Email or Phone Number"),
                    ),

                    const SizedBox(height: 15),

                    // PASSWORD
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

                    const SizedBox(height: 15),

                    // CONFIRM PASSWORD
                    TextField(
                      controller: confirm,
                      obscureText: !showConfirm,

                      decoration:
                      fieldStyle("Confirm Password").copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            showConfirm
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              showConfirm = !showConfirm;
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // ERROR MESSAGE
                    if (error != null)
                      Text(
                        error!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    const SizedBox(height: 25),

                    // SIGNUP BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 55,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(14),
                          ),
                        ),

                        onPressed: signUp,

                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // LOGIN
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                        ),

                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const LoginPage(),
                              ),
                            );
                          },

                          child: const Text(
                            "Login",
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