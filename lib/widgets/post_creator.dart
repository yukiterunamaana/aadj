import 'package:aadj/globals.dart';
import 'package:aadj/instance_settings.dart';
import 'package:flutter/material.dart';
import 'package:mastodon_api/mastodon_api.dart';

// Define the custom emoji keyboard
//import 'emoji_keyboard.dart';

class ComposeStatusWidget extends StatefulWidget {
  @override
  _ComposeStatusWidgetState createState() => _ComposeStatusWidgetState();
}

class _ComposeStatusWidgetState extends State<ComposeStatusWidget> {
  //final _formKey = GlobalKey<FormState>();
  final _statusController = TextEditingController();
  // final _visibilityController = TextEditingController();
  // final _languageController = TextEditingController();
  // final _mediaController = TextEditingController();
  // final _pollController = TextEditingController();
  //final _spoilerTextController = TextEditingController();

  // // Initialize the visibility options
  // // Initialize the language options

  // Initialize the media and poll options
  bool _hasMedia = false;
  bool _hasPoll = false;

  // Initialize the spoiler text option
  bool _hasSpoilerText = false;

  //int remainingCharacters = maxCharacters;

  @override
  Widget build(BuildContext context) {
    return //const CircularProgressIndicator();
        Column(
      children: [
        TextFormField(
          controller: _statusController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a status';
            }
            return null;
          },
          onChanged: (text) {
            setState(() {
              //remainingCharacters = maxCharacters - text.length;
            });
          },
        ),
        // Visibility dropdown
        // // Language dropdown
        // // Media upload button
        // Poll creation button
        // Spoiler text checkbox
        // Spoiler text field
        // Custom emoji keyboard
        // Publish button

        Row(
          children: [
            ElevatedButton(
                child: const Text('Publish'),
                onPressed: () async {
                  try {
                    final response = await mstdn.v1.statuses
                        .createStatus(text: _statusController.text);

                    if (response.status.code == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Status published')),
                      );

                      _statusController.clear();
                      // _visibilityController.text = 'public';
                      // _languageController.text = 'en';
                      // _mediaController.clear();
                      // _pollController.clear();
                      //_spoilerTextController.clear();
                      setState(() {
                        _hasMedia = false;
                        _hasPoll = false;
                        _hasSpoilerText = false;
                      });
                    } else {
                      // Show an error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Failed to publish status:')),
                      );
                    }
                    print(response.rateLimit);
                    print(response.data);
                  } on UnauthorizedException catch (e) {
                    print(e);
                  } on RateLimitExceededException catch (e) {
                    print(e);
                  } on MastodonException catch (e) {
                    print(e.response);
                    print(e.body);
                    print(e);
                  }
                  // Create a new status with the selected options
                  final status = mstdn.v1.statuses
                      .createStatus(text: _statusController.text);
                }),
            Text('500' /*remainingCharacters.toString()*/),
          ],
        )
      ],
    );
  }
}