import 'package:sea_handbook/models/hierarchy_item.dart';

class PageHierarchy {
  final String id;
  final List<HierarchyItem> hierarchy;

  PageHierarchy({
    required this.id,
    required this.hierarchy,
  });

  factory PageHierarchy.fromJson(Map<String, dynamic> json) {
    List<dynamic> hierarchyJson = json['hierarchy'] ?? [];
    List<HierarchyItem> hierarchy = hierarchyJson.map((itemJson) => HierarchyItem.fromJson(itemJson)).toList();
    return PageHierarchy(
      id: json['_id'],
      hierarchy: hierarchy,
    );
  }
}