//A utility that helps you send email from the app.
//Created by Pranav Singhal

import 'package:url_launcher/url_launcher.dart';

class Email{

  //Email class accepting emailaddress,subject and body of the email
  Email({this.emailaddress,this.subject,this.body});
  String emailaddress;
  String subject;
  String body;
  //A function to launch email intent in the phone.
  void launchEmail() async
  {
    var url="mailto:$emailaddress?subject=$subject&body=$body";
    try {
      if (await canLaunch(url)) {
        await launch(url);
      }
    }
    catch(e){
      print(e.toString());
    }
  }
}
