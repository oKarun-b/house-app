import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message.dart';

class MessageService {
  final FirebaseFirestore _firestore;

  MessageService(this._firestore);

  CollectionReference get _chats => _firestore.collection('chats');
  CollectionReference get _messages => _firestore.collection('messages');

  Future<String> createOrGetChat({
    required String userId1,
    required String userId2,
    required String propertyId,
    required String propertyTitle,
    String? propertyImage,
  }) async {
    final chatId = userId1.compareTo(userId2) < 0
        ? '${userId1}_${userId2}_$propertyId'
        : '${userId2}_${userId1}_$propertyId';

    final existing = await _chats.doc(chatId).get();
    if (!existing.exists) {
      await _chats.doc(chatId).set({
        'participants': [userId1, userId2],
        'userId': userId1,
        'otherUserId': userId2,
        'lastMessage': 'Start a conversation',
        'lastMessageTime': DateTime.now().toIso8601String(),
        'unreadCount': 0,
        'isOnline': false,
        'propertyId': propertyId,
        'propertyTitle': propertyTitle,
        'propertyImage': propertyImage,
        'createdAt': DateTime.now().toIso8601String(),
      });
    }
    return chatId;
  }

  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String receiverId,
    required String text,
    String type = 'text',
    String? imageUrl,
    String? voiceUrl,
  }) async {
    final msgRef = _messages.doc();
    final message = ChatMessage(
      id: msgRef.id,
      senderId: senderId,
      receiverId: receiverId,
      text: text,
      type: type,
      imageUrl: imageUrl,
      voiceUrl: voiceUrl,
    );
    await msgRef.set(message.toMap());

    await _chats.doc(chatId).update({
      'lastMessage': text,
      'lastMessageTime': DateTime.now().toIso8601String(),
      'unreadCount': FieldValue.increment(1),
    });
  }

  Stream<QuerySnapshot> getMessages(String chatId) {
    return _messages
        .where('chatId', isEqualTo: chatId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getUserChats(String userId) {
    return _chats
        .where('participants', arrayContains: userId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots();
  }

  Future<void> markAsRead(String chatId, String userId) async {
    await _chats.doc(chatId).update({'unreadCount': 0});
  }

  Future<void> updateOnlineStatus(String userId, bool isOnline) async {
    final chats = await _chats
        .where('participants', arrayContains: userId)
        .get();
    for (final chat in chats.docs) {
      await chat.reference.update({'isOnline': isOnline});
    }
  }

  Stream<DocumentSnapshot> getChat(String chatId) {
    return _chats.doc(chatId).snapshots();
  }
}
