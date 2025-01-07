import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';
import 'package:fresh_feed/providers/network_inf_provider.dart';

import '../providers/user_provider.dart';
import '../utils/app_alerts.dart';
import 'home_screen.dart';

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
    final network_steam = ref.watch(networkInfoStreamNotifierProv);

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
                error: (err, stack) {
                  print('=======================>');
                  print(stack);
                  return Text(
                    err.toString(),
                    style: const TextStyle(color: Colors.red),
                  );
                },
                loading: () => const CircularProgressIndicator(),
                data: (user) {
                  // auth_repo.listenToEmailVerification(user, context);

                  return Column(
                    children: [
                      user == null
                          ? const Text('user does not sign yet')
                          : Text(user.toString()),
                      const SizedBox(
                        height: 20,
                      ),
                      network_steam.when(
                        data: (data) => Text(
                          data.toString(),
                          style:
                              const TextStyle(fontSize: 28, color: Colors.blue),
                        ),
                        loading: () => const CircularProgressIndicator(),
                        error: (error, stackTrace) => Text(
                          error.toString(),
                          style: const TextStyle(color: Colors.red),
                        ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            color: Colors.yellow,
                            child: const Text('Send Email'),
                            onPressed: () async {
                              try {
                                await auth_repo.sendEmailVerification();
                                await auth_repo.listenToEmailVerification(user,
                                    () {
                                  AppAlerts.displaySnackBar(
                                      'success updated', context);
                                });
                                // auth_repo.cancelTimer();
                                final v = await auth_repo.isUserEmailVerified();
                                print('================> $v');
                              } catch (e) {
                                print(e);
                                AppAlerts.displaySnackBar(
                                    e.toString(), context);
                              }
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          MaterialButton(
                            color: Colors.orange,
                            child: const Text('reset password'),
                            onPressed: () async {
                              try {
                                await auth_repo.resetPassword(user!.email!);
                              } catch (e) {
                                print(e.toString());
                                AppAlerts.displaySnackBar(
                                    e.toString(), context);
                              }
                              // auth_repo.cancelTimer();
                            },
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
                            try {
                              await auth_repo.signIn(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                            } catch (e) {
                              print(e.toString());
                              AppAlerts.displaySnackBar(e.toString(), context);
                            }
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
                          try {
                            await auth_repo.signInWithGoogle();
                          } catch (e) {
                            print(e.toString());
                            AppAlerts.displaySnackBar(e.toString(), context);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        color: Colors.red,
                        child: const Text('Log out'),
                        onPressed: () async {
                          // await auth_repo.signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
