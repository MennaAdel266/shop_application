import 'package:bloc/bloc.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_application/Layout/shop_layout/shop_screen.dart';
import 'package:shop_application/Modules/Login/cubit/cubit.dart';
import 'package:shop_application/Modules/Login/cubit/states.dart';
import 'package:shop_application/Modules/register/register_screen.dart';
import 'package:shop_application/Shared/Components/components.dart';
import 'package:shop_application/Shared/Components/constants.dart';
import 'package:shop_application/Shared/Network/Local/cache_helper.dart';

class LoginScreen  extends StatelessWidget
{
   var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit() ,
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener:(context, state)
        {
          if(state is ShopLoginSuccessState)
          {
            if(state.loginModel.status)
            {
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              CacheHelper.saveData(
                key: 'token',
                value:state.loginModel.data.token,
              ).then((value)
              {
                token = state.loginModel.data.token;

                navigateAndFinish(
                    context,
                    ShopLayout(),
                );
              });

            }else
              {
                print(state.loginModel.message);

                showToast(
                  text: state.loginModel.message,
                  state: ToastStates.ERROR,
                );
              }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key:formKey ,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormFeild(
                            type: TextInputType.emailAddress,
                            controller: emailController ,
                            prefix: Icons.email_outlined,
                            label: 'E-mail Address',
                            validate: (String value)
                            {
                              if (value.isEmpty)
                              {
                                return 'please enter your email';
                              }
                            }
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormFeild(
                          controller: passwordController,
                          onSubmit: (value)
                          {
                            if(formKey.currentState.validate())
                            {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          iconButton: ()
                          {
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                          suffix: ShopLoginCubit.get(context).suffix,
                          type: TextInputType.visiblePassword,
                          validate: (String value)
                          {
                            if (value.isEmpty)
                            {
                              return 'please enter your password';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                            function: ()
                            {
                              if(formKey.currentState.validate())
                              {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'login' ,
                            isUpperCase: true,
                          ),
                          fallback:(context) => Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account ?',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            defaultTextButton(
                              function:()
                              {
                                navigateTo(
                                  context, RegisterScreen(),
                                );
                              },
                              text:'Register',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } ,

      ),
    );
  }
}
