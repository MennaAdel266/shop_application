import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_application/Modules/Login/login_screen.dart';
import 'package:shop_application/Shared/Components/components.dart';
import 'package:shop_application/Shared/Network/Local/cache_helper.dart';
import 'package:shop_application/Shared/Styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel
{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
});
}

class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List <BoardingModel> boarding =[
    BoardingModel(
      image: 'assets/images/onBoarding.jpg',
      title: 'Welcome to our site',
      body: 'Browse to get our hot offers',
    ),
    BoardingModel(
      image: 'assets/images/onBoarding.jpg',
      title: 'Welcome to our site',
      body: 'Browse to get our hot offers',
    ),
    BoardingModel(
      image: 'assets/images/onBoarding.jpg',
      title: 'Welcome to our site',
      body: 'Browse to get our hot offers',
    ),
  ];

  bool isLast = false;
  void submit ()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true,).then((value) {
      if(value)
      {
        navigateAndFinish(context, LoginScreen(),);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function:()
          {
            submit();
          },
          text:'skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children:
          [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: ( int index)
                {
                  if(index == boarding.length - 1)
                  {
                    setState(() {
                      isLast = true;
                    });
                  }else
                    {
                      setState(() {
                        isLast = false;
                      });
                    }
                },
                itemBuilder: (context,index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                  ) ,
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed:()
                  {
                    if(isLast)
                    {
                      submit();
                    }else
                      {
                        boardController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ) ,
                          curve: Curves.fastLinearToSlowEaseIn ,
                        );
                      }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),

          ],
        ),
      ),

    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          '${model.title}',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          '${model.body}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 15,
        ),

      ]
  ) ;   }
