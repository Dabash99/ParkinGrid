import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_gird/layout/cubit/app_cubit.dart';
import 'package:parking_gird/modules/home_screen/cubit/home_cubit.dart';
import 'package:parking_gird/shared/components/components.dart';

class EditAccountScreen extends StatelessWidget {
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
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var userDataModel = AppCubit.get(context).loginModel;
        passwordController.text ;
        firstNameController.text = userDataModel.firstName;
        lastNameController.text = userDataModel.lastName;
        emailController.text = userDataModel.email;
        carLetterController.text = userDataModel.carLetter;
        carNumberController.text = userDataModel.carNumber;
        phoneController.text = userDataModel.phoneNumber;
        return Scaffold(

          appBar: customAppBar(title: 'Edit Account'),
          drawer: customDrawer(context),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ConditionalBuilder(
                  condition: AppCubit.get(context).loginModel != null,
                  builder: (context)=> SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height:20,),
                          Center(
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(150)),
                              child: Image.asset(
                                'assets/images/logo_splash.png',
                                height: 40,
                                width: 40,
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
                                      },
                                      label: 'Email Address',
                                      prefix: null),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  defaultFormField(
                                    controller: passwordController,
                                    type: TextInputType.text,
                                    validate: (String value) {},
                                    label: 'Password',
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
                                      },
                                      label: 'Phone Number',
                                      prefix: null),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  ConditionalBuilder(
                                    condition: state is! LoadingUpdateUserDataState,
                                    builder: (context) => defaultButton(
                                        text: 'update',
                                        function: () {
                                          if (formKey.currentState.validate()) {
                                              AppCubit.get(context).updateUserData(
                                                  firstname: firstNameController.text,
                                                  lastname: lastNameController.text,
                                                  email: emailController.text,
                                                  password: passwordController.text,
                                                  carLetter: carLetterController.text,
                                                  carnumber: carNumberController.text,
                                                  phoneNumber: phoneController.text
                                              );
                                          }
                                        }),
                                    fallback: (context) => Center(
                                      child:LinearProgressIndicator(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  fallback: (context)=>Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
