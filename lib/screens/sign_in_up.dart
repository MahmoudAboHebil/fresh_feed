import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';

import '../providers/user_provider.dart';

class SignInUp extends ConsumerStatefulWidget {
  const SignInUp({super.key});

  @override
  ConsumerState<SignInUp> createState() => _SignInUpState();
}

class _SignInUpState extends ConsumerState<SignInUp> {
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(userProvider(context));
    final auth_repo = ref.watch(authRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Sign UP&IN'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              currentUser.when(
                data: (user) {
                  if (user == null) {
                    return const Text('user does not sign yet');
                  }
                  return Text(user.toString());
                },
                error: (err, stack) => Text(
                  err.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
                loading: () => const CircularProgressIndicator(),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  TextField(
                    controller: _emailController,
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: _passwordController,
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: _codeController,
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Code',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: Colors.blue,
                child: const Text('Sign up'),
                onPressed: () async {
                  if (_emailController.text.trim().isNotEmpty &&
                      _passwordController.text.trim().isNotEmpty) {
                    await auth_repo.signUp(
                        context: context,
                        email: _emailController.text,
                        password: _passwordController.text);
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: Colors.purple,
                child: const Text('Sign in'),
                onPressed: () async {
                  if (_emailController.text.trim().isNotEmpty &&
                      _passwordController.text.trim().isNotEmpty) {
                    await auth_repo.signIn(
                        context: context,
                        email: _emailController.text,
                        password: _passwordController.text);
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: Colors.green,
                child: const Text('Google'),
                onPressed: () async {
                  await auth_repo.signInWithGoogle(context);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: Colors.red,
                child: const Text('Log out'),
                onPressed: () async {
                  await auth_repo.signOut(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
