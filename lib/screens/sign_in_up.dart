import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';

import '../providers/user_provider.dart';
import '../utils/app_alerts.dart';

class SignInUp extends ConsumerStatefulWidget {
  const SignInUp({super.key});

  @override
  ConsumerState<SignInUp> createState() => _SignInUpState();
}

class _SignInUpState extends ConsumerState<SignInUp> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose is called');
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(userNotifierProvider);
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
                  // auth_repo.listenToEmailVerification(user, context);
                  if (user == null) {
                    return const Text('user does not sign yet');
                  }
                  return Text(user.toString());
                },
                error: (err, stack) {
                  print('=======================>');
                  print(stack);
                  return Text(
                    err.toString(),
                    style: const TextStyle(color: Colors.red),
                  );
                },
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
                    controller: _nameController,
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Name',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: Colors.yellow,
                child: const Text('Send Email'),
                onPressed: () async {
                  await auth_repo.sendEmailVerification(context);
                  // auth_repo.cancelTimer();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: Colors.blue,
                child: const Text('Sign up'),
                onPressed: () async {
                  if (_emailController.text.trim().isNotEmpty &&
                      _passwordController.text.trim().isNotEmpty &&
                      _nameController.text.trim().isNotEmpty) {
                    try {
                      await auth_repo.signUp(
                          userName: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text);
                    } catch (e) {
                      AppAlerts.displaySnackBar(e.toString(), context);
                    }
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
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
