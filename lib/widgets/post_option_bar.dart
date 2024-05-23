// import 'dart:ui';
//
// import 'package:flutter/material.dart';
//
// class PostOptionsRow extends StatelessWidget {
//   final bool hasMedia;
//   final bool hasPoll;
//   final bool hasContentWarning;
//   // final bool hasVisibilitySelector;
//   // final bool hasLanguageSelector;
//   final int remainingCharacters;
//   final VoidCallback onMediaTap;
//   final VoidCallback onPollTap;
//   final VoidCallback onEmojiKeyboardTap;
//   final VoidCallback onContentWarningTap;
//   final VoidCallback onVisibilitySelectorTap;
//   final VoidCallback onLanguageSelectorTap;
//
//   const PostOptionsRow({
//     Key? key,
//     this.hasMedia = false,
//     this.hasPoll = false,
//     //required this.hasEmojiKeyboard,
//     this.hasContentWarning = false,
//     //required this.hasVisibilitySelector,
//     //required this.hasLanguageSelector,
//     // required this.remainingCharacters,
//     // required this.onMediaTap,
//     // required this.onPollTap,
//     // required this.onEmojiKeyboardTap,
//     // required this.onContentWarningTap,
//     // required this.onVisibilitySelectorTap,
//     // required this.onLanguageSelectorTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             // IconButton(
//             //   icon:
//             Icon(Icons.image),
//             //   onPressed: hasMedia ? null : onMediaTap,
//             // ),
//             // IconButton(
//             //   icon:
//             Icon(Icons.poll),
//             //   onPressed: hasPoll ? null : onPollTap,
//             // ),
//             // IconButton(
//             //   icon:
//             Icon(Icons.emoji_emotions),
//             //   onPressed: hasEmojiKeyboard ? null : onEmojiKeyboardTap,
//             // ),
//             // IconButton(
//             //   icon:
//             Icon(Icons.warning),
//             //   onPressed: hasContentWarning ? null : onContentWarningTap,
//             // ),
//           ],
//         ),
//         // Row(
//         //   children: [
//         //     if (hasVisibilitySelector)
//         //       IconButton(
//         //         icon: Icon(Icons.visibility),
//         //         onPressed: onVisibilitySelectorTap,
//         //       ),
//         //     if (hasLanguageSelector)
//         //       IconButton(
//         //         icon: Icon(Icons.language),
//         //         onPressed: onLanguageSelectorTap,
//         //       ),
//         //   ],
//         // ),
//         Text('${remainingCharacters} / 500'),
//       ],
//     );
//   }
// }
