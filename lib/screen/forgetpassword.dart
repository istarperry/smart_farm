import 'package:flutter/material.dart';
import 'auth_storage.dart';
import 'login.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final email = TextEditingController();
  final newPass = TextEditingController();
  final confirm = TextEditingController();

  bool showNew = false;
  bool showConfirm = false;

  String? msg;

  // EMAIL OR PHONE VALIDATION
  bool validInput(String value) {
    bool emailValid =
        value.endsWith("@gmail.com") ||
            value.endsWith("@email.com");

    bool phoneValid =
    RegExp(r'^[0-9]{10}$').hasMatch(value);

    return emailValid || phoneValid;
  }

  bool strong(String p) =>
      p.length >= 8 &&
          RegExp(r'[A-Z]').hasMatch(p) &&
          RegExp(r'[0-9]').hasMatch(p) &&
          RegExp(r'[!@#\$&*]').hasMatch(p);

  Future<void> reset() async {
    final user = await AuthStorage.getUser();

    if (!validInput(email.text)) {
      setState(() => msg = "Enter valid email or 10-digit phone number");
      return;
    }

    if (email.text != user["email"]) {
      setState(() => msg = "Account not found");
      return;
    }

    if (!strong(newPass.text)) {
      setState(() => msg = "Weak password");
      return;
    }

    if (newPass.text != confirm.text) {
      setState(() => msg = "Passwords do not match");
      return;
    }

    await AuthStorage.updatePassword(newPass.text);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false,
    );
  }

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
                      Icons.lock_reset,
                      size: 80,
                      color: Colors.green,
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Reset Password",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // EMAIL OR PHONE
                    TextField(
                      controller: email,
                      decoration:
                      fieldStyle("Email or Phone Number"),
                    ),

                    const SizedBox(height: 15),

                    // NEW PASSWORD
                    TextField(
                      controller: newPass,
                      obscureText: !showNew,
                      decoration: fieldStyle("New Password").copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            showNew
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() => showNew = !showNew);
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
                            setState(() => showConfirm = !showConfirm);
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    if (msg != null)
                      Text(
                        msg!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: msg == "Password updated successfully"
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    const SizedBox(height: 25),

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
                        onPressed: reset,
                        child: const Text(
                          "Reset Password",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Back to Login",
                        style: TextStyle(color: Colors.green),
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