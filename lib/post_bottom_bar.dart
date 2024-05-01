import 'package:aadj/bookmark_button.dart';
import 'package:aadj/favorite_button.dart';
import 'package:aadj/globals.dart';
import 'package:aadj/reblog_button.dart';
import 'package:aadj/reply_button.dart';
import 'package:flutter/material.dart';

class PostBottomBar extends StatefulWidget {

  final String statusId;
  final bool? isReblogged;
  final bool? isFavourited; //certified Bri'ish moment
  final bool? isBookmarked;
  const PostBottomBar({

    super.key,

    required this.statusId, required this.isReblogged, required this.isFavourited, required this.isBookmarked,
  });


  @override

  _PostBottomBarState createState() => _PostBottomBarState();
}


class _PostBottomBarState extends State<PostBottomBar> {
  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //   onTap: () {
    //     setState(() {
    //       _isReacted = !_isReacted;
    //       if (widget.reactionType == ReactionType.favorite) {
    //         _toggleFavorite();
    //       } else if (widget.reactionType == ReactionType.boost) {
    //         _toggleBoost();
    //       }
    //     });
    //   },
      return Row(
        children: [
          //ReplyButton(mastodon: mstdn, statusId: widget.statusId),
          ReblogButton(mastodon: mstdn, statusId: widget.statusId, isReblogged: widget.isReblogged),
          FavoriteButton(mastodon: mstdn, statusId: widget.statusId, isFavourited: widget.isFavourited),
          BookmarkButton(mastodon: mstdn, statusId: widget.statusId, isBookmarked: widget.isBookmarked),
          //todo additional menu
          const Icon(Icons.menu_rounded),
        ],
        // Icon(
        //   _isReacted ? Icons.favorite : Icons.favorite_border,
        //   color: _isReacted ? activatedReactionColor : null,
        // ),
        //
        // Icon(
        //   _isReacted ? Icons.repeat : Icons.repeat_outlined,
        //   color: _isReacted ? activatedReactionColor : null,
        // ),
    );
  }
}