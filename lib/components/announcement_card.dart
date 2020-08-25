import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class AnnounceCard extends StatelessWidget {
  final String date,title,message,url;

  AnnounceCard({this.date,this.title,this.message,this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(title,style: TextStyle(fontSize: 22,
                      fontWeight: FontWeight.bold),),
                    ),
                    Flexible(child: Text(date,style: TextStyle(fontSize: 12,
                    fontWeight: FontWeight.bold)))
                  ],
                ),
                Divider(height: 20,color: Colors.black,),
                Text(message,style: TextStyle(fontSize: 18,
                    fontWeight: FontWeight.w500)),
                url!=null?GestureDetector(
                  onTap: () async
                  {
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                  throw 'Could not launch $url';
                  }
                  },
                  child: Text(url,style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.w500,fontStyle: FontStyle.italic,color: Colors.blue),),
                ):Container()

              ],
            ),
          ),
        ),
      ),
    );
  }
}