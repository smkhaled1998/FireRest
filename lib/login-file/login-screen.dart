import 'package:firerest/screens/home-layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../register-file/register-screen.dart';
import '../reusable-widgets/small-text.dart';
import '../styles/app-colors.dart';
import '../reusable-widgets/submit-button.dart';
import '../reusable-widgets/text-form-feild.dart';
import 'login-cubit.dart';
import 'login-states.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey =GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginState>(
        listener: (context,state){
          if (state is LoginSuccessState){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>const HomeLayout()));
          }
        },
        builder: (context,state){
          var cubit = LoginCubit.get(context);
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
                                height: 200,
                                width: 200,
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
                            suffixIcon: cubit.isSeen? Icons.remove_red_eye_outlined:Icons.visibility_off_outlined,
                            callBack: cubit.changeVisibility,
                            secure: !cubit.isSeen,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SubmitButton(callBack: () {
                            if (formKey.currentState!.validate()){
                              cubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text
                              );
                            }
                          }, text: "Login"),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SmallText(text: "Don't have an account",),
                              TextButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen()));
                                  },
                                  child: Text('Sign Up',style: TextStyle(color: AppColor.mainColor),))
                            ],)
                        ]),
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
