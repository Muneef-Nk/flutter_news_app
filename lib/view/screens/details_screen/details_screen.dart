import 'package:flutter/material.dart';
import 'package:news_app/controller/api_data_controller.dart';
import 'package:news_app/utils/color_constant.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  final int index;
  DetailScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: primary,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Share.share(provider.api?.articles?[index].url ?? "");
              print('clicked');
            },
            child: Container(
              margin: EdgeInsets.all(10),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: light, borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.share,
                color: primary,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: light, borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Icons.bookmark_outline,
              color: primary,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: light, borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Icons.more_vert,
              color: primary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: EdgeInsets.all(15),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                image: DecorationImage(
                    image: NetworkImage(
                      provider.api?.articles?[index].urlToImage ?? "",
                    ),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(20)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              provider.api?.articles?[index].title ?? "",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: primary)),
                  child: Text(
                    provider.category ?? "",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primary),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.remove_red_eye,
                  size: 20,
                  color: primary,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "123.9k",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.thumb_up,
                  size: 20,
                  color: primary,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("340.5k",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.comment,
                  size: 20,
                  color: primary,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("120.6k",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.api?.articles?[index].source?.name ?? "",
                          style: TextStyle(
                            fontSize: 18,
                            color: primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '${provider.api?.articles?[index].publishedAt?.day} day ago',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 30,
                  decoration: BoxDecoration(
                      color: primary, borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "follow",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              provider.api?.articles?[index].content ?? "",
              style:
                  TextStyle(fontSize: 16, color: Colors.grey[900], height: 1.4),
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: TextButton(
                onPressed: () async {
                  final weburl = provider.api?.articles?[index].url ?? "";
                  final url = Uri.parse(weburl);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    );
                    throw Exception('Could not launch $url');
                  }
                },
                child: Text("Read more")),
          )
        ]),
      ),
    );
  }
}
