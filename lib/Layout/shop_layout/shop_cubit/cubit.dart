import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/Layout/shop_layout/shop_cubit/states.dart';
import 'package:shop_application/Models/shop_app/categories_model.dart';
import 'package:shop_application/Models/shop_app/change_favorites_model.dart';
import 'package:shop_application/Models/shop_app/favorites_model.dart';
import 'package:shop_application/Models/shop_app/home_model.dart';
import 'package:shop_application/Models/shop_app/login_model.dart';
import 'package:shop_application/Modules/categories/categories_screen.dart';
import 'package:shop_application/Modules/favourite/favourite_screen.dart';
import 'package:shop_application/Modules/products/products_screen.dart';
import 'package:shop_application/Modules/setting/setting_screen.dart';
import 'package:shop_application/Shared/Components/constants.dart';
import 'package:shop_application/Shared/Network/Remote/dio_helper.dart';
import 'package:shop_application/Shared/Network/end_points.dart';

class ShopCubit extends Cubit <ShopStates>
{
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens =
  [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingScreen(),
  ];

  void changeBottom (int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavStates());
  }

  HomeModel homeModel;

  Map<int, bool> favorites = {};

  void getHomeData ()
  {
    emit(ShopLoadingHomeDataStates());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);

      print(homeModel.data.banners[0].image);
      print(homeModel.status);

      homeModel.data.products.forEach((element)
      {
        favorites.addAll(
            {
              element.id: element.in_favorites,
            });
      });

      print(favorites.toString());

      emit(ShopSuccessHomeDataStates());
    }).catchError((error){
      emit(ShopErrorHomeDataStates());
    });

  }

  CategoriesModel categoriesModel;

  void getCategories ()
  {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesStates());
    }).catchError((error){
      emit(ShopErrorCategoriesStates());
    });

  }

  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId)
  {
    favorites[productId] = !favorites[productId];
    emit(ShopChangeFavoritesStates());

    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id':productId
        } ,
      token: token,
    ).then((value)
    {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if(!changeFavoritesModel.status)
      {
        favorites[productId] = !favorites[productId];
      }else
      {
        getFavorites();
      }

      emit(ShopSuccessFavoritesStates(changeFavoritesModel));
    }
    ).catchError((error)
    {
      favorites[productId] = !favorites[productId];
      emit(ShopErrorFavoritesStates());
    });
  }

  FavoritesModel favoritesModel;

  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesStates());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value.data);
      printFullText(value.data.toString());

      emit(ShopSuccessGetFavoritesStates());
    }).catchError((error){
      emit(ShopErrorGetFavoritesStates());
    });

  }


  LoginModel profileModel;

  void getProfile()
  {
    emit(ShopLoadingGetProfileStates());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value)
    {
      profileModel = LoginModel.fromJson(value.data);
      printFullText(profileModel.data.name);

      emit(ShopSuccessGetProfileStates(profileModel));
    }).catchError((error){
      emit(ShopErrorGetProfileStates());
    });

  }

  void updateProfile({
  @required String name,
  @required String email,
  @required String phone,
})
  {
    emit(ShopLoadingUpdateProfileStates());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data:
      {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value)
    {
      profileModel = LoginModel.fromJson(value.data);
      printFullText(profileModel.data.name);

      emit(ShopSuccessUpdateProfileStates(profileModel));
    }).catchError((error){
      emit(ShopErrorUpdateProfileStates());
    });

  }


}