class Page {
  final String id;
  final String title;
  final String content;
  final String? css;

  Page({
    required this.id,
    required this.title,
    required this.content,
    this.css,
  });

  factory Page.fromJson(Map<String, dynamic> json) {
    final id = json['_id'] as String;
    final content = json['content'] as String;
    final title = json['title'] as String;
    final css = json['css'] as String?;

    return Page(
      id: id,
      title: title,
      content: content,
      css: css,
    );
  }
}