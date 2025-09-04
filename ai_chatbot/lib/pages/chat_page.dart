import 'package:flutter/material.dart';
import '../models/message.dart';
import '../services/chat_service.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_input.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(Message(role: 'user', content: text));
      _isLoading = true;
    });

    _controller.clear();

    final botReply = await ChatService.sendMessage(text);

    setState(() {
      _messages.add(Message(role: 'bot', content: botReply));
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Chatbot with OpenRouter')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) =>
                  MessageBubble(message: _messages[index]),
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MessageInput(controller: _controller, onSend: _sendMessage),
          ),
        ],
      ),
    );
  }
}
