import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:map_flutter/Page/home.dart';
import 'package:map_flutter/Page/resset_password.dart';
import 'package:map_flutter/Page/sign_up.dart';
import 'package:map_flutter/shared/theme.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_fileld.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
  final TextEditingController emailController = TextEditingController(text: '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 166,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/loginbg.png',
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  "Masuk",
                  style: blackTextStyleSB.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                    color: whiteColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            //container putih
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                width: double.infinity,
                height: 600,
                margin: const EdgeInsets.only(top: 100),
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(defauilRadius)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: backgoudColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: CustomTextFormField(
                          title: 'Email',
                          hintText: 'masukkan email',
                          obsrureText: false,
                          controller: emailController,
                          validator: MultiValidator([]),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: backgoudColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: CustomTextFormField(
                          title: 'Password',
                          hintText: 'masukkan password',
                          obsrureText: true,
                          controller: passwordController,
                          validator: MultiValidator([]),
                        ),
                      ),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthSuccess) {
                            // User? user = FirebaseAuth.instance.currentUser;
                            // if (user!.uid == "borwB7T7yphKfJUrG6aTXrCox2z2") {
                            //   Navigator.pushNamedAndRemoveUntil(
                            //       context, '/admin', (route) => false);
                            // } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                            // }
                          } else if (state is AuthFailed) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: redColor,
                                content: Text(state.error),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return CustomButton(
                            title: 'Login',
                            onpressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().signIn(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                              }
                            },
                            fontwidth: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, top: 5),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResetPassword(),
                                ));
                          },
                          child: Text(
                            'Lupa Password ?',
                            style: greyTextStyleSB.copyWith(
                              fontSize: 16,
                              fontWeight: normal,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have  an  account?',
                            style: greyTextStyleSB.copyWith(
                              fontSize: 16,
                              fontWeight: light,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign Up",
                              style: blackTextStyleSB.copyWith(
                                fontSize: 16,
                                fontWeight: normal,
                                color: bluetua,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
