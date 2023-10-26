import 'package:flutter/material.dart';
import 'package:news_app/controller/api_data_controller.dart';
import 'package:news_app/controller/saved_news_controller.dart';
import 'package:news_app/utils/color_constant.dart';
import 'package:provider/provider.dart';

class SavedNews extends StatelessWidget {
  const SavedNews({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataController>(context);
    final savedNewsProvider = Provider.of<SavednewController>(context);

    return Scaffold(
      body: ListView.builder(
          itemCount: savedNewsProvider.savedNews.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
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
                          bottomLeft: Radius.circular(20)),
                      child: Image.network(
                        provider.api?.articles?[index].urlToImage ?? "",
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // SizedBox(
                        //   height: 5,
                        // ),
                        Text(
                          provider.api?.articles?[index].title ?? "",
                          style: TextStyle(
                              fontSize: 15,
                              height: 1.4,
                              fontWeight: FontWeight.bold),
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
                              provider.api?.articles?[index].source?.name ?? "",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12),
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
                                    fontSize: 11, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        '${provider.api?.articles?[index].publishedAt?.month}-',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                  TextSpan(
                                    text:
                                        '${provider.api?.articles?[index].publishedAt?.day}',
                                    style: new TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: primary)),
                              child: Text(
                                provider.category ?? "Treding",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: primary),
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[800]),
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
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[800])),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Provider.of<SavednewController>(context,
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
            );
          }),
    );
  }
}
