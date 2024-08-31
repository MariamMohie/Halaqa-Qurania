import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:islamic/features/chat/data/firebase_chats.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  Stream<QuerySnapshot> getallusers() {
    emit(GetUserLoading());
    return firebase_chats.getallusers();
  }

  final player = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  String chatid = '';
  String searching = "";

  getAudio(String voiceUrl) async {
    emit(AudioLoading());
    try {
      //! take the time and expand it as duration
      duration = await player.setUrl(
        voiceUrl,
      ) as Duration;
      //! all the duration
      player.durationStream.listen((duration0) {
        duration = duration0 as Duration;
      });
      //! the position that the rec reach every minute
      player.positionStream.listen((position0) {
        position = position0 as Duration;
      });

      Timer.periodic(Duration(seconds: 1), (timer) {
        initial();
      });

      emit(AudioLoaded());
    } catch (e) {
      emit(AudioFailed());
    }
  }

  // initial
  initial() {
    player.durationStream.listen((duration0) {
      duration = duration0 as Duration;
    });

    player.positionStream.listen((position0) {
      position = position0 as Duration;
    });
    emit(AudioLoaded());
  }

  // search by name
  Future<void> searchbyname(String name) async {
    emit(GetUserLoading());
    chatid = await firebase_chats.searchbyname(name);
    searching = name;
    emit(GetUserLoaded());
  }
}
