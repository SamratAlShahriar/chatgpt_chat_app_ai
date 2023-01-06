import 'package:flutter/material.dart';

import '../model/chat_model.dart';

class ChatProvider extends ChangeNotifier{
  final List<ChatModel> _chatList = [];

  List<ChatModel> get chatList => _chatList;

  void addToChatList(ChatModel chatModel) {
    _chatList.add(chatModel);
    notifyListeners();
  }



}