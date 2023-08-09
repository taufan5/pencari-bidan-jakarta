import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../shared/theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_fileld.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgoudColor,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 166,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/arrowl.png',
                    ),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 23,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Center(
                        child: Text(
                          'Reset password',
                          style: whiteTextStyleSB.copyWith(
                            fontSize: 20,
                            fontWeight: semiBold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 600,
                      decoration: BoxDecoration(
                        color: backgoudColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 60,
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
                              validator: MultiValidator(
                                [
                                  RequiredValidator(
                                      errorText: "Please enter Topik"),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            title: 'Reset Password',
                            onpressed: () {
                              FirebaseAuth.instance
                                  .sendPasswordResetEmail(
                                      email: emailController.text)
                                  .then((value) => Navigator.pop(context));
                            },
                            fontwidth: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
