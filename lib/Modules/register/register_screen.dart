import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/Layout/shop_layout/shop_screen.dart';
import 'package:shop_application/Modules/register/cubit/cubit.dart';
import 'package:shop_application/Modules/register/cubit/states.dart';
import 'package:shop_application/Shared/Components/components.dart';
import 'package:shop_application/Shared/Components/constants.dart';
import 'package:shop_application/Shared/Network/Local/cache_helper.dart';

class RegisterScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override

  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit() ,
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener:(context, state)
        {
          if(state is ShopRegisterSuccessState)
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
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey ,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormFeild(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value)
                          {
                            if(value.isEmpty)
                            {
                              return 'please enter your name';
                            }
                          },
                          label: ' User name',
                          prefix: Icons.person_outline,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormFeild(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value)
                          {
                            if(value.isEmpty)
                            {
                              return 'please enter your email';
                            }
                          },
                          label: 'E_mail Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormFeild(
                          controller: passwordController,
                          onSubmit: (value)
                          {
                          },
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          iconButton: ()
                          {
                            ShopRegisterCubit.get(context).changePasswordVisibility();
                          },
                          suffix: ShopRegisterCubit.get(context).suffix,
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
                          height: 15,
                        ),
                        defaultFormFeild(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value)
                          {
                            if(value.isEmpty)
                            {
                              return 'please enter your phone';
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: ()
                            {
                              if(formKey.currentState.validate())
                              {
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'Register' ,
                            isUpperCase: true,
                          ),
                          fallback:(context) => Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ) ;
        } ,

      ),
    );
  }
}
