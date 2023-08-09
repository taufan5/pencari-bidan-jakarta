import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_flutter/Page/sign_in.dart';
import 'package:map_flutter/shared/theme.dart';

import '../cubit/auth_cubit.dart';
import '../widgets/custom_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: backgoudColor,
        body: Column(
          children: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccess) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          width: 110,
                          height: 110,
                          margin: const EdgeInsets.only(right: 10, top: 40),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                  image: AssetImage("assets/user.png"))),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 55,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: whiteColor,
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.person),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              "Nama",
                              style: blackTextStyleSB.copyWith(
                                  fontSize: 16, fontWeight: semiBold),
                            ),
                            const Spacer(),
                            Text(
                              state.user.name,
                              style: blackTextStyleSB.copyWith(
                                  fontSize: 16, fontWeight: semiBold),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 55,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: whiteColor,
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.email),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              "Email",
                              style: blackTextStyleSB.copyWith(
                                  fontSize: 16, fontWeight: semiBold),
                            ),
                            Spacer(),
                            Text(
                              state.user.email,
                              style: blackTextStyleSB.copyWith(
                                  fontSize: 16, fontWeight: semiBold),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: redColor,
                      content: Text(state.error),
                    ),
                  );
                } else if (state is AuthInitial) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignIn(),
                      ),
                      (route) => false);
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return CustomButton(
                  title: 'Logout',
                  onpressed: () {
                    context.read<AuthCubit>().signOut();
                  },
                  fontwidth: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
