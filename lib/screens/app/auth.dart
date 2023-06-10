import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nano/repos/repos.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var working = false;

  final emailController = TextEditingController(text: 'mor_2314');
  final passwordController = TextEditingController(text: '83r5^_');

  Future<void> onLoginHandler() async {
    if (working) {
      return;
    }

    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email cannot be empty'),
          duration: Duration(seconds: 2),
        ),
      );

      return;
    }

    ///
    else if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password cannot be empty'),
          duration: Duration(seconds: 2),
        ),
      );

      return;
    }

    setState(() {
      working = true;
    });

    try {
      await UserRepo.instance.login(
        emailController.text,
        passwordController.text,
      );

      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/products',
          (route) => false,
        );
      }
    } catch (error) {
      if (error is String) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      }

      setState(() {
        working = false;
      });
    }
  }

  void onTapHelpHandler() {}

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final colorScheme = Theme.of(context).colorScheme;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: ListView(
          /// disabled bounce effect
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            /// Header
            SizedBox(
              width: width,
              height: width,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primary,
                      colorScheme.secondary,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: mediaQuery.padding.top),
                    Expanded(
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/logo.svg',
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 36,
                      ),
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 34,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 54,
                horizontal: 36,
              ).copyWith(bottom: 0),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      label: Text('Email'),
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: const InputDecoration(
                      label: Text('Password'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: onLoginHandler,
                      child: working
                          ? const CircularProgressIndicator.adaptive()
                          : const Text('Continue'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: onTapHelpHandler,
                    child: const Text('NEED HELP ?'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
