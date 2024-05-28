import 'package:aadj/widgets/post_view.dart';
import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart';

import '../globals.dart';

// class ThreadWidget extends StatelessWidget {
//   final StatusWidget statusWidget;
//
//   ThreadWidget({super.key, required this.statusWidget});
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<StatusContext>(
//       future: mstdn.v1.statuses.lookupStatusContext(statusId: statusWidget),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           StatusContext statusContext = snapshot.data!;
//           return Column(
//             children: [
//               StatusWidget(statusId: statusContext.status.id),
//               ...statusContext.replies.map((reply) => StatusWidget(statusId: reply.id)).toList(),
//             ],
//           );
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           return const Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }

class StatusContextWidget extends StatefulWidget {
  final String statusId;

  StatusContextWidget({super.key, required this.statusId});

  @override
  _StatusContextWidgetState createState() => _StatusContextWidgetState();
}

class _StatusContextWidgetState extends State<StatusContextWidget> {
  late Future<StatusContext> _futureStatusContext;

  @override
  void initState() {
    super.initState();
    _futureStatusContext = _fetchStatusContext();
  }

  Future<StatusContext> _fetchStatusContext() async {
    try {
      final response = await mstdn.v1.statuses
          .lookupStatusContext(statusId: widget.statusId);
      return response.data;
    } on MastodonException catch (e) {
      print(e.toString());
      return Future.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<StatusContext>(
        future: _futureStatusContext,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            StatusContext statusContext = snapshot.data!;
            return ListView(
              children: [
                // Display ancestors
                ...statusContext.ancestors
                    .map((ancestor) => StatusWidget(statusId: ancestor.id)),

                // Display the status itself
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 3,
                    ),
                  ),
                  child: StatusWidget(
                    statusId: widget.statusId,
                  ),
                ),
                // Display descendants (replies)
                ...statusContext.descendants
                    .map((descendant) => StatusWidget(statusId: descendant.id)),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

// import 'dart:convert';
//
// import 'package:aadj/widgets/post_view.dart';
// import 'package:flutter/material.dart';
// import 'package:mastodon_api/mastodon_api.dart';
//
// import '../globals.dart';
//
// class MastodonPostView extends StatefulWidget {
//   final String statusId;
//
//   MastodonPostView({super.key, required this.statusId});
//
//   @override
//   _MastodonPostViewState createState() => _MastodonPostViewState();
// }
//
// class _MastodonPostViewState extends State<MastodonPostView> {
//   //late Future<StatusContext> context;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadAncestorsAndReplies();
//   }
//
//   void _loadAncestorsAndReplies() async {
//     try {
//       final response = await mstdn.v1.statuses
//           .lookupStatusContext(statusId: widget.statusId);
//       List<String> ancestors = [];
//       List<String> descendants = [];
//
//       for (Status s in response.data.ancestors) {
//         ancestors.add(s.id);
//       }
//       for (Status s in response.data.descendants) {
//         descendants.add(s.id);
//       }
//       print('Ancestors: $ancestors');
//       print('Descendants: $descendants');
//     } on MastodonException catch (e) {
//       print(e);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Mastodon Post'),
//       ),
//       body: ListView(
//         children: [
//           // Display the post
//           StatusWidget(
//             key: widget.key,
//             statusId: widget.statusId,
//           ),
//           //
//           // // Display the ancestors
//           // _ancestors.isEmpty
//           //     ? Container()
//           //     : Column(
//           //         children: [
//           //           Text('Ancestors:'),
//           //           ..._ancestors.map((ancestor) => PostCard(post: ancestor)),
//           //         ],
//           //       ),
//           //
//           // // Display the replies
//           // _replies.isEmpty
//           //     ? Container()
//           //     : Column(
//           //         children: [
//           //           Text('Replies:'),
//           //           ..._replies.map((reply) => PostCard(post: reply)),
//           //         ],
//           //       ),
//         ],
//       ),
//     );
//   }
// }
