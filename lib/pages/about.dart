import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:studentresourceapp/components/navDrawer.dart';
import 'package:studentresourceapp/models/user.dart';
import 'package:studentresourceapp/utils/contstants.dart';
import 'package:studentresourceapp/utils/sharedpreferencesutil.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  User userLoad = new User();

  Future fetchUserDetailsFromSharedPref() async {
    var result = await SharedPreferencesUtil.getStringValue(Constants.USER_DETAIL_OBJECT);
    Map valueMap = json.decode(result);
    User user = User.fromJson(valueMap);
    setState(() {
      userLoad = user;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserDetailsFromSharedPref();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(userData: userLoad),
      appBar: AppBar(title: Text('About')),
      body: Padding(
        padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
          child: Column(
            children: [
              Text('ABOUT',
            style: TextStyle(fontSize: 40),),
            SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Text('About The App',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                Text('Hola Friends! We all know the importance of notes given out by the professors and our mighty toppers. Even when the \"Indian guy on YouTube\" fails to get things into our thick brains, it is these notes that come to our rescue. Now what if there was a central place where you would get all the magical notes and material to sail through these examinations, like a complete pro! Fret not, for we present to you, the SemBreaker App. Sounds fun, right? \n',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.justify,),
                SizedBox(height: 20,),
                Text('Features:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Text('1. One place access to all the important notes, study materials and previous year questions papers of the examinations. \n2. Get the material across various semesters & courses.\n3. Download the material that is important to you on your local phone storage.\n4. If you have got the notes you want upload, contact the moderator of the course mentioned in the app.',
                style: TextStyle(
                  fontSize: 15
                ),
                textAlign: TextAlign.justify,),
                SizedBox(height: 20,),
                Text('Contributors:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(),
                    title: Text('Avneesh'),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(),
                    title: Text('Yukta'),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(),
                    title: Text('Pranav'),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(),
                    title: Text('Shourya'),
                  ),
                ),
                
                
              ],),
              SizedBox(height: 50,),
              Text('This app has been made in association with GeekHaven',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, fontStyle: FontStyle.italic),),
            ],
          ),
        ),
      ),
    );
  }
}
