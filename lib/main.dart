import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/Layout/shop_layout/shop_cubit/cubit.dart';
import 'package:shop_application/Layout/shop_layout/shop_screen.dart';
import 'package:shop_application/Modules/Login/login_screen.dart';
import 'package:shop_application/Modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_application/Shared/Components/constants.dart';
import 'package:shop_application/Shared/Cubit/cubit.dart';
import 'package:shop_application/Shared/Cubit/states.dart';
import 'package:shop_application/Shared/Network/Local/cache_helper.dart';
import 'package:shop_application/Shared/Network/Remote/dio_helper.dart';
import 'package:shop_application/Shared/Styles/Themes.dart';
import 'package:shop_application/Shared/bloc_observer.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);

  if( onBoarding != null)
  {
    if(token != null) widget = ShopLayout();
    else widget = LoginScreen();
  } else
    {
      widget = OnBoardingScreen();
    }




  runApp(MyApp(
    isDark: isDark,
    startWidget: widget ,
  ));
}

//class MyApp
class MyApp extends StatelessWidget
{
  final bool isDark;
  final Widget startWidget;

  MyApp({
    this.isDark,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider( create: (BuildContext context) => AppCubit()..changeAppMode(
          fromShared: isDark,
        ), ),
        BlocProvider( create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getProfile(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, states){},
        builder: (context, states){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme ,
            darkTheme:darkTheme ,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget ,
          );
        },
      ),
    );
  }
}

