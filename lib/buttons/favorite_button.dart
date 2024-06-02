import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart';

import '../core/globals.dart';

class FavoriteButton extends StatefulWidget {
  final MastodonApi mastodon;
  final String statusId;
  final bool? isFavourited;

  const FavoriteButton({
    super.key,
    required this.mastodon,
    required this.statusId,
    required this.isFavourited,
  });

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool _isFavourited;

  @override
  void initState() {
    super.initState();
    _isFavourited = widget.isFavourited ?? false;
  }

  Future<void> _toggleFavorite() async {
    try {
      if (_isFavourited) {
        await widget.mastodon.v1.statuses
            .destroyFavourite(statusId: widget.statusId);
      } else {
        await widget.mastodon.v1.statuses
            .createFavourite(statusId: widget.statusId);
      }
      setState(() {
        _isFavourited = !_isFavourited;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error toggling favorite: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _isFavourited
          ? Icon(
              Icons.favorite,
              color: activatedReactionColor,
            )
          : Icon(Icons.favorite_border),
      onPressed: _toggleFavorite,
    );
  }
}
