// ignore_for_file: non_constant_identifier_names, dead_code
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videosdk/videosdk.dart';
import '../../../../cubit/cubit/stream_cubit.dart';
import '../data/api.dart';
import '../theme/Appcolors.dart';
import '../widgets/joining_details.dart';
import '../widgets/toast.dart';
import 'conference_meeting_screen.dart';

// Join Screen
class JoinScreen extends StatefulWidget {
  JoinScreen(
      {Key? key,
      required this.streamname,
      required this.id,
      required this.join})
      : super(key: key);
  String streamname;
  String id;
  bool join;

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  String _token = "";

  // Control Status
  bool isMicOn = true;
  bool isCameraOn = true;

  CustomTrack? cameraTrack;
  RTCVideoRenderer? cameraRenderer;

  bool? isJoinMeetingSelected;
  bool? isCreateMeetingSelected;

  @override
  void initState() {
    initCameraPreview();
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final token = await fetchToken(context);
      // setState(() => _token = token);
      setState(() => _token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiIyNGIyOWRjNi1lZDlhLTQ3NGMtYWRlMy01ZGVkMTJkMjE5YWMiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTcyNTAxODczMCwiZXhwIjoxNzI1NjIzNTMwfQ.49XHZWAAG5TxvcqNoaVdKsTyJZBc5jnjG_T9mthzwIo");
    });
  }

  @override
  setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => StreamCubit()..getusername(),
      child: BlocConsumer<StreamCubit, StreamState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = BlocProvider.of<StreamCubit>(context);

          return WillPopScope(
              onWillPop: _onWillPopScope,
              child: Scaffold(
                backgroundColor: Appcolors.primaryColor,
                body: SafeArea(
                  child: LayoutBuilder(
                    builder: (BuildContext context,
                        BoxConstraints viewportConstraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: viewportConstraints.maxHeight),
                          child: IntrinsicHeight(
                            child: Column(
                              mainAxisAlignment: !kIsWeb &&
                                      (Platform.isAndroid || Platform.isIOS)
                                  ? MainAxisAlignment.center
                                  : MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Camera Preview
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 100, horizontal: 36),
                                  child: SizedBox(
                                    height: 300,
                                    width: 200,
                                    child: Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 16 / 9,
                                          child: cameraRenderer != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: RTCVideoView(
                                                    cameraRenderer
                                                        as RTCVideoRenderer,
                                                    objectFit: RTCVideoViewObjectFit
                                                        .RTCVideoViewObjectFitCover,
                                                  ),
                                                )
                                              : Container(
                                                  decoration: BoxDecoration(
                                                      color: Appcolors.black800,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: const Center(
                                                    child: Text(
                                                      "Camera is turned off",
                                                    ),
                                                  ),
                                                ),
                                        ),
                                        Positioned(
                                          bottom: 16,
                                          // Meeting ActionBar
                                          child: Center(
                                            child: Row(
                                              children: [
                                                // Mic Action Button
                                                ElevatedButton(
                                                  onPressed: () => setState(
                                                    () => isMicOn = !isMicOn,
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape: const CircleBorder(),
                                                    padding: EdgeInsets.all(
                                                      16 / 9,
                                                    ),
                                                    backgroundColor: isMicOn
                                                        ? Colors.white
                                                        : Colors.red,
                                                    foregroundColor:
                                                        Colors.black,
                                                  ),
                                                  child: Icon(
                                                      isMicOn
                                                          ? Icons.mic
                                                          : Icons.mic_off,
                                                      color: isMicOn
                                                          ? Colors.grey
                                                          : Colors.white),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    if (isCameraOn) {
                                                      disposeCameraPreview();
                                                    } else {
                                                      initCameraPreview();
                                                    }
                                                    setState(() => isCameraOn =
                                                        !isCameraOn);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape: const CircleBorder(),
                                                    padding: EdgeInsets.all(
                                                      16 / 9,
                                                    ),
                                                    backgroundColor: isCameraOn
                                                        ? Colors.white
                                                        : Colors.red,
                                                  ),
                                                  child: Icon(
                                                    isCameraOn
                                                        ? Icons.videocam
                                                        : Icons.videocam_off,
                                                    color: isCameraOn
                                                        ? Colors.grey
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // create meeting button
                                widget.join == true
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            right: 60, left: 60),
                                        child: GestureDetector(
                                          onTap: () async {
                                            
                                           await joinMeeting("GROUP",
                                                cubit.username, widget.id);
                                          },
                                          child: Container(
                                            width: 200,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Appcolors.black800,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(child: Text("Join")),
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            right: 60, left: 60),
                                        child: GestureDetector(
                                          onTap: () async {
                                            await createAndJoinMeeting(
                                                "GROUP", cubit.username);
                                            if (id.isNotEmpty) {
                                              cubit.createStream(
                                                  widget.streamname, id);
                                            } else {}
                                          },
                                          child: Container(
                                            width: 200,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Appcolors.black800,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child:
                                                Center(child: Text("Create")),
                                          ),
                                        ),
                                      )

                                // Padding(
                                //   padding: const EdgeInsets.only(bottom: 30),
                                //   child: Column(
                                //     children: [
                                //       if (isJoinMeetingSelected == null &&
                                //           isCreateMeetingSelected == null)
                                //         MaterialButton(
                                //             minWidth:16/9,
                                //             height: 50,
                                //             shape: RoundedRectangleBorder(
                                //                 borderRadius:
                                //                     BorderRadius.circular(12)),
                                //             padding: const EdgeInsets.symmetric(
                                //                 vertical: 16),
                                //             color: Appcolors.black800,
                                //             child:  Text("Create Meeting",
                                //                 style: TextStyle(fontSize: 16,color: Appcolors.fontcolor)),
                                //             onPressed: () => {
                                //                   setState(() => {
                                //                         isCreateMeetingSelected =
                                //                             true,
                                //                         isJoinMeetingSelected = true
                                //                       })
                                //                 }),
                                //       SizedBox(height: 16.h,),
                                //       if (isJoinMeetingSelected == null &&
                                //           isCreateMeetingSelected == null)
                                //         MaterialButton(
                                //             minWidth: 16/9,
                                //             height: 50,
                                //             shape: RoundedRectangleBorder(
                                //                 borderRadius:
                                //                     BorderRadius.circular(12)),
                                //             padding: const EdgeInsets.symmetric(
                                //                 vertical: 16),
                                //             color: Appcolors.black800,
                                //             child:  Text("Join Meeting",
                                //                 style: TextStyle(fontSize: 16,color: Appcolors.fontcolor)),
                                //             onPressed: () => {
                                //                   setState(() => {
                                //                         isCreateMeetingSelected =
                                //                             false,
                                //                         isJoinMeetingSelected = true
                                //                       })
                                //                 }),
                                //       if (isJoinMeetingSelected != null &&
                                //           isCreateMeetingSelected != null)
                                //         JoiningDetails(
                                //           isCreateMeeting: isCreateMeetingSelected!,
                                //           onClickMeetingJoin: (meetingId, callType,
                                //                   displayName) =>
                                //               _onClickMeetingJoin(
                                //                   meetingId, callType, displayName),
                                //         ),
                                //     ],
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ));
        },
      ),
    );
  }

  Future<bool> _onWillPopScope() async {
    if (isJoinMeetingSelected != null && isCreateMeetingSelected != null) {
      setState(() {
        isJoinMeetingSelected = null;
        isCreateMeetingSelected = null;
      });
      return false;
    } else {
      return true;
    }
  }

  void initCameraPreview() async {
    CustomTrack track = await VideoSDK.createCameraVideoTrack();
    RTCVideoRenderer render = RTCVideoRenderer();
    await render.initialize();
    render.setSrcObject(
        stream: track.mediaStream,
        trackId: track.mediaStream.getVideoTracks().first.id);
    setState(() {
      cameraTrack = track;
      cameraRenderer = render;
    });
  }

  void disposeCameraPreview() {
    cameraTrack?.dispose();
    setState(() {
      cameraRenderer = null;
      cameraTrack = null;
    });
  }

  void _onClickMeetingJoin(meetingId, callType, displayName) async {
    if (displayName.toString().isEmpty) {
      displayName = "Guest";
    }
    if (isCreateMeetingSelected!) {
      createAndJoinMeeting(callType, displayName);
    } else {
      joinMeeting(callType, displayName, meetingId);
    }
  }

  Future<void> createAndJoinMeeting(callType, displayName) async {
    try {
      var _meetingID = await createMeeting(
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiIyNGIyOWRjNi1lZDlhLTQ3NGMtYWRlMy01ZGVkMTJkMjE5YWMiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTcyNTAxODczMCwiZXhwIjoxNzI1NjIzNTMwfQ.49XHZWAAG5TxvcqNoaVdKsTyJZBc5jnjG_T9mthzwIo");

      setState(() {
        id = _meetingID;
      });
      if (mounted) {
        disposeCameraPreview();
        if (callType == "GROUP") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfereneceMeetingScreen(
                //token: _token,
                token:
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiIyNGIyOWRjNi1lZDlhLTQ3NGMtYWRlMy01ZGVkMTJkMjE5YWMiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTcyNTAxODczMCwiZXhwIjoxNzI1NjIzNTMwfQ.49XHZWAAG5TxvcqNoaVdKsTyJZBc5jnjG_T9mthzwIo",
                meetingId: _meetingID,
                displayName: displayName,
                micEnabled: isMicOn,
                camEnabled: isCameraOn,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfereneceMeetingScreen(
                //token: _token,
                token:
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiIyNGIyOWRjNi1lZDlhLTQ3NGMtYWRlMy01ZGVkMTJkMjE5YWMiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTcyNTAxODczMCwiZXhwIjoxNzI1NjIzNTMwfQ.49XHZWAAG5TxvcqNoaVdKsTyJZBc5jnjG_T9mthzwIo",
                meetingId: _meetingID,
                displayName: displayName,
                micEnabled: isMicOn,
                camEnabled: isCameraOn,
              ),
            ),
          );
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => OneToOneMeetingScreen(
          //         token: _token,
          //         meetingId: _meetingID,
          //         displayName: displayName,
          //         micEnabled: isMicOn,
          //         camEnabled: isCameraOn,
          //       ),
          //     ),
          //   );
        }
      }
    } catch (error) {
      showSnackBarMessage(message: error.toString(), context: context);
    }
  }

  Future<void> joinMeeting(callType, displayName, meetingId) async {
    if (meetingId.isEmpty) {
      showSnackBarMessage(
          message: "Please enter Valid Meeting ID", context: context);
      return;
    }
    var validMeeting = await validateMeeting(_token, meetingId);
    if (validMeeting) {
      if (mounted) {
        disposeCameraPreview();
        if (callType == "GROUP") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfereneceMeetingScreen(
                token:
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiIyNGIyOWRjNi1lZDlhLTQ3NGMtYWRlMy01ZGVkMTJkMjE5YWMiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTcyNTAxODczMCwiZXhwIjoxNzI1NjIzNTMwfQ.49XHZWAAG5TxvcqNoaVdKsTyJZBc5jnjG_T9mthzwIo",
                meetingId: meetingId,
                displayName: displayName,
                micEnabled: isMicOn,
                camEnabled: isCameraOn,
              ),
            ),
          );
        } else {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => OneToOneMeetingScreen(
          //         token: _token,
          //         meetingId: meetingId,
          //         displayName: displayName,
          //         micEnabled: isMicOn,
          //         camEnabled: isCameraOn,
          //       ),
          //     ),
          //   );
        }
      }
    } else {
      if (mounted) {
        showSnackBarMessage(message: "Invalid Meeting ID", context: context);
      }
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    cameraTrack?.dispose();
    
    super.dispose();
  }
}

String id = "";
