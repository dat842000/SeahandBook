import 'dart:ffi';

class HierarchyItem {
  final String id;
  final String key;
  final String title;
  final bool publish;
  final List<HierarchyItem> children;

  HierarchyItem({
    required this.id,
    required this.key,
    required this.title,
    required this.publish,
    required this.children,
  });

  factory HierarchyItem.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final key = json['key'] as String;
    final title = json['title'] as String;
    final publish = json['publish'] as bool;

    List<dynamic> childrenJson = json['children'] ?? [];
    List<HierarchyItem> children = childrenJson.map((childJson) => HierarchyItem.fromJson(childJson)).toList();

    return HierarchyItem(
      id: id,
      key: key,
      title: title,
      publish: publish,
      children: children,
    );
  }
}