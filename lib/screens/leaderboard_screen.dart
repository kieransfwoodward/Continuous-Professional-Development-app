import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cpd/widgets/app_bars/leaderboard_app_bar.dart';
import 'package:cpd/widgets/content_area.dart';
import 'package:cpd/widgets/lists/leaderboard_item.dart';
import 'package:cpd/widgets/lists/list_view_separator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//TODO: Finish this screen

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<LeaderboardItem> _items = [];
  bool _isLoading = true;

  // Gets the leaderboard data
  Future<void> _getLeaderboardData() async {
    // First get their profile information
    await FirebaseFirestore.instance.collection("users").orderBy('current_points').get().then(
      (querySnapshot) async {
        for (DocumentSnapshot doc in querySnapshot.docs) {
          late String? docId, name, profileUrl;
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          docId = doc.id;
          name = data["full_name"];
          profileUrl = data["profile_url"];

          // Then get their progress information
            // Create a leaderboard item and add it to the list
            _items.add(
              LeaderboardItem(
                imageUrl: profileUrl ?? "",
                name: name ?? "Unknown user",
                level: data["level"] ?? 1,
                points: data["current_points"] ?? 0,
                currentUser: docId == FirebaseAuth.instance.currentUser!.uid,
              ),
            );
        }
      },
    );
  }

  // Sort the leaderboard by the points per leaderboard item
  Future<void> _sortLeaderboardData() async {
    _items.sort(
      (a, b) => a.points.compareTo(b.points),
    );
  }

  // Update the list on the new ordering
  Future<void> _updateList() async {
    setState(() {
      // Temporary list
      _items = _items.reversed.toList();
      List<LeaderboardItem> tempItems = [];
      for (int i = 0; i < _items.length; i++) {
        LeaderboardItem item = _items.elementAt(i);
        // Create a temporary leaderboard item with the updated position
        LeaderboardItem tempItem = LeaderboardItem(
          imageUrl: item.imageUrl,
          name: item.name,
          level: item.level,
          points: item.points,
          currentUser: item.currentUser,
          position: i + 1,
        );
        tempItems.add(tempItem);
      }
      // Create the final list and stop showing the loading indicator
      _items = tempItems;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getLeaderboardData()
        .then((value) => _sortLeaderboardData())
        .then((value) => _updateList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const LeaderboardAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    child:ContentArea(
                    child: _isLoading
                        ? const LinearProgressIndicator()
                        : _items.isEmpty
                            ? const Text("There is no user activity to show")
                            : ListView.separated(
                                //reverse: true,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) =>
                                    const ListViewSeparator(),
                                itemCount: _items.length,
                                itemBuilder: (BuildContext ctx, int i) =>
                                    _items[i],
                              ),
                  ),
                ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
