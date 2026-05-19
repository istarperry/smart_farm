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

  bool strong(String p) =>
      p.length >= 8 &&
          RegExp(r'[A-Z]').hasMatch(p) &&
          RegExp(r'[0-9]').hasMatch(p) &&
          RegExp(r'[!@#\$&*]').hasMatch(p);

  Future<void> reset() async {
    final user = await AuthStorage.getUser();

    if (email.text != user["email"]) {
      setState(() => msg = "Email not found");
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

    // ✅ SUCCESS → GO BACK TO LOGIN
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot Password")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [

              const SizedBox(height: 10),

              const Text(
                "Reset Password",
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              // EMAIL
              TextField(
                controller: email,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 10),

              // NEW PASSWORD
              TextField(
                controller: newPass,
                obscureText: !showNew,
                decoration: InputDecoration(
                  labelText: "New Password",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showNew ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() => showNew = !showNew);
                    },
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // CONFIRM PASSWORD
              TextField(
                controller: confirm,
                obscureText: !showConfirm,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showConfirm ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() => showConfirm = !showConfirm);
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // RESET BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.all(15),
                  ),
                  onPressed: reset,
                  child: const Text("Reset Password"),
                ),
              ),

              const SizedBox(height: 10),

              // MESSAGE
              if (msg != null)
                Text(
                  msg!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: msg == "Password updated successfully"
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}