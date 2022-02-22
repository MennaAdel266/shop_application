import 'package:shop_application/Modules/Login/login_screen.dart';
import 'package:shop_application/Shared/Components/components.dart';
import 'package:shop_application/Shared/Network/Local/cache_helper.dart';

void signOut (context)
{
  CacheHelper.removeData(key: 'token',).then((value)
  {
    if(value)
    {
      navigateAndFinish(context, LoginScreen(),);
    }
  });
}

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';