import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/Models/shop_app/login_model.dart';
import 'package:shop_application/Modules/register/cubit/states.dart';
import 'package:shop_application/Shared/Network/Remote/dio_helper.dart';
import 'package:shop_application/Shared/Network/end_points.dart';

class ShopRegisterCubit extends Cubit <ShopRegisterStates>
{
  ShopRegisterCubit() : super (ShopRegisterInitialState());

  static ShopRegisterCubit get(context) =>BlocProvider.of(context);

  LoginModel loginModel ;

  void userRegister({
  @required String email,
  @required String name,
  @required String password,
  @required String phone,
})
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        },
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error){
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopChangePasswordState());
  }
}