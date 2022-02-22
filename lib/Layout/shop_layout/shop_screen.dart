import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/Layout/shop_layout/shop_cubit/cubit.dart';
import 'package:shop_application/Layout/shop_layout/shop_cubit/states.dart';
import 'package:shop_application/Modules/Login/login_screen.dart';
import 'package:shop_application/Modules/search/search_screen.dart';
import 'package:shop_application/Shared/Components/components.dart';
import 'package:shop_application/Shared/Network/Local/cache_helper.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Salla',
            ),
            actions: [
              IconButton(
                  onPressed: ()
                  {
                    navigateTo(context, SearchScreen(),);
                  } ,
                  icon: Icon(
                    Icons.search
                  ) ,
              ),
            ],
          ),
           body: cubit.bottomScreens[cubit.currentIndex],
           bottomNavigationBar: BottomNavigationBar(
             onTap: (index)
             {
               cubit.changeBottom(index);
             },
             currentIndex: cubit.currentIndex,
             items: [
               BottomNavigationBarItem(
                 icon: Icon(
                     Icons.home,
                 ),
                 label: 'Home',
               ),
               BottomNavigationBarItem(
                 icon: Icon(
                     Icons.apps_outlined,
                 ),
                 label: 'Categories',
               ),
               BottomNavigationBarItem(
                 icon: Icon(
                     Icons.favorite,
                 ),
                 label: 'Favourite',
               ),
               BottomNavigationBarItem(
                 icon: Icon(
                     Icons.settings,
                 ),
                 label: 'Settings',
               ),
             ],
           ),
        );
      } ,
    );
  }
}
