import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart';

class MastodonPostWidget extends StatelessWidget {
  final Status status;

  const MastodonPostWidget({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  status.account.displayName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  status.createdAt.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              status.content,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            if (status.mediaAttachments.isNotEmpty)
              Column(
                children: status.mediaAttachments
                    .map((media) => Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Image.network(
                            media.url,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ))
                    .toList(),
              ),
            if (status.mentions.isNotEmpty)
              Column(
                children: status.mentions
                    .map((mention) => Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text(
                            "@${mention.acount.username}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}
