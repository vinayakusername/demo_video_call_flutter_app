import 'package:demo_video_calling_flutter_app/app_screens/home_screen.dart';
import 'package:demo_video_calling_flutter_app/app_screens/home_screen1.dart';
import 'package:demo_video_calling_flutter_app/app_screens/videoCall_screen2.dart';
import 'package:demo_video_calling_flutter_app/video_call_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JoinWithCode extends StatelessWidget 
{
  JoinWithCode({ Key? key }) : super(key: key);

  final TextEditingController _controller = TextEditingController();

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
              "https://user-images.githubusercontent.com/67534990/127776450-6c7a9470-d4e2-4780-ab10-143f5f86a26e.png",
              fit: BoxFit.cover,
              height: 100,
             ),
             SizedBox(height: 10,),
             Text
             (
               'Enter meeting code below',
               style: TextStyle
               (
                 fontSize: 15, 
                 fontWeight: FontWeight.bold,
               ),
             ),
             Padding
             (
               padding: const EdgeInsets.fromLTRB(15,20,15,30),
               child: TextFormField
               (
                 controller: _controller,
                 textAlign: TextAlign.center,
                 decoration: InputDecoration
                 (
                   hintText: 'Meeting Code',
                   enabledBorder: OutlineInputBorder
                   (
                     borderRadius: BorderRadius.circular(35),
                     borderSide: BorderSide
                     (
                       color: Colors.grey
                     )
                   ),
                   focusedBorder: OutlineInputBorder
                   (
                     borderRadius: BorderRadius.circular(35),
                     borderSide: BorderSide
                     (
                       color: Colors.grey
                     ) 
                   )
                 ),
               ),
             ),
             ElevatedButton
             (
               onPressed:()
               {
                 Get.to(VideoCallScreen());
                 //Get.to(HomeScreen());
                 //Get.to(VideoCallHomeScreen());
               },
               child:Text('Join'),
               style: ElevatedButton.styleFrom
               (
                 primary: Colors.indigo,
                 fixedSize: Size(80,30),
                 shape: RoundedRectangleBorder
                 (
                   borderRadius: BorderRadius.circular(25)
                 )
               ),
             )
           ],
         ),
       ),
    );
  }
}