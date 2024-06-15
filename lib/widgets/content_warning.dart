import 'package:flutter/material.dart';
import 'post_view.dart';

class ContentWarning extends StatefulWidget {
  final String text;

  const ContentWarning({super.key, required this.text});

  @override
  _ContentWarningState createState() => _ContentWarningState();
}

class _ContentWarningState extends State<ContentWarning> {
  bool _showWarning = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(1),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.text,
            style: const TextStyle(color: Colors.black, fontSize: 24),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showWarning = false;
              });
            },
            child: const Text('Show'),
          ),
        ],
      ),
    );
  }
}
