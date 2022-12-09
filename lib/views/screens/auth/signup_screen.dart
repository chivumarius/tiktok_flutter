import 'package:flutter/material.dart';
import 'package:tiktok_flutter/constants.dart';
import 'package:tiktok_flutter/views/screens/auth/login_screen.dart';
import 'package:tiktok_flutter/views/widgets/text_input_field.dart';

// ♦♦ The "Stateless Widget":
class SignupScreen extends StatelessWidget {
  // ♦ Constructor:
  SignupScreen({Key? key}) : super(key: key);

  // ♦ Properties:
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  // ♦ The "build()" MethodL
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
              'Register',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),

            // ♦ Spacing Between Components:
            const SizedBox(
              height: 25,
            ),

            // ♦ "Positioning" the "Children"
            //    → Relative to the "Edges" of "Its Box":
            Stack(
              children: [
                // ♦ Avatar - "Area":
                const CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                      'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                  backgroundColor: Colors.black,
                ),

                // ♦ Add a Photo - "Icon Button":
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: () => authController.pickImage(),
                    icon: const Icon(
                      Icons.add_a_photo,
                    ),
                  ),
                ),
              ],
            ),

            // ♦ Spacing Between Components:
            const SizedBox(
              height: 15,
            ),

            // ♦ Username - "Text Input Field":
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _usernameController,
                labelText: 'Username',
                icon: Icons.person,
              ),
            ),

            // ♦ Spacing Between Components:
            const SizedBox(
              height: 15,
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
              height: 15,
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

            // ♦ Register - "Button"
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
                onTap: () => authController.registerUser(
                  _usernameController.text,
                  _emailController.text,
                  _passwordController.text,
                  authController.profilePhoto,
                ),
                child: const Center(
                  child: Text(
                    'Register',
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

            // ♦ Login - "Text Area"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account? ',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),

                // ♦ The "Rectangular Area" of a "Material"
                //    → that "Responds" to "Touch:"
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  ),
                  child: Text(
                    'Login',
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
