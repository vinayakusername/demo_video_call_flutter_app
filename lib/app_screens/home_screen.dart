
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:demo_video_calling_flutter_app/config/config_file.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget 
{
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> 
{
  //int? _remoteUid;
  int _remoteUid = 0;

  RtcEngine? _engine;

  @override
  void initState() 
  {
    // TODO: implement initState
    super.initState();
    initForAgora(); 
  }
 
 Future<void> initForAgora() async 
 {
    await [Permission.camera,Permission.microphone].request();

    _engine = await RtcEngine.createWithConfig(RtcEngineConfig(VideoCallingCredentials.AppId));

    await _engine?.enableVideo();
    _engine?.setEventHandler
    (
      RtcEngineEventHandler
      (
        joinChannelSuccess: (String channel, int uid, int elapsed) 
        {
         print("Local user who's $uid joined");  
        },
        userJoined: (int uid,int elapsed)
        {
          print("Remote user who's $uid joined");
          setState(() 
          {
            _remoteUid = uid;  
          }); 
        },
        userOffline: (int uid,UserOfflineReason reason)
        {
           print("Remote user who's userId is $uid is left the channel ");
           setState(() 
           {
             _remoteUid = 0;  
           });
        }
      )
    );
    await _engine?.joinChannel(VideoCallingCredentials.token,"first channel",null,0);
 }


  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text("Demo Video Calling App"),
        centerTitle: true,
      ),
      body: Stack
      (
        children: 
        [
          Center
          (
            child:_renderRemoteVideo(),
          ),
          Align
          (
            alignment: Alignment.topLeft,
            child: Container
            (
              width: 100,
              height: 100,
              child: Center
              (
                child: _renderLocalPreview(),
              ),
            ),
          )
        ],
      ),
    );
  }

  //remote user video
  Widget _renderRemoteVideo()
  {
    if(_remoteUid!=0)
    {
      return RtcRemoteView.SurfaceView
      (
        uid:_remoteUid
      );
    }else
    {
      return Text
      (
        'Please wait till remote user join',
        textAlign: TextAlign.center,
      );
    }
    
  }
  //local user video
  Widget _renderLocalPreview()
  {
    return  RtcLocalView.SurfaceView();
    // return Transform.rotate
    // (
    //   //angle: 90* pi /180,
    //   angle: 90/180,
    //   //child:  RtcLocalView.SurfaceView(uid: _remoteUid, channelId:"first channel"),
    //   child: RtcLocalView.SurfaceView(),
    // );
  
  }
}



