import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatgpt_chat_app_ai/model/chat_model.dart';
import 'package:flutter/material.dart';

class ChatMessageItem extends StatelessWidget {
  final ChatModel chatModel;

  const ChatMessageItem({Key? key, required this.chatModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return chatModel.type == ChatType.bot
        ? _buildChatBot(context)
        : _buildChatUser(context);
  }

  Container _buildChatUser(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 120, right: 8, top: 4, bottom: 4),
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(14),
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
        color: Colors.blue,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    chatModel.message,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: const CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildChatBot(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 120, top: 4, bottom: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.5),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(14),
            topLeft: Radius.circular(14),
            bottomRight: Radius.circular(14),
          )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: const CircleAvatar(
              backgroundColor: Color.fromRGBO(16, 163, 127, 1),
              backgroundImage: AssetImage(
                'assets/images/bot.png',
              ),
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    //TyperAnimatedText(chatModel.message),
                    //TypewriterAnimatedText(chatModel.message),
                    ColorizeAnimatedText(
                      chatModel.message,
                      colors: [Colors.white,Colors.red, Colors.green, Colors.purple],
                      textStyle: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],

                  totalRepeatCount: 1,

                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
/*
Text(
                      chatModel.message,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                          ),
                    )
 */
