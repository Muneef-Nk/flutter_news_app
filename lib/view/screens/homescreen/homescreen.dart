import 'package:flutter/material.dart';
import 'package:news_app/controller/api_data_controller.dart';
import 'package:news_app/controller/saved_news_controller.dart';
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
    Provider.of<DataController>(context, listen: false).fetchNews();
    print('init state');
    super.initState();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataController>(context);

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
          : SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          margin: EdgeInsets.only(left: 15),
                          padding: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                              color: Color(0xfff4f6f9),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: "Search",
                              helperStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none,
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    searchController.text.isNotEmpty
                                        ? Provider.of<DataController>(context,
                                                listen: false)
                                            .fetchNews(
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
                              provider.api?.articles?[57].urlToImage ?? "",
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
                                Provider.of<DataController>(context,
                                        listen: false)
                                    .fetchCategoryNews(
                                        searchQuarry:
                                            provider.categories[index]);

                                provider.changeCategoryIndex(index);
                              },
                              child: Container(
                                height: 30,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  color: provider.selectedCategory == index
                                      ? primary
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: primary, width: 2),
                                ),
                                child: Center(
                                    child: Text(
                                  provider.categories[index],
                                  style: TextStyle(
                                      color: provider.selectedCategory == index
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
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: CircularProgressIndicator(color: primary),
                          ),
                        )
                      : SizedBox(
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: provider.api?.articles?.length ?? 0,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                  index: index,
                                                )));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 20, right: 20, bottom: 20),
                                    height: 140,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 140,
                                          height: 140,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                bottomLeft:
                                                    Radius.circular(20)),
                                            child: Image.network(
                                              provider.api?.articles?[index]
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
                                          width: 190,
                                          // color: Colors.yellowAccent,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              // SizedBox(
                                              //   height: 5,
                                              // ),
                                              Text(
                                                provider.api?.articles?[index]
                                                        .title ??
                                                    "",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    height: 1.4,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
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
                                                            .api
                                                            ?.articles?[index]
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
                                                          '${provider.api?.articles?[index].publishedAt?.year}-',
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.black),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text:
                                                              '${provider.api?.articles?[index].publishedAt?.month}-',
                                                          style: TextStyle(
                                                              fontSize: 11),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              '${provider.api?.articles?[index].publishedAt?.day}',
                                                          style: new TextStyle(
                                                              fontSize: 11),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 3),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        border: Border.all(
                                                            color: primary)),
                                                    child: Text(
                                                      provider.category ??
                                                          "Treding",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                                FontWeight.w500,
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
                                                                  .grey[800])),
                                                    ],
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Provider.of<SavednewController>(
                                                              context,
                                                              listen: false)
                                                          .addNews(index);
                                                    },
                                                    child: Icon(
                                                      Icons.bookmark_outline,
                                                      size: 20,
                                                      color: primary,
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
    );
  }
}
