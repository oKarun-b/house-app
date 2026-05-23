class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String text;
  final String type;
  final String? imageUrl;
  final String? voiceUrl;
  final DateTime timestamp;
  final bool isRead;
  final bool isDelivered;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    this.text = '',
    this.type = 'text',
    this.imageUrl,
    this.voiceUrl,
    DateTime? timestamp,
    this.isRead = false,
    this.isDelivered = false,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toMap() => {
    'id': id,
    'senderId': senderId,
    'receiverId': receiverId,
    'text': text,
    'type': type,
    'imageUrl': imageUrl,
    'voiceUrl': voiceUrl,
    'timestamp': timestamp.toIso8601String(),
    'isRead': isRead,
    'isDelivered': isDelivered,
  };

  factory ChatMessage.fromMap(Map<String, dynamic> map, String id) => ChatMessage(
    id: id,
    senderId: map['senderId'] ?? '',
    receiverId: map['receiverId'] ?? '',
    text: map['text'] ?? '',
    type: map['type'] ?? 'text',
    imageUrl: map['imageUrl'],
    voiceUrl: map['voiceUrl'],
    timestamp: DateTime.tryParse(map['timestamp'] ?? ''),
    isRead: map['isRead'] ?? false,
    isDelivered: map['isDelivered'] ?? false,
  );
}

class Chat {
  final String id;
  final String userId;
  final String userName;
  final String? userAvatar;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final bool isOnline;
  final String propertyId;
  final String propertyTitle;
  final String? propertyImage;

  Chat({
    required this.id,
    required this.userId,
    required this.userName,
    this.userAvatar,
    this.lastMessage = '',
    DateTime? lastMessageTime,
    this.unreadCount = 0,
    this.isOnline = false,
    this.propertyId = '',
    this.propertyTitle = '',
    this.propertyImage,
  }) : lastMessageTime = lastMessageTime ?? DateTime.now();

  Map<String, dynamic> toMap() => {
    'id': id,
    'userId': userId,
    'userName': userName,
    'userAvatar': userAvatar,
    'lastMessage': lastMessage,
    'lastMessageTime': lastMessageTime.toIso8601String(),
    'unreadCount': unreadCount,
    'isOnline': isOnline,
    'propertyId': propertyId,
    'propertyTitle': propertyTitle,
    'propertyImage': propertyImage,
  };

  factory Chat.fromMap(Map<String, dynamic> map, String id) => Chat(
    id: id,
    userId: map['userId'] ?? '',
    userName: map['userName'] ?? '',
    userAvatar: map['userAvatar'],
    lastMessage: map['lastMessage'] ?? '',
    lastMessageTime: DateTime.tryParse(map['lastMessageTime'] ?? ''),
    unreadCount: map['unreadCount'] ?? 0,
    isOnline: map['isOnline'] ?? false,
    propertyId: map['propertyId'] ?? '',
    propertyTitle: map['propertyTitle'] ?? '',
    propertyImage: map['propertyImage'],
  );
}
