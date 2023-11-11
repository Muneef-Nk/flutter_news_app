import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/controller/homescreen_controller.dart';
import 'package:news_app/controller/saved_news_controller.dart';
import 'package:news_app/model/saved_news_model.dart';
import 'package:news_app/view/screens/details_screen/details_screen.dart';
import 'package:provider/provider.dart';

import '../../../utils/color_constant.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    Provider.of<HomescreenController>(context, listen: false).fetchNews();
    print('init state');
    super.initState();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomescreenController>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("News App",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25)),
        actions: [
          Container(
            margin: EdgeInsets.all(10),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: light, borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Icons.notifications,
              color: primary,
            ),
          ),
        ],
      ),
      body: provider.isMainLoading
          ? Center(
              child: CircularProgressIndicator(
                color: primary,
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {
                provider.fetchNews();
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              // margin: EdgeInsets.only(left: 15),
                              // padding: EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                  color: Color(0xfff4f6f9),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextField(
                                  controller: searchController,
                                  decoration: InputDecoration(
                                    hintText: "Search",
                                    helperStyle: TextStyle(color: Colors.black),
                                    border: InputBorder.none,
                                    suffixIcon: GestureDetector(
                                        onTap: () {
                                          searchController.text.isNotEmpty
                                              ? Provider.of<
                                                          HomescreenController>(
                                                      context,
                                                      listen: false)
                                                  .fetchCategoryNews(
                                                      searchQuarry:
                                                          searchController.text)
                                              : null;

                                          provider.selectedCategory = 100;
                                        },
                                        child: SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: Icon(Icons.search))),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: light,
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(
                              Icons.filter_list,
                              color: primary,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Featured",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "See all",
                              style: TextStyle(
                                  color: primary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        width: double.infinity,
                        height: 190,
                        decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            image: DecorationImage(
                                image: NetworkImage(
                                  provider.dataModel?.articles?[77]
                                          .urlToImage ??
                                      "",
                                ),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "News",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "See all",
                              style: TextStyle(
                                  color: primary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        height: 30,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.categories.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Provider.of<HomescreenController>(context,
                                            listen: false)
                                        .fetchCategoryNews(
                                            searchQuarry:
                                                provider.categories[index]);
                                    Provider.of<HomescreenController>(context,
                                            listen: false)
                                        .changeCategoryIndex(index);

                                    searchController.text = "";
                                  },
                                  child: Container(
                                    height: 30,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    decoration: BoxDecoration(
                                      color: provider.selectedCategory == index
                                          ? primary
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border:
                                          Border.all(color: primary, width: 2),
                                    ),
                                    child: Center(
                                        child: Text(
                                      provider.categories[index],
                                      style: TextStyle(
                                          color:
                                              provider.selectedCategory == index
                                                  ? Colors.white
                                                  : primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    )),
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      provider.isDataLoading
                          ? Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Lottie.asset(
                                  "assets/animation/loading.json",
                                  width: 200),
                            )
                          : SizedBox(
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      provider.dataModel?.articles?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                      index: index,
                                                    )));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        padding: EdgeInsets.only(right: 10),
                                        height: 140,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.grey.shade300),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              height: 140,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20)),
                                                child: Image.network(
                                                  provider
                                                          .dataModel
                                                          ?.articles?[index]
                                                          .urlToImage ??
                                                      "",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.43,
                                              child: Column(
                                                // crossAxisAlignment:
                                                //     CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  // SizedBox(
                                                  //   height: 5,
                                                  // ),
                                                  Text(
                                                    provider
                                                            .dataModel
                                                            ?.articles?[index]
                                                            .title ??
                                                        "",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        height: 1.4,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                  // SizedBox(
                                                  //   height: 8,
                                                  // ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.copyright,
                                                        color: Colors.grey,
                                                        size: 18,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        provider
                                                                .dataModel
                                                                ?.articles?[
                                                                    index]
                                                                .source
                                                                ?.name ??
                                                            "",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                          text:
                                                              '${provider.dataModel?.articles?[index].publishedAt?.year}-',
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              color:
                                                                  Colors.black),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text:
                                                                  '${provider.dataModel?.articles?[index].publishedAt?.month}-',
                                                              style: TextStyle(
                                                                  fontSize: 11),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  '${provider.dataModel?.articles?[index].publishedAt?.day}',
                                                              style:
                                                                  new TextStyle(
                                                                      fontSize:
                                                                          11),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 3),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            border: Border.all(
                                                                color:
                                                                    primary)),
                                                        child: Text(
                                                          provider.category ??
                                                              "Trending",
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: primary),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  // SizedBox(height: 10,),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.thumb_up,
                                                            size: 15,
                                                            color: primary,
                                                          ),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text(
                                                            "22k",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .grey[800]),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Icon(
                                                            Icons.comment,
                                                            size: 15,
                                                            color: primary,
                                                          ),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text("22k",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                          .grey[
                                                                      800])),
                                                        ],
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Provider.of<SavedNewsController>(context, listen: false).checkNewsSavedOrNot(SavedNewsModel(
                                                              category: provider.categories[
                                                                  index],
                                                              description: provider
                                                                      .dataModel
                                                                      ?.articles?[
                                                                          index]
                                                                      .description ??
                                                                  "",
                                                              image: provider
                                                                      .dataModel
                                                                      ?.articles?[
                                                                          index]
                                                                      .urlToImage ??
                                                                  "",
                                                              source: provider
                                                                      .dataModel
                                                                      ?.articles?[index]
                                                                      .source
                                                                      ?.name ??
                                                                  "",
                                                              title: provider.dataModel?.articles?[index].title ?? ""));
                                                        },
                                                        child: Provider.of<
                                                                        SavedNewsController>(
                                                                    context)
                                                                .isSaved
                                                            ? Icon(
                                                                Icons.bookmark,
                                                                size: 20,
                                                                color: primary,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .bookmark_outline,
                                                                color: primary,
                                                                size: 20,
                                                              ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
