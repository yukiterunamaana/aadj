import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart';

import '../globals.dart';

class BookmarkButton extends StatefulWidget {
  final MastodonApi mastodon;
  final String statusId;
  final bool? isBookmarked;

  BookmarkButton({
    super.key,
    required this.mastodon,
    required this.statusId,
    required this.isBookmarked,
  });

  @override
  _BookmarkButtonState createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  late bool _isBookmarked;

  @override
  void initState() {
    super.initState();
    _isBookmarked = widget.isBookmarked ?? false;
  }

  Future<void> _toggleBookmark() async {
    try {
      if (_isBookmarked) {
        await widget.mastodon.v1.statuses
            .destroyBookmark(statusId: widget.statusId);
      } else {
        await widget.mastodon.v1.statuses
            .createBookmark(statusId: widget.statusId);
      }
      setState(() {
        _isBookmarked = !_isBookmarked;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error toggling bookmark: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _isBookmarked
          ? Icon(
              Icons.bookmark,
              color: activatedReactionColor,
            )
          : Icon(Icons.bookmark_outline),
      onPressed: _toggleBookmark,
    );
  }
}
