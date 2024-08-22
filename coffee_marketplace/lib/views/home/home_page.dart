import 'package:coffee_marketplace/viewmodels/banner_view_model.dart';
import 'package:coffee_marketplace/views/home/home_banner.dart';
import 'package:coffee_marketplace/views/home/home_body.dart';
import 'package:coffee_marketplace/views/home/search_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final Future Function() getData;
  const HomePage({super.key, required this.getData});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<BannerViewModel>().getBanners();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSearching = _searchController.text.isNotEmpty;
    final String searchText = _searchController.text.toLowerCase().trim();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchSection(
            controller: _searchController,
            onSearch: () => setState(() {}),
          ),
          HomeBanner(isSearching: isSearching),
          HomeBody(
            getData: widget.getData,
            searchText: searchText,
          ),
        ],
      ),
    );
  }
}
