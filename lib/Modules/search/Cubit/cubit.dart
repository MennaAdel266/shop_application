import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/Models/shop_app/search_model.dart';
import 'package:shop_application/Modules/search/Cubit/states.dart';
import 'package:shop_application/Shared/Components/constants.dart';
import 'package:shop_application/Shared/Network/Remote/dio_helper.dart';
import 'package:shop_application/Shared/Network/end_points.dart';

class SearchCubit extends Cubit <SearchStates>
{
  SearchCubit() : super(SearchInitialStates());

  static SearchCubit get(context) =>BlocProvider.of(context);

  SearchModel model;

  void search(String text)
  {
    emit(SearchLoadingStates());
    DioHelper.postData (
        url: SEARCH,
        token: token,
        data:
        {
          'text':text,
        },
    ).then((value)
    {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessStates());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorStates());
    });
  }

}