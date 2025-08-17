import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/app_colors.dart' as AppColors;
import 'package:music_app/my_tabs.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List? popularBooks;
  List? slide;
  List? NewBook;
  List? Trend;
  late ScrollController _scrollController;
  late TabController _tabController;

  // List<String> images = [
  //   "img/project.jpeg",
  //   "img/book1.jpeg",
  //   "img/book2.jpeg",
  //   "img/book3.jpeg",
  //   "img/book4.jpeg"
  // ];

  void ReadData() async {
    await DefaultAssetBundle.of(context).loadString("json/PopularBooks.json").then((s) {
      setState(() {
        popularBooks = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context).loadString("json/Slide.json").then((s) {
      setState(() {
        slide = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context).loadString("json/NewBook.json").then((s) {
      setState(() {
        NewBook = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context).loadString("json/Trending.json").then((s) {
      setState(() {
        Trend = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.window, size: 24, color: Colors.black),
                    Row(
                      children: [
                        Icon(Icons.search, size: 24, color: Colors.black),
                        SizedBox(width: 10),
                        Icon(
                          Icons.notifications_active,
                          size: 24,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Popular Books",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 180,
                        child: PageView.builder(
                          controller: PageController(viewportFraction: 0.8),
                          itemCount: slide == null
                              ? 0
                              : slide?.length,
                          itemBuilder: (_, i) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage(slide?[i]["img"]),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (BuildContext context, bool isScroll) {
                    return [
                      SliverAppBar(
                        backgroundColor: AppColors.sliverBackground,
                        pinned: true,
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(50),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20, left: 10),
                            child: TabBar(
                              tabs: [
                                Apptabs(
                                  color: AppColors.menu1Color,
                                  text: "New",
                                ),
                                Apptabs(
                                  color: AppColors.menu2Color,
                                  text: "Popular",
                                ),
                                Apptabs(
                                  color: AppColors.menu3Color,
                                  text: "Trending",
                                ),
                              ],
                              indicatorPadding: const EdgeInsets.all(0),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding: const EdgeInsets.only(right: 10),
                              controller: _tabController,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey.withOpacity(0.2),
                                //     blurRadius: 7,
                                //     offset: Offset(0, 0),
                                //   )
                                // ]
                              ),
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                          itemCount: NewBook==null?0:NewBook?.length,
                          itemBuilder: (_,i){
                            return Container(
                              margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.tabVarViewColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 11,
                                        offset: Offset(0, 0),
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                    ]
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(21),
                                          image: DecorationImage(image: AssetImage(NewBook?[i]["img"])),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.star,size: 24,color: AppColors.starColor,),
                                              SizedBox(width: 5,),
                                              Text(NewBook?[i]["rating"],style: TextStyle(color: AppColors.menu2Color),),
                                            ],
                                          ),
                                          Text(NewBook?[i]["title"],style: TextStyle(fontSize: 16,fontFamily: "Avenir",fontWeight: FontWeight.bold),),
                                          Text(NewBook?[i]["text"],style: TextStyle(fontSize: 16,fontFamily: "Avenir",color: AppColors.subTitleText),),
                                          Container(
                                            width: 55,
                                            height: 15,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: AppColors.loveColor,
                                            ),
                                            child:Center(child: Text("Love",style: TextStyle(fontSize: 12,fontFamily: "Avenir",fontWeight: FontWeight.bold,color: Colors.white),)),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                      ListView.builder(
                          itemCount: popularBooks==null?0:popularBooks?.length,
                          itemBuilder: (_,i){
                            return Container(
                              margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.tabVarViewColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 11,
                                        offset: Offset(0, 0),
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                    ]
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(21),
                                          image: DecorationImage(image: AssetImage(popularBooks?[i]["img"])),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.star,size: 24,color: AppColors.starColor,),
                                              SizedBox(width: 5,),
                                              Text(popularBooks?[i]["rating"],style: TextStyle(color: AppColors.menu2Color),),
                                            ],
                                          ),
                                          Text(popularBooks?[i]["title"],style: TextStyle(fontSize: 16,fontFamily: "Avenir",fontWeight: FontWeight.bold),),
                                          Text(popularBooks?[i]["text"],style: TextStyle(fontSize: 16,fontFamily: "Avenir",color: AppColors.subTitleText),),
                                          Container(
                                            width: 55,
                                            height: 15,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: AppColors.loveColor,
                                            ),
                                            child:Center(child: Text("Love",style: TextStyle(fontSize: 12,fontFamily: "Avenir",fontWeight: FontWeight.bold,color: Colors.white),)),

                                          )

                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                      ListView.builder(
                          itemCount: Trend==null?0:Trend?.length,
                          itemBuilder: (_,i){
                            return Container(
                              margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.tabVarViewColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 11,
                                        offset: Offset(0, 0),
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                    ]
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(21),
                                          image: DecorationImage(image: AssetImage(Trend?[i]["img"])),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.star,size: 24,color: AppColors.starColor,),
                                              SizedBox(width: 5,),
                                              Text(Trend?[i]["rating"],style: TextStyle(color: AppColors.menu2Color),),
                                            ],
                                          ),
                                          Text(Trend?[i]["title"],style: TextStyle(fontSize: 16,fontFamily: "Avenir",fontWeight: FontWeight.bold),),
                                          Text(Trend?[i]["text"],style: TextStyle(fontSize: 16,fontFamily: "Avenir",color: AppColors.subTitleText),),
                                          Container(
                                            width: 55,
                                            height: 15,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: AppColors.loveColor,
                                            ),
                                            child:Center(child: Text("Love",style: TextStyle(fontSize: 12,fontFamily: "Avenir",fontWeight: FontWeight.bold,color: Colors.white),)),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
