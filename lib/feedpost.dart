import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomFeedPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_outlined),
        title: const Text("Custom Title"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('custom_collection').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          List<DocumentSnapshot> documents = snapshot.data!.docs;
          List<String> imageUrls = [];
          List<String> descriptions = [];
          List<String> locations = [];

          for (var document in documents) {
            imageUrls.add(document['photoUrl']);
            descriptions.add(document['description']);
            locations.add(document['location']);
          }

          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return CustomReelPage(
                imageUrl: imageUrls[index],
                description: descriptions[index],
                location: locations[index],
              );
            },
          );
        },
      ),
    );
  }
}

class CustomReelPage extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String location;

  CustomReelPage({
    required this.imageUrl,
    required this.description,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            description,
            style: const TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Location: $location',
            style: const TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              joinCustomCleaningDrive(context);
            },
            child: const Text('Join the custom cleaning drive'),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
void joinCustomCleaningDrive(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Success'),
        content: Text(
            'You have successfully joined the custom cleaning drive. Now you can contact other people participating in this drive and aim for cleaning and recycling.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
