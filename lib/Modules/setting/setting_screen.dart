import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/Layout/shop_layout/shop_cubit/cubit.dart';
import 'package:shop_application/Layout/shop_layout/shop_cubit/states.dart';
import 'package:shop_application/Layout/shop_layout/shop_screen.dart';
import 'package:shop_application/Shared/Components/components.dart';
import 'package:shop_application/Shared/Components/constants.dart';

class SettingScreen extends StatelessWidget
{
  var formKey = GlobalKey <FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state)
      {

      },
      builder: (context, state)
      {
        var model = ShopCubit.get(context).profileModel;

        nameController.text = model.data.name ;
        emailController.text = model.data.email ;
        phoneController.text = model.data.phone ;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).profileModel != null ,
          builder: (context) =>Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey ,
                child: Column(
                  children:
                  [
                    if(state is ShopLoadingUpdateProfileStates)
                    LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormFeild(
                      controller: nameController ,
                      type: TextInputType.name,
                      validate: (value)
                      {
                        if(value.isEmpty)
                        {
                          return 'You must put your name!';
                        }
                      },
                      label: 'Name',
                      prefix: Icons.person,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormFeild(
                      controller: emailController ,
                      type: TextInputType.emailAddress,
                      validate: (value)
                      {
                        if(value.isEmpty)
                        {
                          return 'You must put your email';
                        }
                      },
                      label: 'E_mail Address',
                      prefix: Icons.email_outlined,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormFeild(
                      controller: phoneController ,
                      type: TextInputType.phone,
                      validate: (value)
                      {
                        if(value.isEmpty)
                        {
                          return 'You must put your phone';
                        }
                      },
                      label: 'Phone',
                      prefix: Icons.phone,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                      function: ()
                      {
                        if(formKey.currentState.validate())
                        {
                          ShopCubit.get(context).updateProfile(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      text: 'Update',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        function: ()
                        {
                          signOut(context);
                        },
                        text: 'Logout',
                    ),
                  ],
                ),
              ),
            ),
          ) ,
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}