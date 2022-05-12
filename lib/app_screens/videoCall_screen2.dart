import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:demo_video_calling_flutter_app/config/config_file.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoCallHomeScreen extends StatefulWidget 
{
  const VideoCallHomeScreen({ Key? key }) : super(key: key);

  @override
  State<VideoCallHomeScreen> createState() => _VideoCallHomeScreenState();
}

class _VideoCallHomeScreenState extends State<VideoCallHomeScreen> 
{
  bool _joined = false;
  int _remoteUid = 0;
  bool _switch = false;

  @override
  void initState() 
  {
    super.initState();
    initPlatformState();
  }

  // Init the app
  Future<void> initPlatformState() async 
  {
    await [Permission.camera, Permission.microphone].request();

    // Create RTC client instance
    var engine = await RtcEngine.createWithConfig(RtcEngineConfig(VideoCallingCredentials.AppId));
    // Define event handling logic
    engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print('joinChannelSuccess ${channel} ${uid}');
          setState(() {
            _joined = true;
          });
        }, 
      userJoined: (int uid, int elapsed) 
      {
      print('userJoined ${uid}');
      setState(() {
        _remoteUid = uid;
      });
    }, 
    userOffline: (int uid, UserOfflineReason reason) 
    {
      print('userOffline ${uid}');
      setState(() {
        _remoteUid = 0;
      });
    }));
    // Enable video
    await engine.enableVideo();
    // Join channel with channel name as 123
    await engine.joinChannel(VideoCallingCredentials.token, VideoCallingCredentials.channelName, null, 0);
  }




  @override
  Widget build(BuildContext context) 
  {
    return  Scaffold
    (
        appBar: AppBar
        (
          title: const Text('Flutter example app'),
        ),
        body: Stack
        (
          children: [
            Center(
              child: _switch ? _renderRemoteVideo() : _renderLocalPreview(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding
              (
                padding: const EdgeInsets.all(8.0),
                child: Container
                (
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _switch = !_switch;
                      });
                    },
                    child: Center
                    (
                      child:
                      _switch ? _renderLocalPreview() : _renderRemoteVideo(),
                    ),
                    
                  ),
 
                ),
              ),
            ),
          ],
        ),
      );
  }

  
  // Local preview
  Widget _renderLocalPreview() 
  {
    if (_joined) {
      return RtcLocalView.SurfaceView();
    } else {
      return Text(
        'Please join channel first',
        textAlign: TextAlign.center,
      );
    }
  }

  // Remote preview
 Widget _renderRemoteVideo() 
 {
    if (_remoteUid != 0) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid,
        channelId:VideoCallingCredentials.channelName,
      );
    } else {
      return Text(
        'Please wait remote user join',
        textAlign: TextAlign.center,
      );
    }
  }
}