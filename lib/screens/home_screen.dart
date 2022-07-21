import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cpd/widgets/app_bars/home_app_bar.dart';
import 'package:cpd/widgets/content_area.dart';
import 'package:cpd/widgets/lists/list_view_separator.dart';
import 'package:cpd/widgets/lists/module_learning/module_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                const HomeAppBar(),
                Expanded(
                  child: ContentArea(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("modules")
                          .orderBy("name")
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text("Something went wrong");
                        }

                        if (!snapshot.hasData) {
                          return const Text("There are no modules to show");
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: LinearProgressIndicator(),
                          );
                        }

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) =>
                              const ListViewSeparator(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            QueryDocumentSnapshot document =
                                snapshot.data!.docs[index];
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            return ModuleItem(
                              documentId: document.id,
                              reference: document.reference,
                              data: data,
                            );
                          },
                        );
                      },
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
