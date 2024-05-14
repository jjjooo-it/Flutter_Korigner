import 'package:flutter/material.dart';
import '../../model/message.dart';

class ChatViewModel extends ChangeNotifier {
  List<Message> _messages = [];

  List<Message> get messages => _messages;

  void addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }
}