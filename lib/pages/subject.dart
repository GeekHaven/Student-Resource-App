import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:studentresourceapp/components/custom_loader.dart';
import 'package:studentresourceapp/pages/pdf.dart';
import 'package:studentresourceapp/utils/unicorndial_edited.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import '../utils/contstants.dart';

class CallService {
  void call(String number) => launch("tel:$number");
}

GetIt locator = GetIt();

void set() {
  locator.registerSingleton(CallService());
}

class Subject extends StatefulWidget {
  Subject({this.semester, this.subjectCode});
  final int semester;
  final String subjectCode;

  @override
  _SubjectState createState() => _SubjectState();
}

class _SubjectState extends State<Subject> with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  AnimationController _hideFabAnimController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _hideFabAnimController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: 1, // initially visible
    );

    _scrollController.addListener(() {
      switch (_scrollController.position.userScrollDirection) {
        // Scrolling up - forward the animation (value goes to 1)
        case ScrollDirection.forward:
          _hideFabAnimController.forward();
          break;
        // Scrolling down - reverse the animation (value goes to 0)
        case ScrollDirection.reverse:
          _hideFabAnimController.reverse();
          break;
        // Idle - keep FAB visibility unchanged
        case ScrollDirection.idle:
          break;
      }
    });
  }

  void handleClick(String value) {
    switch (value) {
      case 'Recommended Books':
        recBooks(context);
        break;
      case 'Moderators':
        modno(context);
        break;
    }
  }

  void modno(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        context: context,
        builder: (builder) {
          return Container(
            decoration: BoxDecoration(
                color: Constants.WHITE,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(24.0),
                    topRight: const Radius.circular(24.0))),
            child: Column(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 6,
                        width: 64,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: Firestore.instance
                      .collection('Subjects')
                      .document('${widget.semester}_${widget.subjectCode}')
                      .snapshots(),
                  builder: (context, snapshot) {
                    List<ListItem> messageWidget = [];
                    if (snapshot.hasData) {
                      List mod = snapshot.data['MODERATORS'];
                      print(mod);
                      for (int i = 0; i < mod.length; i++) {
                        final ctnum = mod[i]['Contact Number'];
                        final name = mod[i]['Name'];

                        ListItem lis =
                            ListItem(heading: name, subheaading:'');

                        messageWidget.add(lis);

                        lis = ListItem(
                            heading: 'Contact No. : ', subheaading: ctnum);
//                        messageWidget.add(lis);

                        lis = ListItem(phone: true, subheaading: ctnum);
                        messageWidget.add(lis);

                        lis = ListItem(c: true);
                        messageWidget.add(lis);
                      }
                    }
                    return Expanded(
                      child: ListView(
                        children: messageWidget,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        });
  }

  void recBooks(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        context: context,
        builder: (builder) {
          return Container(
            decoration: BoxDecoration(
                color: Constants.WHITE,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(24.0),
                    topRight: const Radius.circular(24.0))),
            child: Column(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 6,
                        width: 64,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: Firestore.instance
                      .collection('Subjects')
                      .document('${widget.semester}_${widget.subjectCode}')
                      .snapshots(),
                  builder: (context, snapshot) {
                    List<ListItem> messageWidget = [];
                    if (snapshot.hasData) {
                      List RecBooks = snapshot.data['Recommended Books'];
                      print(RecBooks);

                      for (int i = 0; i < RecBooks.length; i++) {
                        final author = RecBooks[i]['Author'];
                        final booktitle = RecBooks[i]['BookTitle'];
                        final publication = RecBooks[i]['Publication'];

                        ListItem lis = ListItem(
                             subheaading: booktitle, b: true);
                        messageWidget.add(lis);

                        lis =
                            ListItem(heading: 'Author : ', subheaading: author);
                        messageWidget.add(lis);

                        lis = ListItem(
                            heading: 'Publication : ',
                            subheaading: publication);

                        messageWidget.add(lis);
                        lis = ListItem(c: true);
                        messageWidget.add(lis);
                      }
                    }
                    return Expanded(
                      child: ListView(
                        children: messageWidget,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _hideFabAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.DARK_SKYBLUE,
          elevation: 0,
          title: Text('${widget.subjectCode}',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
          /*actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              icon: Icon(Icons.info_outline),
              itemBuilder: (BuildContext context) {
                return {'Recommended Books', 'Moderators'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],*/
          bottom: TabBar(
            indicator: MD2Indicator(
                indicatorHeight: 4,
                indicatorColor: Colors.white,
                indicatorSize: MD2IndicatorSize.normal),
            tabs: [
              Tab(
                icon: ImageIcon(AssetImage('assets/svgIcons/book.png')),
                text: 'Material',
              ),
              Tab(
                icon: ImageIcon(AssetImage('assets/svgIcons/pencil.png')),
                text: 'Q. Paper',
              ),
              Tab(
                icon: ImageIcon(AssetImage('assets/svgIcons/link.png')),
                text: 'Links',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StreamWidget(
              widget: widget,
              typeKey: 'Material',
              scrollController: _scrollController,
            ),
            StreamWidget(
              widget: widget,
              typeKey: 'QuestionPapers',
              scrollController: _scrollController,
            ),
            StreamWidget(
              widget: widget,
              typeKey: 'Important Links',
              scrollController: _scrollController,
            ),
          ],
        ),
        floatingActionButton: FadeTransition(
          opacity: _hideFabAnimController,
          child: ScaleTransition(
              scale: _hideFabAnimController,
              child: UnicornDialer(
                backgroundColor: Colors.white70,
                parentButton: ImageIcon(AssetImage('assets/svgIcons/info.png')),
                parentButtonBackground: Constants.DARK_SKYBLUE,
                finalButtonIcon: Icon(Icons.close),
                childPadding: 12,
                childButtons: [
                  UnicornButton(
                    labelColor: Colors.black,
                    hasLabel: true,
                    labelText: 'Books',
                    currentButton: FloatingActionButton(
                        heroTag: null,
                        mini: true,
                        onPressed: () {
                          recBooks(context);
                        },
                        backgroundColor: Constants.DARK_SKYBLUE,
                        child: ImageIcon(AssetImage('assets/svgIcons/book.png'),
                            size: 20)),
                  ),
                  UnicornButton(
                    labelColor: Colors.black,
                    hasLabel: true,
                    labelText: 'Moderators',
                    currentButton: FloatingActionButton(
                        heroTag: null,
                        mini: true,
                        onPressed: () {
                          modno(context);
                        },
                        backgroundColor: Constants.DARK_SKYBLUE,
                        child: ImageIcon(
                            AssetImage('assets/svgIcons/moderators.png'),
                            size: 20)),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class StreamWidget extends StatelessWidget {
  const StreamWidget(
      {Key key,
      @required this.widget,
      @required this.typeKey,
      @required this.scrollController})
      : super(key: key);
  final ScrollController scrollController;
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
            //print(materialData.toString());
            List<Widget> listMaterials = [];
            materialData.forEach((element) {
              listMaterials.add(
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16, top: 12),
                  child: Card(
                    shadowColor: Color.fromRGBO(0, 0, 0, 0.75),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(element['Title'],
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      leading: IconButton(
                          icon: ImageIcon(
                              AssetImage('assets/svgIcons/preview.png')),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PDFViewer(
                                      url: element['Content URL'],
                                      sem: widget.semester,
                                      subjectCode: widget.subjectCode,
                                      typeKey: typeKey,
                                      uniqueID: element['id'],
                                      title: element['Title'],
                                    )));
                          }),
                      trailing: IconButton(
                          icon: ImageIcon(
                              AssetImage('assets/svgIcons/download.png'),
                              size: 20),
                          onPressed: () async {
                            try {
                              String url = element['Content URL'];
                              String dir =
                                  (await getApplicationDocumentsDirectory())
                                      .path;
                              String path =
                                  "$dir/${widget.semester}_${widget.subjectCode}_${typeKey[0]}_${element['id']}_${element['Title']}";
                              if (await File(path).exists()) {
                                print('$path already exists');
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('File Already Downloaded')));
                              }
                              var request =
                                  await HttpClient().getUrl(Uri.parse(url));
                              var response = await request.close();
                              var bytes =
                                  await consolidateHttpClientResponseBytes(
                                      response);
                              File file = new File(path);
                              await file.writeAsBytes(bytes).then((value) {
                                print('$path is now downloaded');
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Download Complete')));
                              });
                              return file;
                            } catch (err) {
                              var errorMessage = "Error";
                              print(errorMessage);
                              print(err);
                              return null;
                            }
                          }),
                    ),
                  ),
                ),
              );
            });
            listMaterials.add(SizedBox(height: 100));
            return Container(
              child: ListView(
                children: listMaterials,
                controller: scrollController,
              ),
            );
          } else if (typeKey == 'QuestionPapers') {
            List materialData = snapshot.data['QuestionPapers'];
            //print(materialData.toString());
            List<Widget> listMaterials = [];
            materialData.forEach((element) {
              listMaterials.add(
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16, top: 12),
                  child: Card(
                    shadowColor: Color.fromRGBO(0, 0, 0, 0.75),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(element['Title'],
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(element['Type'] + '-' + element['Year']),
                      leading: IconButton(
                          icon: ImageIcon(
                              AssetImage('assets/svgIcons/preview.png')),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PDFViewer(
                                      url: element['URL'],
                                      sem: widget.semester,
                                      subjectCode: widget.subjectCode,
                                      typeKey: typeKey,
                                      uniqueID: element['id'],
                                      title: element['Title'],
                                    )));
                          }),
                      trailing: IconButton(
                          icon: ImageIcon(
                              AssetImage('assets/svgIcons/download.png'),
                              size: 20),
                          onPressed: () async {
                            try {
                              String url = element['URL'];
                              String dir =
                                  (await getApplicationDocumentsDirectory())
                                      .path;
                              String path =
                                  "$dir/${widget.semester}_${widget.subjectCode}_${typeKey[0]}_${element['id']}_${element['Title']}";
                              if (await File(path).exists()) {
                                print('$path already exists');
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('File Already Downloaded')));
                              }
                              var request =
                                  await HttpClient().getUrl(Uri.parse(url));
                              var response = await request.close();
                              var bytes =
                                  await consolidateHttpClientResponseBytes(
                                      response);
                              File file = new File(path);
                              await file.writeAsBytes(bytes).then((value) {
                                print('$path is now downloaded');
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Download Complete')));
                              });
                              return file;
                            } catch (err) {
                              var errorMessage = "Error";
                              print(errorMessage);
                              print(err);
                              return null;
                            }
                          }),
                    ),
                  ),
                ),
              );
            });
            listMaterials.add(SizedBox(height: 100));
            return Container(
                child: ListView(
                    controller: scrollController, children: listMaterials));
          } else if (typeKey == 'Important Links') {
            List materialData = snapshot.data['Important Links'];
            //print(materialData.toString());
            List<Widget> listMaterials = [];
            materialData.forEach((element) {
              listMaterials.add(
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16, top: 12),
                  child: Card(
                    shadowColor: Color.fromRGBO(0, 0, 0, 0.75),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(element['Title'],
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      trailing: IconButton(
                          icon: ImageIcon(
                              AssetImage('assets/svgIcons/external Link.png')),
                          onPressed: () {
                            urlLauncher(element['Content URL']);
                          }),
                    ),
                  ),
                ),
              );
            });
            listMaterials.add(SizedBox(height: 100));
            return Container(
                child: ListView(
              children: listMaterials,
              controller: scrollController,
            ));
          }
        }
        return CustomLoader();
      },
    );
  }

  Future urlLauncher(url) async {
    {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}

class ListItem extends StatelessWidget {
  final CallService _service = locator<CallService>();
  @override
  ListItem({this.heading, this.subheaading, this.b, this.c, this.phone});

  String heading;
  String subheaading;
  Icon head;
  bool b = false;
  bool c = false;
  bool phone = false;

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          getWidget(),
        ],
      ),
    );
  }

  Widget getWidget() {
    if (c == true) {
      return SizedBox(
        height: 10.0,
        width: 200.0,
        child: Divider(
          color: Colors.grey,
          height: 0.0,
          thickness: 0.0,
          indent: 40.0,
          endIndent: 40.0,


        ),
      );
    }
    if (phone == true) {
      return Row(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.call, color: Colors.teal,size: 34.0,),
              onPressed: () => _service.call(subheaading)),
          SizedBox(width: 25.0,),
          IconButton(
              icon: Icon(FontAwesomeIcons.whatsapp, color: Colors.teal,size: 34.0,),
              onPressed: () {
                FlutterOpenWhatsapp.sendSingleMessage(subheaading, "");
              })
        ],
      );
    }

    if (b == true) {

        return Row(
          children:<Widget> [
            ImageIcon(AssetImage('assets/svgIcons/book.png'),color: Colors.teal,),
            SizedBox(width: 10.0,),
            Text(
              subheaading,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                fontFamily: 'Montserrat',
              ),
            ),
          ],

        );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            heading,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              fontFamily: 'Montserrat',
            ),
          ),
          Text(
            subheaading,
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      );
    }
  }
}
