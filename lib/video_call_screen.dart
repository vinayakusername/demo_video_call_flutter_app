
import 'package:agora_uikit/agora_uikit.dart';
import 'package:demo_video_calling_flutter_app/config/config_file.dart';
import 'package:flutter/material.dart';

class VideoCallScreen extends StatefulWidget 
{
  

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> 
{
  int _remoteUid = 0;

  final AgoraClient _client = AgoraClient
  (
    agoraConnectionData: AgoraConnectionData
    (
      appId: VideoCallingCredentials.AppId, 
      tempToken: VideoCallingCredentials.token,
      channelName: VideoCallingCredentials.channelName
    ), 
    enabledPermission: 
    [
      Permission.camera,
      Permission.microphone
    ],
    agoraEventHandlers: AgoraEventHandlers
    (
       joinChannelSuccess:(String channel, int uid, int elapsed) 
       {
          print("Local user who's $uid joined");  
       }, 
       userJoined: (int uid,int elapsed)
        {
          print("Remote user who's $uid joined");
          // setState(() 
          // {
          //   _remoteUid = uid;  
          // }); 
        },
       userOffline: (int uid,UserOfflineReason reason)
        {
           print("Remote user who's userId is $uid is left the channel "+"\n"+"Reason to useroffline $reason");
          
          //  setState(() 
          //  {
          //    _remoteUid = 0;  
          //  });
        }, 
       
    ),
    
  );

// Initialize the Agora Engine
@override
void initState() 
{
  super.initState();
  initAgora();
}

void initAgora() async 
{
  await _client.initialize();
}

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
       body:SafeArea
       (
        child: Stack
        (
          children: 
          [
            AgoraVideoViewer
            (
              client: _client,
              layoutType: Layout.floating,
              floatingLayoutContainerWidth: 100,
              floatingLayoutContainerHeight: 100,
              floatingLayoutMainViewPadding: const EdgeInsets.fromLTRB(0, 0,0,0),
              floatingLayoutSubViewPadding: const EdgeInsets.fromLTRB(0,0,0,0),
              showNumberOfUsers: false,
              showAVState: true,
            ), 
            AgoraVideoButtons(client: _client),
          ],
        ),
      ),
    );
  }
}