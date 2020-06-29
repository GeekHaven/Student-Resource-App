import 'package:flutter/material.dart';
import 'package:studentresourceapp/pages/signin.dart';
import 'package:studentresourceapp/components/custom_dropdown.dart';
import 'package:studentresourceapp/utils/contstants.dart';
List<Color> _colors = [Constants.DARK_SKYBLUE, Constants.SKYBLUE];
List<double> _stops = [0.0, 1.8];

String college="IIITA";
int batch;
String branch;
int semester;
class UserDetailGetter extends StatefulWidget {
  @override
  _UserDetailGetterState createState() => _UserDetailGetterState();
}

class _UserDetailGetterState extends State<UserDetailGetter> {


  List<String> _college = ['IIITA', 'Others'];
  String _selectedCollege;

  List<String> _branches = ['IT', 'ITBI', 'ECE'];
  String _selectedBranch;

  List<int> _semester = [1, 2, 3, 4, 5, 6, 7, 8];
  int _selectedSemester;

  List<int> _batches = [2020, 2019, 2018, 2017, 2016];
  int _selectedBatch;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Hero(
                        tag: 'logo',
                        child: Container(
                            height: 180.0,
                            child: Image.asset('assets/images/Logo.png')),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0,top: 8.0,bottom: 8.0),
                    child: Text(
                      'Semester',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
child: CustomDropdown(text: "",list: _semester,type: 1,),

                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0,top: 8.0,bottom: 8.0),
                    child: Text(
                      'Batch',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomDropdown(text: "",list: _batches,type: 2,),

                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0,top: 8.0,bottom: 8.0),
                    child: Text(
                      'Branch',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomDropdown(text: "",list: _branches,type: 3,),

                  ),

//                  RaisedButton(
//                      child: Text('Proceed'),
//                      onPressed: () {
//                        Navigator.of(context).push(
//                          MaterialPageRoute(
//                            builder: (context) {
//                              return SignIn(
//                                  college: college,
//                                  batch: batch,
//                                  branch: branch,
//                                  semester: semester);
//                            },
//                          ),
//                        );
//                      })

                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(

                    onTap: ()
                    {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return SignIn(
                                  college: college,
                                  batch: batch,
                                  branch: branch,
                                  semester: semester);
                            },
                          ),
                        );

                    },
                    child: Padding(

                      padding: EdgeInsets.all(36.0),
                      child: Container(

                        height:50.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(
                            colors: _colors,
                            stops: _stops,

                          )
                          ,
                      ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [

                              Text("Next",style: TextStyle(color :Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios,color: Colors.white,

                              )
                            ],
                          ),
                        ),

                    ),

                ),
                  ),),
                ]),
          ),
        ),
      ),
    );
  }
}
