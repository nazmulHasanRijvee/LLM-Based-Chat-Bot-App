import 'package:flutter/material.dart';

class ChatInputField extends StatefulWidget {

  final ValueChanged<String> onSend;
  final bool isLoading;
  final String? hinText;
  final IconData? sendIcon;

  const ChatInputField({
    super.key,
    required this.onSend,
    required this.isLoading,
    this.hinText,
    this.sendIcon
  });

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {

  final TextEditingController _controller = TextEditingController();

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty || widget.isLoading) return;
    widget.onSend(text);
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(

    );

  }
}
