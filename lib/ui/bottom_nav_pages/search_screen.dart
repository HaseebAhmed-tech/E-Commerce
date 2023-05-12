import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/database/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/AppColors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

String inputText = "";

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                onChanged: (val) {
                  setState(() {
                    inputText = val;
                    
                  });
                },
                style: const TextStyle(fontSize: 18),
                controller: _searchController,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: AppColors.deepOrange,
                    size: 30.sm,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1.sm, color: AppColors.deepOrange),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2.sm, color: AppColors.deepOrange),
                  ),
                  label: const Text("Search Products"),
                  labelStyle: TextStyle(fontSize: 18.sm),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                cursorColor: AppColors.deepOrange,
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
                child: Container(
                  child: StreamBuilder(
                    stream: Data.getProductsSnapshots()
                        .where("product-name", isEqualTo: inputText)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                     
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Somethig Went Wrong"),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.deepOrange,
                          ),
                        );
                      }
                      return ListView(
                          physics: const BouncingScrollPhysics(),
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                           
                            return ListTile(
                              title: Text(
                                data["product-name"],
                              ),
                              leading: Image.network(
                                data["product-images"][0],
                              ),
                            );
                          }).toList());
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
