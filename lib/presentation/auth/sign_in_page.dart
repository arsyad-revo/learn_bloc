/// Author: Damodar Lohani
/// profile: https://github.com/lohanidamodar
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/application/auth/cubit/auth_cubit.dart';
import 'package:learn_bloc/domain/auth/model/login_request.dart';
import 'package:learn_bloc/presentation/home/home_page.dart';
import 'package:learn_bloc/utils/debug_util.dart';
import 'package:learn_bloc/utils/widget_util.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            DebugUtil().logDebug(state.errorMessage, logName: 'Login Error');
            WidgetUtil().snackbarAlert(state.errorMessage, context);
          } else if (state is AuthLoading) {
            DebugUtil().logDebug("LOADING", logName: 'Login Loading');
          } else if (state is AuthSuccess) {
            DebugUtil().logDebug(state.data.token!, logName: 'Login Data');
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomePage()));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Card(
                        color: const Color.fromARGB(255, 54, 216, 244),
                        margin: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        elevation: 10,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                SafeArea(
                  child: ListView(
                    children: [
                      const SizedBox(height: 40.0),
                      Text(
                        "Welcome",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      const Text(
                        "Awesome login Form",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Card(
                        margin: const EdgeInsets.all(32.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          primary: false,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(16.0),
                          children: [
                            const SizedBox(height: 20.0),
                            Text(
                              "Log In",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    color:
                                        const Color.fromARGB(255, 50, 8, 236),
                                  ),
                            ),
                            const SizedBox(height: 40.0),
                            TextField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: "Enter Email",
                              ),
                            ),
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: "Enter password",
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            (state is AuthLoading)
                                ? _btnLoginLoading()
                                : _btnLogin(context),
                            const SizedBox(height: 10.0),
                            TextButton(
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromARGB(255, 10, 6, 253),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () {},
                            ),
                            const SizedBox(height: 20.0),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  ElevatedButton _btnLogin(BuildContext context) {
    return ElevatedButton(
      child: const Text("LOGIN"),
      onPressed: () {
        LoginRequest _loginRequest = LoginRequest(
            email: _emailController.text, password: _passwordController.text);
        context.read<AuthCubit>().loginUser(_loginRequest);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
      ),
    );
  }

  ElevatedButton _btnLoginLoading() {
    return ElevatedButton(
      child: const CircularProgressIndicator(),
      onPressed: null,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
      ),
    );
  }
}
