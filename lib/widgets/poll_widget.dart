import 'package:aadj/globals.dart';
import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart';

class MastodonPoll extends StatefulWidget {
  final String statusId;
  final String pollId;

  MastodonPoll({required this.statusId, required this.pollId});

  @override
  _MastodonPollState createState() => _MastodonPollState();
}

class _MastodonPollState extends State<MastodonPoll> {
  //late Status _status;
  late Poll _poll;
  List<PollOption> _options = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchStatus();
  }

  Future<void> _fetchStatus() async {
    try {
      //_status = (await mstdn.v1.statuses.lookupPoll(pollId: widget)) as Status;
      _poll = (await mstdn.v1.statuses.lookupPoll(pollId: widget.pollId)) as Poll;
      _options = _poll.options.map((option) {
        return PollOption(title: option.title, votesCount: option.votesCount);
      }).toList()?? [];
      setState(() {
        _loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
      });
    }
  }

  void _vote(PollOption option) async {
    try {
      await mstdn.v1.statuses.createVote(pollId: widget.pollId, choice: _poll.options.indexOf(option));
      _fetchStatus();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Text('todo vote'); //todo vote build
    //todo add multiple votes
    // return _loading
    //     ? Center(child: CircularProgressIndicator())
    //     : Poll(
    //   options: _options,
    //   question: _status.poll?.question?? '',
    //   onVote: _vote,
    // );
  }
}