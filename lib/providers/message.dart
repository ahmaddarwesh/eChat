import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:whatsapp_clone/providers/person.dart';

enum MessageType {
  Text,
  Image,
}

class InitChatData {
  final String groupId;
  final Person person;
  final List<Message> messages;
  InitChatData({
    @required this.groupId,
    @required this.person,
    @required this.messages,
  });

  void addMessage(Message newMsg) {
    if(messages.length > 5) {
      print('removed ----------->${messages.last.content}');
      messages.removeLast();}
    
    messages.insert(0, newMsg);
    print('added ---------> ${newMsg.content}');
  }

  dynamic gettojson() {
    return Person.toJson(person);
  }

  dynamic getMessagesJson() {
    var res = [];
    messages.forEach((element) {
      res.add(Message.toJson(element));
    });
    return json.encode(res);
  }

  static toJson(InitChatData chatData) {
    final map = {
      'person': Person.toJson(chatData.person),
      'messages': chatData.getMessagesJson(),
    };
    return json.encode(map);
  }
}

class Message {
  String content;
  String fromId;
  String toId;
  DateTime timeStamp;
  bool isSeen;
  String type;

  Message({
    this.content,
    this.fromId,
    this.toId,
    this.timeStamp,
    this.isSeen,
    this.type
  });

  static Message fromSnapshot(DocumentSnapshot snapshot) {
    return Message(
      content: snapshot['content'],
      fromId: snapshot['fromId'],
      toId: snapshot['toId'],
      timeStamp: DateTime.parse(snapshot['date']),
      isSeen: snapshot['isSeen'],
      type: snapshot['type'],
    );
  }

  static toJson(Message message) {
    return json.encode({
      'content': message.content,
      'fromId': message.fromId,
      'toId': message.toId,
      'timeStamp': message.timeStamp.toIso8601String(),
      'isSeen': message.isSeen,
      'type': message.type,
    });    
  }
}