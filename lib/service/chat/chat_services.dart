import 'package:chatapp/service/chat/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class ChatServices extends ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getuserstream() {
    final CurrentUser = _auth.currentUser;
    return _firestore
        .collection('users')
        .doc(CurrentUser!.uid)
        .collection('BlockedUsers')
        .snapshots()
        .asyncMap((snapshot) async {
      final blockedUserIds = snapshot.docs.map((doc) => doc.id).toList();

      final userSnapshot = await _firestore.collection("users").get();

      return userSnapshot.docs
          .where((doc) =>
              doc.data()['email'] != CurrentUser.email &&
              !blockedUserIds.contains(doc.id))
          .map((doc) => doc.data())
          .toList();
    });
  }

  Future<void> blockuser(String userId) async {
    final currenUser = _auth.currentUser;
    await _firestore
        .collection('users')
        .doc(currenUser!.uid)
        .collection('BlockedUsers')
        .doc(userId)
        .set({});

    notifyListeners();
  }

  Future<void> unblockuser(String blockedUserIds) async {
    final currentUser = _auth.currentUser;
    await _firestore
        .collection("users")
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .doc(blockedUserIds)
        .delete();
  }

  Stream<List<Map<String, dynamic>>> getBlockedUserStream(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('BlockedUsers')
        .snapshots()
        .asyncMap((snapshot) async {
      final blockedUserIds = snapshot.docs.map((doc) => doc.id).toList();

      final userdocs = await Future.wait(blockedUserIds
          .map((id) => _firestore.collection('users').doc(id).get()));

      return userdocs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  Future<void> sendMessage(String reciverId, message) async {
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        reciverId: reciverId,
        message: message,
        timestamp: timestamp);
    List<String> ids = [currentUserId, reciverId];
    ids.sort();
    String chatroomId = ids.join('_');

    await _firestore
        .collection("Chatroom")
        .doc(chatroomId)
        .collection("Messages")
        .add(newMessage.toMap());
  }

  //getMessage

  Stream<QuerySnapshot> getMessage(String userid, otheruserid) {
    List<String> ids = [userid, otheruserid];
    ids.sort();
    String chatroomId = ids.join('_');

    return _firestore
        .collection("Chatroom")
        .doc(chatroomId)
        .collection("Messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
