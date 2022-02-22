import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_application/Layout/shop_layout/shop_cubit/cubit.dart';
import 'package:shop_application/Shared/Cubit/cubit.dart';
import 'package:shop_application/Shared/Styles/colors.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  @required Function function,
  @required String text,
  double raduis = 20.0,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: function,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: background,
      ),
    );

Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>  TextButton(
  onPressed: function,
  child: Text(
      text.toUpperCase(),
  ),
);

Widget defaultFormFeild({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isClickable = true,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  bool isPassword = false,
  Function iconButton,
}) =>
    TextFormField(
      onFieldSubmitted: onSubmit,
      validator: validate,
      onTap: onTap,
      onChanged: onChange,
      enabled: isClickable,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
          icon: Icon(suffix),
          onPressed: iconButton,
        )
            : null,
      ),
    );


Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20,
    end: 20,
  ),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);



void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context, widget) =>
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(
      builder: (context) => widget,
    ),
            (Route<dynamic> route) => false,
    );

void showToast({
  @required String text,
  @required ToastStates state,
}) =>
    Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates {SUCCESS, ERROR, WARNONG}

Color chooseToastColor (ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color =  Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNONG:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget buildListProduct(model, context, {bool isOldPrice = true,} ) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
            if (model.discount != 0 && isOldPrice )
              Container(
                color: Colors.red,
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.3,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    model.price.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if (model.discount != 0 && isOldPrice)
                    Text(
                      model.old_price.toString(),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: ()
                    {
                      ShopCubit.get(context).changeFavorites(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundColor: ShopCubit.get(context).favorites[model.id] ? defaultColor : Colors.grey,
                      child: Icon(
                        Icons.favorite_border,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);