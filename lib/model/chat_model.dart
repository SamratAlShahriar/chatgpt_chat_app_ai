enum ChatType { bot, user }

class ChatModel {
  String message;
  ChatType type;

  ChatModel({required this.message, required this.type});
}
