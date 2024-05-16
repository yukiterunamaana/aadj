import 'package:aadj/globals.dart';
import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart';

class PollWidget extends StatefulWidget {
  final String statusId;
  final String pollId;

  PollWidget({super.key, required this.pollId, required this.statusId});

  @override
  _PollWidgetState createState() => _PollWidgetState();
}

class _PollWidgetState extends State<PollWidget> {
  late Future<Poll> _poll;
  late bool _hasVoted;
  late bool _pollExpired;

  @override
  void initState() {
    super.initState();
    _poll = _fetchPoll();
  }

  Future<Poll> _fetchPoll() async {
    final poll = await mstdn.v1.statuses.lookupPoll(pollId: widget.pollId);
    setState(() {
      _hasVoted = poll.data.ownVotes!.isNotEmpty;
      _pollExpired = poll.data.isExpired;
    });
    return poll.data;
  }

  Future<void> _vote(int optionIndex) async {
    final account =
        await mstdn.v1.statuses.lookupStatus(statusId: widget.statusId);

    if (account.data.account.toString() == myAccount) {
      throw Exception('You cannot vote in your own poll.');
    }

    if (!_hasVoted && !_pollExpired) {
      await mstdn.v1.statuses
          .createVote(pollId: widget.pollId, choice: optionIndex);
      setState(() {
        _hasVoted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /*..._poll.options.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () {
              _vote(entry.key);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Radio<int>(
                    value: entry.key,
                    groupValue: _hasVoted ? entry.key : null,
                    onChanged: (value) {
                      _vote(value!);
                    },
                  ),
                  Text(entry.value as String),
                ],
              ),
            ),
          );
        }).toList(),*/
        //Text(_poll.expiresAt as String),
      ],
    );
  }
}
