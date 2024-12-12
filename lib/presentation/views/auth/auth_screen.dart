import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/bloc/user/user_cubit.dart';
import '../../../app/common/common.dart';
import '../../../app/config/router/app_route_constants.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_textfield.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/radio_bloc.dart';

// enum Auth { signIn, signUp }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Auth _auth = Auth.signUp;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  void initState() {
    context.read<RadioBloc>().add(const RadioChangedEvent(auth: Auth.signUp));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.greyBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/images/amazon_in.png',
                  height: 40,
                  width: 50,
                ),
                const SizedBox.square(
                  dimension: 12,
                ),
                const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                ),
                const SizedBox.square(
                  dimension: 12,
                ),

                // Sign Up Section

                BlocBuilder<RadioBloc, RadioState>(
                  builder: (context, state) {
                    if (state is RadioSignUpState) {
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                bottom: 10, right: 8, left: 8),
                            decoration: BoxDecoration(
                              color: Constants.backgroundColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  minLeadingWidth: 2,
                                  leading: SizedBox.square(
                                    dimension: 12,
                                    child: Radio(
                                        value: Auth.signUp,
                                        groupValue: state.auth,
                                        onChanged: (Auth? val) {
                                          context.read<RadioBloc>().add(
                                              RadioChangedEvent(auth: val!));
                                        }),
                                  ),
                                  title: RichText(
                                    text: const TextSpan(children: [
                                      TextSpan(
                                        text: 'Create account. ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17,
                                            color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: 'New to Amazon?',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black87),
                                      )
                                    ]),
                                  ),
                                  onTap: () {
                                    context.read<RadioBloc>().add(
                                        const RadioChangedEvent(
                                            auth: Auth.signUp));
                                  },
                                ),
                                Form(
                                  key: _signUpFormKey,
                                  child: Column(children: [
                                    CustomTextField(
                                      controller: _nameController,
                                      hintText: 'First and last name',
                                      onChanged: (value) {
                                        context.read<AuthBloc>().add(
                                            TextFieldChangedEvent(
                                                _nameController.text,
                                                _emailController.text,
                                                _passwordController.text));
                                      },
                                    ),
                                    CustomTextField(
                                      controller: _emailController,
                                      hintText: 'Email',
                                      onChanged: (value) {
                                        context.read<AuthBloc>().add(
                                            TextFieldChangedEvent(
                                                _nameController.text,
                                                _emailController.text,
                                                _passwordController.text));
                                      },
                                    ),
                                    CustomTextField(
                                      controller: _passwordController,
                                      hintText: 'Set password',
                                      onChanged: (value) {
                                        context.read<AuthBloc>().add(
                                            TextFieldChangedEvent(
                                                _nameController.text,
                                                _emailController.text,
                                                _passwordController.text));
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    BlocBuilder<AuthBloc, AuthState>(
                                      builder: (context, state) {
                                        if (state is TextFieldErrorState) {
                                          return Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/info_icon.png',
                                                height: 15,
                                                width: 15,
                                                color: Colors.red,
                                              ),
                                              Text('  ${state.errorString}',
                                                style: const TextStyle(color: Colors.red),
                                              )
                                            ],
                                          );
                                        } else {
                                          if (_nameController.text == '' ||
                                              _emailController.text == '' ||
                                              _passwordController.text == '') {
                                            return Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/info_icon.png',
                                                  height: 15,
                                                  width: 15,
                                                ),
                                                const Text(
                                                    '  All fields are required.'),
                                              ],
                                            );
                                          }
                                          return const SizedBox();
                                        }
                                      },
                                    ),
                                    const SizedBox.square(
                                      dimension: 15,
                                    ),
                                    BlocConsumer<AuthBloc, AuthState>(
                                      listener: (context, state) {
                                        if (state is AuthErrorState) {
                                          debugPrint(state.errorString);
                                          showSnackBar(
                                              context, state.errorString);
                                        }
                                        if (state is CreateUserSuccessState) {
                                          showSnackBar(
                                              context, state.userCreatedString);
                                          context.read<RadioBloc>().add(
                                              const RadioChangedEvent(
                                                  auth: Auth.signIn));
                                        }
                                        if (state is CreateUserErrorState) {
                                          showSnackBar(
                                              context, state.errorString);
                                        }
                                      },
                                      builder: (context, state) {
                                        if (state is AuthLoadingState) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else {
                                          return CustomElevatedButton(
                                            buttonText: 'Create account',
                                            onPressed: () {
                                              if (_signUpFormKey.currentState!
                                                  .validate()) {
                                                // signUpUser();
                                                FocusManager.instance.primaryFocus?.unfocus();

                                                BlocProvider.of<AuthBloc>(
                                                    context)
                                                    .add(
                                                    CreateAccountPressedEvent(
                                                        _nameController
                                                            .text,
                                                        _emailController
                                                            .text,
                                                        _passwordController
                                                            .text));
                                              }
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                bottom: 10, right: 8, left: 8),
                            decoration: BoxDecoration(
                                color: Constants.greyBackgroundColor,
                                borderRadius: BorderRadius.circular(6)),
                            child: Column(
                              children: [
                                ListTile(
                                  minLeadingWidth: 2,
                                  leading: SizedBox.square(
                                    dimension: 12,
                                    child: Radio(
                                        value: Auth.signIn,
                                        groupValue: state.auth,
                                        onChanged: (Auth? val) {
                                          context.read<RadioBloc>().add(
                                              RadioChangedEvent(auth: val!));
                                        }),
                                  ),
                                  title: RichText(
                                    text: const TextSpan(children: [
                                      TextSpan(
                                        text: 'Sign in. ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17,
                                            color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: 'Already a customer?',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black87),
                                      ),
                                    ]),
                                  ),
                                  onTap: () {
                                    context.read<RadioBloc>().add(
                                        const RadioChangedEvent(
                                            auth: Auth.signIn));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    if (state is RadioSignInState) {
                      return Column(
                        children: [
                          Container(
                              padding: const EdgeInsets.only(
                                  bottom: 10, right: 8, left: 8),
                              decoration: BoxDecoration(
                                color: Constants.greyBackgroundColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(children: [
                                ListTile(
                                  minLeadingWidth: 2,
                                  leading: SizedBox.square(
                                    dimension: 12,
                                    child: Radio(
                                        value: Auth.signUp,
                                        groupValue: state.auth,
                                        onChanged: (Auth? val) {
                                          context.read<RadioBloc>().add(
                                              RadioChangedEvent(auth: val!));
                                        }),
                                  ),
                                  title: RichText(
                                    text: const TextSpan(children: [
                                      TextSpan(
                                        text: 'Create account. ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17,
                                            color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: 'New to Amazon?',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black87),
                                      )
                                    ]),
                                  ),
                                  onTap: () {
                                    context.read<RadioBloc>().add(
                                        const RadioChangedEvent(
                                            auth: Auth.signUp));
                                  },
                                ),
                              ])),
                          Container(
                            padding: const EdgeInsets.only(
                                bottom: 10, right: 8, left: 8),
                            decoration: BoxDecoration(
                                color: Constants.backgroundColor,
                                borderRadius: BorderRadius.circular(6)),
                            child: Column(
                              children: [
                                ListTile(
                                  minLeadingWidth: 2,
                                  leading: SizedBox.square(
                                    dimension: 12,
                                    child: Radio(
                                        value: Auth.signIn,
                                        groupValue: state.auth,
                                        onChanged: (Auth? val) {
                                          context.read<RadioBloc>().add(
                                              RadioChangedEvent(auth: val!));
                                        }),
                                  ),
                                  title: RichText(
                                    text: const TextSpan(children: [
                                      TextSpan(
                                        text: 'Sign in. ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17,
                                            color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: 'Already a customer?',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black87),
                                      ),
                                    ]),
                                  ),
                                  onTap: () {
                                    context.read<RadioBloc>().add(
                                        const RadioChangedEvent(
                                            auth: Auth.signIn));
                                  },
                                ),
                                Form(
                                  key: _signInFormKey,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: TextFormField(
                                          controller: _emailController,
                                          maxLines: 1,
                                          onChanged: (value) {
                                            context.read<AuthBloc>().add(
                                                TextFieldChangedEvent(
                                                    _nameController.text,
                                                    value,
                                                    _passwordController.text)
                                            );
                                          },
                                          decoration: const InputDecoration(
                                            hintText: 'Email',
                                            hintStyle: TextStyle(fontWeight: FontWeight.w400),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black38),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black38),
                                            ),
                                          ),
                                          validator: (val) {
                                            if (val == null || val.isEmpty) {
                                              return 'This field cannot be empty';
                                            } else if (!isEmailValid(val)) {
                                              return 'Please enter a valid email address.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: TextFormField(
                                          controller: _passwordController,
                                          maxLines: 1,
                                          onChanged: (value) {
                                            context.read<AuthBloc>().add(
                                                TextFieldChangedEvent(
                                                    _nameController.text,
                                                    _emailController.text,
                                                    value)
                                            );
                                          },
                                          decoration: const InputDecoration(
                                            hintText: 'Password',
                                            hintStyle: TextStyle(fontWeight: FontWeight.w400),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black38),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black38),
                                            ),
                                          ),
                                          validator: (val) {
                                            if (val == null || val.length < 6) {
                                              return 'Passwords must be at least 6 characters.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox.square(
                                        dimension: 6,
                                      ),
                                      BlocConsumer<AuthBloc, AuthState>(
                                        listener: (context, state) {
                                          if (state is AuthErrorState) {
                                            showSnackBar(
                                                context, state.errorString);
                                          }
                                          if (state is SignInSuccessState) {
                                            BlocProvider.of<UserCubit>(context)
                                                .getUserData();
                                            if (state.user.type == 'user') {
                                              context.goNamed(AppRouteConstants
                                                  .bottomBarRoute.name);
                                            } else {
                                              context.goNamed(AppRouteConstants
                                                  .adminBottomBarRoute.name);
                                            }
                                          }
                                          if (state is UpdateUserData) {
                                            BlocProvider.of<UserCubit>(context)
                                                .setUser(state.user);
                                          }
                                        },
                                        builder: (context, state) {
                                          if (state is AuthLoadingState) {
                                            return const Center(
                                              child:
                                              CircularProgressIndicator(),
                                            );
                                          } else {
                                            return CustomElevatedButton(
                                              buttonText: 'Continue',
                                              onPressed: () {
                                                if (_signInFormKey.currentState!
                                                    .validate()) {
                                                  BlocProvider.of<AuthBloc>(
                                                      context)
                                                      .add(SignInPressedEvent(
                                                      _emailController.text,
                                                      _passwordController.text)
                                                  );
                                                }
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }

                    return const SizedBox();
                  },
                ),

                const SizedBox.square(
                  dimension: 20,
                ),
                Divider(
                  color: Colors.grey.shade300,
                  indent: 20,
                  endIndent: 20,
                  thickness: 0.5,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      customTextButton(buttonText: 'Conditions of Use'),
                      customTextButton(buttonText: 'Privacy Notice'),
                      customTextButton(buttonText: 'Help'),
                    ]),
                const Center(
                  child: Text(
                    '© 1996-2023, Amazon.com, Inc. or its affiliates',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox.square(
                  dimension: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextButton customTextButton({String? buttonText}) {
    return TextButton(
      onPressed: () {},
      child: Text(
        buttonText!,
        style: const TextStyle(color: Color(0xff1F72C5), fontSize: 15),
      ),
    );
  }
}
