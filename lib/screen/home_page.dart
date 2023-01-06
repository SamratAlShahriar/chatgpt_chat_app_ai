import 'package:chatgpt_chat_app_ai/model/chat_model.dart';
import 'package:chatgpt_chat_app_ai/provider/chat_provider.dart';
import 'package:chatgpt_chat_app_ai/repo/api_call.dart';
import 'package:chatgpt_chat_app_ai/widgets/chat_message_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/colors.dart';

class Homepage extends StatefulWidget {
  static const String routeName = '/home';

  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late bool isLoading;
  late TextEditingController _textEditingController;
  late ScrollController _scrollController;
  late ChatProvider chatProvider;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    isLoading = false;
    _textEditingController = TextEditingController();
    _scrollController = ScrollController();
    _focusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    chatProvider = Provider.of<ChatProvider>(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CHAT APP (chatGPT)',
        ),
        backgroundColor: botBackgroundColor,
      ),
      backgroundColor: backgroundColor,
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: Column(
          children: [
            //chat body
            _buildChatBody(),

            Visibility(
              visible: isLoading,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              ),
            ),

            _buildTextFieldWithBtn(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldWithBtn() {
    return Row(
      children: [
        //build text input field
        Expanded(
          child: TextField(
            focusNode: _focusNode,
            controller: _textEditingController,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: const InputDecoration(
              fillColor: botBackgroundColor,
              filled: true,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        ),

        //build send button
        Visibility(
            visible: !isLoading,
            child: Container(
              color: botBackgroundColor,
              child: IconButton(
                icon: const Icon(
                  Icons.send_rounded,
                  color: Color.fromRGBO(142, 142, 160, 1),
                ),
                onPressed: () async {
                  if (_focusNode.hasFocus) {
                    _focusNode.unfocus();
                  }
                  final t = _textEditingController.text;
                  _textEditingController.clear();
                  chatProvider.addToChatList(
                      ChatModel(message: t, type: ChatType.user));
                  await Future.delayed(const Duration(milliseconds: 50))
                      .then((value) => _scrollDown());
                  final c = await ApiCall.generateResponse(t);
                  chatProvider
                      .addToChatList(ChatModel(message: c, type: ChatType.bot));
                  await Future.delayed(const Duration(milliseconds: 50))
                      .then((value) => _scrollDown());
                },
              ),
            ))
      ],
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 50), curve: Curves.easeIn);
  }

  Widget _buildChatBody() {
    return Expanded(
        child: ListView.builder(
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      itemCount: chatProvider.chatList.length,
      itemBuilder: (context, index) {
        final chat = chatProvider.chatList[index];
        return ChatMessageItem(
          chatModel: chat,
        );
      },
    ));
  }

  Future<bool> _onWillPop() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text('Do you want to exit an App'),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                ElevatedButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                )
              ],
            );
          },
        ) ??
        false;
  }
}
