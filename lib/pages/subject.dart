import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studentresourceapp/pages/web.dart';


class Subject extends StatefulWidget {
  Subject({this.semester, this.subjectCode});
  final int semester;
  final String subjectCode;

  @override

  _SubjectState createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {
  @override
  void initState() {
    super.initState();
  }
  void showFancyCustomDialog(BuildContext context) {
    Dialog fancyDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
//        height: te,
//        width: 300.0,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Expanded(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Text(
                      "Recommended Books:",
                    style: TextStyle(
                      fontSize: 23,
                    ),
                  ),
                ),
              ),
            ),
            Card(

              child: StreamBuilder(

                stream: Firestore.instance
                    .collection('Subjects')
                    .document('${widget.semester}_${widget.subjectCode}')
                    .snapshots(),
                builder: (context,snapshot){
                  List<ListItem> messageWidget=[];
                  if(snapshot.hasData)
                  {

                    List RecBooks=snapshot.data['Recommended Books'];
                    print(RecBooks);

                    for(int i=0;i<RecBooks.length;i++)
                    {
                      final author=RecBooks[i]['Author'];
                      final booktitle=RecBooks[i]['BookTitle'];
                      final publication=RecBooks[i]['Publication'];

//

                      ListItem lis=ListItem
                          (heading: 'Author:',
                          subheaading: author);



                      messageWidget.add(lis);

                      lis=ListItem(heading: 'Titile:',subheaading: booktitle);
                      messageWidget.add(lis);


                      lis=ListItem(heading: 'Publication:',subheaading: publication);

                      messageWidget.add(lis);
                    }
                  }
                  return Expanded(
                    child: ListView(
//                    shrinkWrap: true,

                      children: messageWidget,
                    ),
                  )
                  ;
                },
              ),
            ),
            Expanded(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Text(
                      "Moderators:"
                  ),
                ),
              ),
            ),
            StreamBuilder(

              stream: Firestore.instance
                  .collection('Subjects')
                  .document('${widget.semester}_${widget.subjectCode}')
                  .snapshots(),
              builder: (context,snapshot){
                List<ListItem> messageWidget=[];
                if(snapshot.hasData)
                {

                  List mod=snapshot.data['MODERATORS'];
                  print(mod);
                  for(int i=0;i<mod.length;i++)
                  {
                    final ctnum=mod[i]['Contact Number'];
                    final name=mod[i]['Name'];


                    ListItem lis=ListItem(heading: 'Name:',subheaading: name);


                    messageWidget.add(lis);

                    lis=ListItem(heading: 'Contact:',subheaading: ctnum);
                    messageWidget.add(lis);

                  }

                }
                return Expanded(
                  child: ListView(

                    children: messageWidget,
                  ),
                )
                ;
              },
            ),


               new RaisedButton(
//                 elevation: 5,

                  child:new Text('Okay'),
                  onPressed: (){
                    Navigator.of(context, rootNavigator: true).pop();
              }),


          ],


        ),

      ),

    );

    showDialog(
        context: context, builder: (BuildContext context) => fancyDialog);
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.subjectCode}'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.info_outline), onPressed:(){


              setState(() {

                showFancyCustomDialog(context);

              });


            },)
          ],
          bottom: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.note),
              text: 'Material',

            ),
            Tab(
              icon: Icon(Icons.edit),
              text: 'Q-Paper',
            ),
            Tab(
              icon: Icon(Icons.link),
              text: 'Imp. Links',
            )
          ]),
        ),
        body: TabBarView(
          children: [
            StreamWidget(
              widget: widget,
              typeKey: 'Material',
            ),
            StreamWidget(
              widget: widget,
              typeKey: 'QuestionPapers',
            ),
            StreamWidget(
              widget: widget,
              typeKey: 'Important Links',
            ),
          ],
        ),
      ),
    );
  }
}

class StreamWidget extends StatelessWidget {
  const StreamWidget({Key key, @required this.widget, @required this.typeKey})
      : super(key: key);

  final Subject widget;
  final String typeKey;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('Subjects')
          .document('${widget.semester}_${widget.subjectCode}')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (typeKey == 'Material') {
            List materialData = snapshot.data['Material'];
            print(materialData.toString());
            List<Widget> listMaterials = [];
            materialData.forEach((element) {
              listMaterials.add(
                Card(
                  child: ListTile(
                    title: Text(element['Title']),
                    leading: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  Web(url: element['Content URL'])));
                        }),
                    trailing: IconButton(
                        icon: Icon(Icons.file_download), onPressed: null),
                  ),
                ),
              );
            });
            return Container(child: ListView(children: listMaterials));
          } else if (typeKey == 'QuestionPapers') {
            List materialData = snapshot.data['QuestionPapers'];
            print(materialData.toString());
            List<Widget> listMaterials = [];
            materialData.forEach((element) {
              listMaterials.add(
                Card(
                  child: ListTile(
                    title: Text(element['Title']),
                    subtitle: Text(element['Type'] + '-' + element['Year']),
                    leading: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Web(url: element['URL'])));
                        }),
                    trailing: IconButton(
                        icon: Icon(Icons.file_download), onPressed: null),
                  ),
                ),
              );
            });
            return Container(child: ListView(children: listMaterials));
          } else if (typeKey == 'Important Links') {
            List materialData = snapshot.data['Important Links'];
            print(materialData.toString());
            List<Widget> listMaterials = [];
            materialData.forEach((element) {
              listMaterials.add(
                Card(
                  child: ListTile(
                    title: Text(element['Title']),
                    trailing: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  Web(url: element['Content URL'])));
                        }),
                  ),
                ),
              );
            });
            return Container(child: ListView(children: listMaterials));
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}


class ListItem extends StatelessWidget {
  @override

  ListItem({this.heading,this.subheaading});

  String heading;
  String subheaading;

  Widget build(BuildContext context) {

    return Padding(

      padding: EdgeInsets.all(5.0),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [

          Text(
              heading
          ),

          Text(
              subheaading
          ),
        ],

      ),
    );

  }
}
/*

Container(
          child: StreamBuilder(
            stream: Firestore.instance
                .collection('Subjects')
                .document('${widget.semester}_${widget.subjectCode}')
                .snapshots(),
            builder: (context, snapshot) {
              return Text(snapshot.data['MODERATORS'].toString());
            },
          ),
        ),
*/
