//A utility that helps you send email from the app.
//Created by Pranav Singhal

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher_platform_interface/method_channel_url_launcher.dart';

class Email{

  void launchEmail(String email) async
  {
    var url="mailto:$email?subject=Feedback/Suggestions regarding SemBreaker App&body=My Feedback/Suggestions for the SemBreaker App are:";
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