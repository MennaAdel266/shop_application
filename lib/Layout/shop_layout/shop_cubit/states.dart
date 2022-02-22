import 'package:shop_application/Models/shop_app/change_favorites_model.dart';
import 'package:shop_application/Models/shop_app/login_model.dart';

abstract class ShopStates {}

class ShopInitialStates extends ShopStates {}

class ShopChangeBottomNavStates extends ShopStates {}

class ShopLoadingHomeDataStates extends ShopStates {}

class ShopSuccessHomeDataStates extends ShopStates {}

class ShopErrorHomeDataStates extends ShopStates {}

class ShopSuccessCategoriesStates extends ShopStates {}

class ShopErrorCategoriesStates extends ShopStates {}

class ShopChangeFavoritesStates extends ShopStates {}

class ShopSuccessFavoritesStates extends ShopStates
{
  final ChangeFavoritesModel model;

  ShopSuccessFavoritesStates(this.model);
}

class ShopErrorFavoritesStates extends ShopStates {}

class ShopLoadingGetFavoritesStates extends ShopStates {}

class ShopSuccessGetFavoritesStates extends ShopStates {}

class ShopErrorGetFavoritesStates extends ShopStates {}

class ShopLoadingGetProfileStates extends ShopStates {}

class ShopSuccessGetProfileStates extends ShopStates
{
  final LoginModel loginModel ;

  ShopSuccessGetProfileStates(this.loginModel);
}

class ShopErrorGetProfileStates extends ShopStates {}

class ShopLoadingUpdateProfileStates extends ShopStates {}

class ShopSuccessUpdateProfileStates extends ShopStates
{
  final LoginModel loginModel ;

  ShopSuccessUpdateProfileStates(this.loginModel);
}

class ShopErrorUpdateProfileStates extends ShopStates {}