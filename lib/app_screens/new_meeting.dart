import 'package:demo_video_calling_flutter_app/app_screens/home_screen1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewMeeting extends StatefulWidget 
{
  NewMeeting({ Key? key }) : super(key: key);

  @override
  State<NewMeeting> createState() => _NewMeetingState();
}

class _NewMeetingState extends State<NewMeeting> 
{
   
   final TextEditingController _controller = TextEditingController();
   String _meetingCode = "abcdfgqw";

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: SafeArea
      (
        child: Column
        (
          children: 
          [
             Align
             (
               alignment: Alignment.topLeft,
               child: IconButton
               (
                 onPressed:()
                 {
                   Get.back(result: HomeScreen1());//This will navigate from joinWithCode to HomeScreen.
                 }, 
                 icon:Icon(Icons.arrow_back_ios_new_sharp)
               ),
             ),
             SizedBox(height: 50.0,),
             Image.network
             (
               "https://user-images.githubusercontent.com/67534990/127776392-8ef4de2d-2fd8-4b5a-b98b-ea343b19c03e.png",
              fit: BoxFit.cover,
              height: 100,
             ),
             SizedBox(height: 10,),
             Text
             (
               "Enter meeting code below",
               style: TextStyle
               (
                 fontSize: 15, 
                 fontWeight: FontWeight.bold,
               ),
             ),

              Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Card(
                  color: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.link),
                    title: SelectableText(
                      _meetingCode,
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    trailing: Icon(Icons.copy),
                  )),
            ),
            Divider(thickness: 1, height: 20, indent: 20, endIndent: 20),
            
              Padding
              (
                padding: EdgeInsets.fromLTRB(20, 40,20,0),
                child: ElevatedButton.icon
                (
                  onPressed:()
                  {
                    Get.to(NewMeeting());
                  }, 
                  icon:Icon(Icons.arrow_drop_down), 
                  label: Text('Share invite'),
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
              SizedBox(height: 10.0,),
              OutlinedButton.icon
              (
                onPressed:()
                {
                 
                }, 
                icon: Icon(Icons.video_call), 
                label:Text('Start call'),
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
          ],
        )
      ),
    );
  }
}