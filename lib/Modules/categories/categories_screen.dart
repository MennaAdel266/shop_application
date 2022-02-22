import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/Layout/shop_layout/shop_cubit/cubit.dart';
import 'package:shop_application/Layout/shop_layout/shop_cubit/states.dart';
import 'package:shop_application/Models/shop_app/categories_model.dart';
import 'package:shop_application/Shared/Components/components.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return ListView.separated(
          itemBuilder: (context, index) => buildCatItem(ShopCubit.get(context).categoriesModel.data.data[index]),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: ShopCubit.get(context).categoriesModel.data.data.length,
        ) ;
      },

    );
  }

  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image),
          width:80 ,
          height:80 ,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          model.name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios,
        ),
      ],
    ),
  );

}
