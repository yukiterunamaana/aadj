// import 'package:flutter/material.dart';
// import 'package:mastodon_api/mastodon_api.dart';
//
// import '../globals.dart';
//
// class TimelinePaginationWidget extends StatefulWidget {
//   @override
//   _TimelinePaginationWidgetState createState() =>
//       _TimelinePaginationWidgetState();
// }
//
// class _TimelinePaginationWidgetState extends State<TimelinePaginationWidget> {
//   int _currentPage = 1;
//   String _minId = '';
//   String _maxId = '';
//   List<dynamic> _timelineData = [];
//
//   Future<void> _fetchTimelineData() async {
//     switch (_currentPage) {
//       case 1:
//         _fetchHomeTimeline();
//         break;
//       case 2:
//         _fetchPublicTimeline();
//         break;
//       case 3:
//         _fetchNotificationTimeline();
//         break;
//       case 4:
//         _fetchUserTimeline();
//         break;
//       default:
//         break;
//     }
//   }
//
//   Future<void> _fetchHomeTimeline() async {
//     final response = await mstdn.lookupHomeTimeline(
//       limit: postsPerRequest,
//       minId: _minId,
//       maxId: _maxId,
//     );
//     setState(() {
//       _timelineData.addAll(response);
//       _minId = response.first['id'];
//       _maxId = response.last['id'];
//     });
//   }
//
//   Future<void> _fetchPublicTimeline() async {
//     final response = await mstdn.lookupPublicTimeline(
//       limit: postsPerRequest,
//       minId: _minId,
//       maxId: _maxId,
//     );
//     setState(() {
//       _timelineData.addAll(response);
//       _minId = response.first['id'];
//       _maxId = response.last['id'];
//     });
//   }
//
//   Future<void> _fetchNotificationTimeline() async {
//     final response = await mstdn.lookupNotifications(
//       limit: postsPerRequest,
//       minId: _minId,
//       maxId: _maxId,
//     );
//     setState(() {
//       _timelineData.addAll(response);
//       _minId = response.first['id'];
//       _maxId = response.last['id'];
//     });
//   }
//
//   Future<void> _fetchUserTimeline() async {
//     final response = await mstdn.lookupUserTimeline(
//       userId: 'your_user_id_here',
//       limit: postsPerRequest,
//       minId: _minId,
//       maxId: _maxId,
//     );
//     setState(() {
//       _timelineData.addAll(response);
//       _minId = response.first['id'];
//       _maxId = response.last['id'];
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Mastodon Timeline'),
//       ),
//       body: NotificationListener<ScrollNotification>(
//         onNotification: (notification) {
//           if (notification is ScrollEndNotification) {
//             if (_timelineData.isNotEmpty &&
//                 notification.metrics.pixels >=
//                     notification.metrics.maxScrollExtent * 0.8) {
//               _currentPage++;
//               _fetchTimelineData();
//             }
//           }
//           return true;
//         },
//         child: ListView.builder(
//           itemCount: _timelineData.length,
//           itemBuilder: (context, index) {
//             final status = _timelineData[index];
//             return Card(
//               child: ListTile(
//                 title: Text(status['content']),
//                 subtitle: Text(status['created_at']),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
