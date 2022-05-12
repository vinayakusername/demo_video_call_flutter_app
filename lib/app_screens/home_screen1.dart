import 'package:demo_video_calling_flutter_app/app_screens/joinWithCode.dart';
import 'package:demo_video_calling_flutter_app/app_screens/new_meeting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen1 extends StatelessWidget 
{
  const HomeScreen1({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text('Video Conference App'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child:SingleChildScrollView
        (
          scrollDirection: Axis.vertical,
          child: Column
          (
            crossAxisAlignment: CrossAxisAlignment.center,
            children: 
            [
              Padding
              (
                padding: EdgeInsets.fromLTRB(20, 40,20,0),
                child: ElevatedButton.icon
                (
                  onPressed:()
                  {
                    Get.to(NewMeeting());
                  }, 
                  icon:Icon(Icons.add), 
                  label: Text('New Meeting'),
                  style: ElevatedButton.styleFrom
                  (
                    fixedSize: Size(350,30),
                    primary: Colors.indigo,
                    shape: RoundedRectangleBorder
                    (
                      borderRadius: BorderRadius.circular(20)
                    )
                  ),
                ),
              ),
              
               Divider
                (
                  thickness: 2.0,
                  height: 40,
                  indent: 50,
                  endIndent:50
                ),
            
              
              OutlinedButton.icon
              (
                onPressed:()
                {
                  /*
                    Below Get class is used to navigate from HomeScreen to JoinWithCode.
                   */
                  Get.to(JoinWithCode());
                }, 
                icon: Icon(Icons.margin), 
                label:Text('Join with a code'),
                style: OutlinedButton.styleFrom
                  (
                    fixedSize: Size(350,30),
                    primary: Colors.indigo,
                    side: BorderSide
                    (
                      color: Colors.indigo
                    ),
                    shape: RoundedRectangleBorder
                    (
                      borderRadius: BorderRadius.circular(20)
                    )
                  ),
              ),
              SizedBox(height: 150),
              Image.network
              (
               "https://user-images.githubusercontent.com/67534990/127524449-fa11a8eb-473a-4443-962a-07a3e41c71c0.png"
              )
            ],
          ),
        ),
      ),
    );
  }
}