import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studentresourceapp/utils/contstants.dart';
import 'package:studentresourceapp/utils/unicorndial_edited.dart';

class SubjectsAdmin extends StatefulWidget {
  SubjectsAdmin({this.subjectCode});
  final String subjectCode;
  @override
  _SubjectsAdminState createState() => _SubjectsAdminState();
}

class _SubjectsAdminState extends State<SubjectsAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subjectCode}'),
      ),
      floatingActionButton: UnicornDialer(
        hasNotch: true,
        mainAnimationDuration: 300,
        animationDuration: 230,
        parentButton: Icon(Icons.add_circle_outline),
        finalButtonIcon: Icon(Icons.close),
        childPadding: 12,
        backgroundColor: Colors.white70,
        parentButtonBackground: Constants.DARK_SKYBLUE,
        childButtons: [
          UnicornButton(
            labelText: 'Books',
            labelColor: Colors.black,
            hasLabel: true,
            currentButton: FloatingActionButton(
              heroTag: null,
              mini: true,
              onPressed: () {},
              backgroundColor: Constants.DARK_SKYBLUE,
              child:
                  ImageIcon(AssetImage('assets/svgIcons/book.png'), size: 20),
            ),
          ),
          UnicornButton(
            labelText: 'Important Links',
            labelColor: Colors.black,
            hasLabel: true,
            currentButton: FloatingActionButton(
              heroTag: null,
              mini: true,
              onPressed: () {},
              backgroundColor: Constants.DARK_SKYBLUE,
              child:
                  ImageIcon(AssetImage('assets/svgIcons/link.png'), size: 20),
            ),
          ),
          UnicornButton(
            labelText: 'Material',
            labelColor: Colors.black,
            hasLabel: true,
            currentButton: FloatingActionButton(
              heroTag: null,
              mini: true,
              onPressed: () {},
              backgroundColor: Constants.DARK_SKYBLUE,
              child: Icon(Icons.note_add),
            ),
          ),
          UnicornButton(
            labelText: 'Question Papers',
            labelColor: Colors.black,
            hasLabel: true,
            currentButton: FloatingActionButton(
              heroTag: null,
              mini: true,
              onPressed: () {},
              backgroundColor: Constants.DARK_SKYBLUE,
              child:
                  ImageIcon(AssetImage('assets/svgIcons/pencil.png'), size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
