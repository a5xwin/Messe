import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:messe/themes/theme_provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    // 💡 Compute the bubble color once so both the box and tail match:
    final Color bubbleColor = isCurrentUser
        ? Colors.lightGreen
        : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade400);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
      child: Stack(
        children: [
          // Main bubble content
          Container(
            decoration: BoxDecoration(
              color: bubbleColor, // ← use the computed color
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft:
                    isCurrentUser ? const Radius.circular(12) : Radius.zero,
                bottomRight:
                    isCurrentUser ? Radius.zero : const Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.all(17),
            child: Text(
              message,
              style: TextStyle(
                color: isCurrentUser
                    ? Colors.white
                    : (isDarkMode ? Colors.white : Colors.white),
              ),
            ),
          ),

          // Tail now uses the same bubbleColor:
          Positioned(
            bottom: 0,
            left: isCurrentUser ? null : -5,
            right: isCurrentUser ? -5 : null,
            child: CustomPaint(
              size: const Size(15, 10),
              painter: _BubbleTailPainter(
                color: bubbleColor,      // ← changed here
                isCurrentUser: isCurrentUser,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BubbleTailPainter extends CustomPainter {
  final Color color;
  final bool isCurrentUser;

  const _BubbleTailPainter({
    required this.color,
    required this.isCurrentUser,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    if (isCurrentUser) {
      path.moveTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
    } else {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
