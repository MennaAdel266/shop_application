import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/Modules/search/Cubit/cubit.dart';
import 'package:shop_application/Modules/search/Cubit/states.dart';
import 'package:shop_application/Shared/Components/components.dart';

class SearchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey <FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey ,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children:
                  [
                    defaultFormFeild(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (value)
                        {
                          if(value.isEmpty)
                          {
                            return 'enter text to search';
                          }
                          return null;
                        },
                        onSubmit: (String text)
                        {
                          SearchCubit.get(context).search(text);
                        },
                        label: 'Search',
                        prefix: Icons.search,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if(state is SearchLoadingStates)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),

                    if(state is SearchSuccessStates)
                      Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildListProduct(SearchCubit.get(context).model.data.data[index], context, isOldPrice: false,),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount:SearchCubit.get(context).model.data.data.length ,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}