import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_gird/modules/home_screen/home_screen.dart';
import 'package:parking_gird/modules/login/login_screen.dart';
import 'package:parking_gird/modules/register_screen/cubit/register_cubit.dart';
import 'package:parking_gird/shared/components/components.dart';
import 'package:parking_gird/shared/components/constants.dart';
import 'package:parking_gird/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var carLetterController = TextEditingController();
  var carNumberController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is RegisterSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.token);
              CacheHelper.saveData(key: 'token', value: state.loginModel.token,)
                  .then((value) {
                token=state.loginModel.token;
                navigateAndFinish(context, HomeScreen());
              });
              showToastt(msg: state.loginModel.msg, state: ToastStates.SUCCESS);
            } else{
              showToastt(msg: state.loginModel.msg, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff078547),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade900.withOpacity(0.3).withGreen(10),
                              borderRadius: BorderRadius.circular(150)),
                          child: Image.asset(
                            'assets/images/logo_splash.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: defaultFormField(
                                        controller: firstNameController,
                                        type: TextInputType.text,
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return 'Please enter First Name';
                                          }
                                        },
                                        label: 'First Name',
                                        prefix: null),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Flexible(
                                    child: defaultFormField(
                                        controller: lastNameController,
                                        type: TextInputType.text,
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return 'Please enter Last Name';
                                          }
                                        },
                                        label: 'Last Name',
                                        prefix: null),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                  controller: emailController,
                                  type: TextInputType.emailAddress,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'Required Field';
                                    }
                                    if(!value.contains('@')){
                                      return 'Please Enter Valid Email';
                                    }
                                  },
                                  label: 'Email Address',
                                  prefix: null),
                              SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                controller: passwordController,
                                type: TextInputType.text,
                                suffixPressed: () {
                                  RegisterCubit.get(context)
                                      .changePasswordVisibility();
                                },
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'Required Field';
                                  }
                                  if (value.length< 8){
                                    return 'Password at least 8 characters';
                                  }
                                },
                                isPassword:
                                    RegisterCubit.get(context).isPassword,
                                label: 'Password',
                                suffix: RegisterCubit.get(context).suffix,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: defaultFormField(
                                      controller: carLetterController,
                                      type: TextInputType.text,
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return 'Required Field';
                                        }
                                        if(value.length< 2){
                                          return 'Car Letter at least 2 Letters';
                                        }
                                      },
                                      label: 'Car Letter',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Flexible(
                                    child: defaultFormField(
                                      controller: carNumberController,
                                      type: TextInputType.number,
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return 'Required Field';
                                        }
                                        if(value.length< 2){
                                          return 'Car Number at least 2 Numbers';
                                        }
                                      },
                                      label: 'Car Number',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                  controller: phoneController,
                                  type: TextInputType.phone,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'Required Field';
                                    }
                                    if(value.length == 10){
                                      return 'InValid Phone Number';
                                    }
                                  },
                                  label: 'Phone Number',
                                  prefix: null),
                              SizedBox(
                                height: 30,
                              ),
                              ConditionalBuilder(
                                condition: state is! RegisterLoadingState,
                                builder: (context) => defaultButton(
                                  function: () {
                                    if (formKey.currentState.validate()) {
                                      RegisterCubit.get(context).userReister(
                                        firstName: firstNameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                        carNumber: carNumberController.text,
                                        lastName: lastNameController.text,
                                        carLetter: carLetterController.text,
                                      );
                                    }
                                  },
                                  text: 'register',
                                  isUpperCase: true,
                                ),
                                fallback: (context) =>
                                    Center(child: CircularProgressIndicator()),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(' have an account?'),
                                  defaultTextButton(
                                      function: () {
                                        navigateTo(context, LoginScreen());
                                      },
                                      title: 'Login')
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
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
