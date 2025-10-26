import 'package:flutter/material.dart';
import 'package:google/constants.dart';
import 'package:google/features/search/presentation/views/widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: kPrimaryColor),
      body: SearchViewBody(),
    );
  }
}
