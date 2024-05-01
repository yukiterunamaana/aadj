import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart';

class ReblogButton extends StatefulWidget {
  final MastodonApi mastodon;
  final String statusId;
  final bool isReblogged;

  ReblogButton({
    super.key,
    required this.mastodon,
    required this.statusId,
    required this.isReblogged,
  });

  @override
  _ReblogButtonState createState() => _ReblogButtonState();
}

class _ReblogButtonState extends State<ReblogButton> {
  late bool _isReblogged;

  @override
  void initState() {
    super.initState();
    _isReblogged = widget.isReblogged;
  }

  Future<void> _toggleReblog() async {
    try {
      if (_isReblogged) {
        await widget.mastodon.v1.statuses
            .destroyReblog(statusId: widget.statusId);
      } else {
        await widget.mastodon.v1.statuses
            .createReblog(statusId: widget.statusId);
      }
      setState(() {
        _isReblogged = !_isReblogged;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error toggling reblog: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _isReblogged
          ? Icon(
              Icons.repeat,
              color: Colors.blue,
            )
          : Icon(Icons.repeat_outlined),
      onPressed: _toggleReblog,
    );
  }
}
