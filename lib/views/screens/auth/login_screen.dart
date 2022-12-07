import 'package:flutter/material.dart';
import 'package:tiktok_flutter/constants.dart';
import 'package:tiktok_flutter/views/widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  // ♦ Constructor:
  LoginScreen({Key? key}) : super(key: key);

  // ♦ Properties:
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // ♦ The "nuild()" Method:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ♦ App Name - "Text Field":
            Text(
              'Tiktok Clone',
              style: TextStyle(
                fontSize: 35,
                color: buttonColor,
                fontWeight: FontWeight.w900,
              ),
            ),

            // ♦ Screen Title - "Text Field":
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),

            // ♦ Spacing Between Components:
            const SizedBox(
              height: 25,
            ),

            // ♦ Email - "Text Input Field":
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _emailController,
                labelText: 'Email',
                icon: Icons.email,
              ),
            ),

            // ♦ Spacing Between Components:
            const SizedBox(
              height: 25,
            ),

            // ♦ Password - "Text Input Field":
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _passwordController,
                labelText: 'Password',
                icon: Icons.lock,
                isObscure: true,
              ),
            ),

            // ♦ Spacing Between Components:
            const SizedBox(
              height: 30,
            ),

            // ♦ Login - "Button"
            Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 50,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),

              // ♦ The "Rectangular Area" of a "Material"
              //    → that "Responds" to "Touch:"
              child: InkWell(
                onTap: () {
                  debugPrint('navigating user');
                },
                child: const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),

            // ♦ Spacing Between Components:
            const SizedBox(
              height: 15,
            ),

            // ♦ Register - "Text Area"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account? ',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),

                // ♦ The "Rectangular Area" of a "Material"
                //    → that "Responds" to "Touch:"
                InkWell(
                  onTap: () {
                    debugPrint('navigating user');
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 20, color: buttonColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
