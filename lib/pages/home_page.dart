import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_management_app/pages/control_page.dart';
import 'package:time_management_app/quote/quote_model.dart';
import 'package:time_management_app/values/app_assets.dart';
import 'package:time_management_app/values/app_colors.dart';
import 'package:time_management_app/values/app_styles.dart';
import 'package:time_management_app/widgets/app_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../enlish_today.dart';
import '../quote/quote.dart';
import '../values/share_key.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int curentIndex =0;
 late PageController pageController;
 List<EnglishToday> words =[];
  List<int> fixedListRamdom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }
    List<int> newList = [];

    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }
  getEnglishToday()
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int len = prefs.getInt(ShareKey.counter) ?? 5;
    List<String> newList =[];
    List<int> rans =fixedListRamdom(len: len,max: nouns.length);
    rans.forEach((index) {
      newList.add(nouns[index]);
    });

    setState(() {
      words = newList.map((e) => getQuote(e)).toList();
    });


  }
  EnglishToday getQuote(String noun)
  {
    Quote? quote;
    quote=Quotes().getByWord(noun);
    return EnglishToday(
        noun: noun,
        quote: quote?.content,
        id: quote?.id

    );
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    pageController=PageController(viewportFraction: 0.9);

    super.initState();
    getEnglishToday();
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        title: Text('English today',style: AppStyles.h3.copyWith(color: AppColor.textColor,fontSize: 36),),
        leading: InkWell(
          onTap: (){
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Image.asset(AppAssets.menu),
         ),
      ),
floatingActionButton:FloatingActionButton(
  backgroundColor: AppColor.primaryColor,
  onPressed: (){
    setState(() {
      getEnglishToday();
    });
  },
  child: Image.asset(AppAssets.exchange),


),
      body: Container(
        width: double.infinity,

        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                height: size.height*1/10,
                alignment: Alignment.centerLeft,
                child: Text('"it is amazing how complete is the delusion that beauty that goodness"',
                style: AppStyles.h5.copyWith(fontSize: 12,color: AppColor.textColor,)
                )
            ),
            Container(
              height: size.height*1.8/3,
              child: PageView.builder(

                controller: pageController,
                onPageChanged: (index){
                  setState(() {
                    curentIndex=index;
                  });
                },
                  itemCount: words.length,
                  itemBuilder: (context,index){

                    String firstWord =
                    words[index].noun != null ? words[index].noun!: '';
                    firstWord=firstWord.substring(0,1);
                    String remainingWord =
                    words[index].noun != null ? words[index].noun!: '';
                    remainingWord= remainingWord.substring(1,remainingWord.length);
                    String defautQuote ="thing of all the beauty still left around you and be happy";
                    String quote=words[index].quote !=null ? words[index].quote ! :defautQuote;
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(2,3),
                            blurRadius: 6
                          )
                        ]

                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Image.asset(AppAssets.heart),
                            alignment: Alignment.centerRight,
                            height: 20,

                          ),
                          RichText(
                              text: TextSpan(
                            text: firstWord,
                            style: TextStyle(
                              fontFamily: FontFamily.sen,
                              fontSize: 89,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                BoxShadow(
                                  color: Colors.black38,
                                  offset: Offset(3,6),
                                  blurRadius: 6
                                )
                              ]

                            ),
                            children: [
                              TextSpan(
                                text: remainingWord,
                              style: TextStyle(
                                fontFamily: FontFamily.sen,
                                fontSize: 56,
                                fontWeight: FontWeight.bold,
                              )
                              )
                            ]

                          ),
                         maxLines: 1,
                            overflow:TextOverflow.ellipsis ,
                            textAlign: TextAlign.start,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: AutoSizeText('"$quote"',
                             maxFontSize: 26,
                              minFontSize: 10,
                              maxLines: 4,
                              style:AppStyles.h4.copyWith(color: Colors.black,letterSpacing: 1),
                            ),
                          )
                        ],

                      ),
                    ),
                  );
                  }
                  ),
    

            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                height: size.height*1/15,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 12),


                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context,index)
                  {
                    return buildIndicator(index==curentIndex, size);
                  })
                ),
              ),
            )
          ],
        ),
      ),
drawer:Drawer(
  child: Container(
    color: AppColor.lightBlue,
    child: Column
      (
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24,left: 16),
          child: Text("your mind",
          style: AppStyles.h3.copyWith(color: AppColor.textColor),),
        ),
       Padding(
         padding: const EdgeInsets.symmetric(vertical: 24),
         child: AppButton(label: 'favorite', ontap: () {  },),
       ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: AppButton(label: 'your control', ontap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => ControlPage()));
          },),
        )
      ],
    ),
  ),
),
    );

  }
  Widget buildIndicator(bool isActive, Size size)
  {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    height: 12,
   width: isActive ?size.width*1/5:24,
    decoration: BoxDecoration(
      color: isActive ?AppColor.lightBlue:AppColor.blackGray,
    borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow:[
          BoxShadow(
        color: Colors.black38,
      offset: Offset(2,3),
      blurRadius: 3
    )
        ]
    ),
  );
  }
}
