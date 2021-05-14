import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_gird/modules/home_screen/home_screen.dart';
import 'package:parking_gird/modules/login/cubit/login_cubit.dart';
import 'package:parking_gird/modules/register_screen/register_screen.dart';
import 'package:parking_gird/shared/components/components.dart';
import 'package:parking_gird/shared/components/constants.dart';
import 'package:parking_gird/shared/network/local/cache_helper.dart';
import 'package:parking_gird/shared/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status) {
              CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.token)
                  .then((value) {
                    token=state.loginModel.token;
                navigateAndFinish(context, HomeScreen());
              });
              showToastt(msg:state.loginModel.msg, state: ToastStates.SUCCESS);
            } else {
              showToastt(msg: state.loginModel.msg, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Logo
                        Center(
                          child: Container(
                            child: Image.asset(
                              'assets/images/logo_splash.png',
                              height: 50,
                              width: 50,
                            ),
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(150)),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                defaultFormField(
                                    controller: emailController,
                                    type: TextInputType.emailAddress,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return 'Please enter Your Email Address';
                                      }
                                    },
                                    label: 'Email Address',
                                    prefix: Icons.email_rounded),
                                SizedBox(
                                  height: 20,
                                ),
                                defaultFormField(
                                  controller: passwordController,
                                  type: TextInputType.text,
                                  suffixPressed: () {
                                    LoginCubit.get(context).changePasswordVisibility();
                                  },
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'Password is too short';
                                    }
                                  },
                                  onSubmit: (value) {
                                    if (formKey.currentState.validate()) {
                                      LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  isPassword: LoginCubit.get(context).isPasswordShown,
                                  label: 'Password',
                                  prefix: Icons.lock_outline,
                                  suffix: LoginCubit.get(context).suffix,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ConditionalBuilder(
                                  condition: state is! LoginLoadingState,
                                  builder: (context) => defaultButton(
                                      function: () {
                                        if (formKey.currentState.validate()) {
                                          LoginCubit.get(context).userLogin(
                                              email: emailController.text,
                                              password: passwordController.text);
                                        }
                                      },
                                      text: 'Login',
                                      isUpperCase: true),
                                  fallback: (context) =>
                                      Center(child: CircularProgressIndicator()),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Dont\'t have an account?'),
                                    defaultTextButton(
                                        function: () {
                                          navigateTo(context, RegisterScreen());
                                        },
                                        title: 'Register Now')
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
