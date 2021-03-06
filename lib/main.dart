import 'package:chat_app_30/chatbox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) {
        return ChatBox();
      },
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatelessWidget {
  const ChatPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ClipRRect(
          child: Image.network('https://picsum.photos/50/50'),
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: Colors.blue.shade50,
        child: Column(
          children: [
            Expanded(
              child: Consumer<ChatBox>(
                builder: (context, chatbox, child) {
                  return ListView(
                    padding: EdgeInsets.only(bottom: 16),
                    reverse: true,
                    children: [
                      if (chatbox.chats.isNotEmpty)
                        MyChatBubble(
                          message: '${chatbox.chats.last}',
                        ),
                      IncomingChatBubble(),
                    ],
                  );
                },
              ),
            ),
            Container(
              color: Colors.white,
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Type message...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_circle,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        var chatBox = context.read<ChatBox>();
                        chatBox.addChat(DateTime.now().toIso8601String());
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyChatBubble extends StatelessWidget {
  final String message;
  const MyChatBubble({
    Key key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              child: Text(
                '$message',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      offset: Offset(2, 3),
                      blurRadius: 3,
                      spreadRadius: 0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                'Delivered',
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class IncomingChatBubble extends StatelessWidget {
  const IncomingChatBubble({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              child: Text(
                'Thank you',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              decoration: BoxDecoration(
                  color: Colors.purple.shade900,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      offset: Offset(2, 3),
                      blurRadius: 3,
                      spreadRadius: 0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                'Delivered',
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            )
          ],
        ),
      ],
    );
  }
}
