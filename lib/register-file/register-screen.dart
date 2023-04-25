import 'package:firerest/register-file/register-cubit.dart';
import 'package:firerest/register-file/register-states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/submit-button.dart';
import '../widgets/text-form-feild.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener:(context,state){},
        builder: (context,state){
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/logo part 1.png"),
                                        fit: BoxFit.cover)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 30,
                                width: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/logo part 2.png"),
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWidget(
                            textInputType: TextInputType.emailAddress,
                            controller: emailController,
                            hint: "Email",
                            prefixIcon: Icons.email,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWidget(
                            textInputType: TextInputType.phone,
                            controller: passwordController,
                            hint: "password",
                            prefixIcon: Icons.lock,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWidget(
                            textInputType: TextInputType.emailAddress,
                            controller: nameController,
                            hint: "name",
                            prefixIcon: Icons.person,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWidget(
                            textInputType: TextInputType.phone,
                            controller: phoneController,
                            hint: "Phone",
                            prefixIcon: Icons.phone,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SubmitButton(callBack:(){
                              print("object");
                              if(formKey.currentState!.validate()){
                                cubit.userRegister( email: emailController.text,
                                    password: passwordController.text);
                              }
                          }, text: "Sign Up")
                        ]),
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
