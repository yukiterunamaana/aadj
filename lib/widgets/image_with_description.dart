import 'package:flutter/material.dart';

class ImageWithDescription extends StatefulWidget {
  @override
  ImageWithDescriptionState createState() => ImageWithDescriptionState();
}

class ImageWithDescriptionState extends State<ImageWithDescription> {
  late String _imageUrl;
  late String _description;

  @override
  void initState() {
    super.initState();

    //_mastodonApi = MastodonApi('https://mastodon.social');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mastodon Image Description'),
      ),
      body: Center(
        child: Stack(
          children: [
            Image.network(_imageUrl),
            Positioned(
              bottom: 16,
              right: 16,
              child: Visibility(
                visible: _description != "",
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _description,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              child: _description != ""
                  ? SizedBox()
                  : ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(_description),
                        ));
                      },
                      child: Text('Description'),
                    ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _fetchRandomImage,
      //   tooltip: 'Fetch Random Image',
      // ),
    );
  }
}
