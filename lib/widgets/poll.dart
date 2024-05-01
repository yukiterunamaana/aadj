import 'package:flutter/material.dart';

class PollOption {
  String text;
  int votes;

  PollOption({required this.text, this.votes = 0});
}

class Poll extends StatefulWidget {
  final List<PollOption> options;
  final String question;
  final Function(PollOption) onVote;

  Poll({required this.options, required this.question, required this.onVote});

  @override
  _PollState createState() => _PollState();
}

class _PollState extends State<Poll> {
  int _totalVotes = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.question,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ...widget.options.map((option) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      option.text,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Text(
                    '${option.votes} votes',
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: Icon(Icons.radio_button_off_rounded),
                    onPressed: () {
                      widget.onVote(option);
                      setState(() {
                        _totalVotes += 1;
                      });
                    },
                    selectedIcon: Icon(Icons.radio_button_checked_rounded),
                  ),
                ],
              ),
              Divider(),
            ],
          );
        }).toList(),
        Text(
          '_Total votes: $_totalVotes',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}