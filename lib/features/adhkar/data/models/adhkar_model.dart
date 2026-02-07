class AdhkarModel {
  final String category;
  final String count;
  final String description;
  final String reference;
  final String content;

  AdhkarModel({
    required this.category,
    required this.count,
    required this.description,
    required this.reference,
    required this.content,
  });

  factory AdhkarModel.fromJson(Map<String, dynamic> json) {
    return AdhkarModel(
      category: json['category'] ?? '',
      count: json['count'] ?? '1',
      description: json['description'] ?? '',
      reference: json['reference'] ?? '',
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'count': count,
      'description': description,
      'reference': reference,
      'content': content,
    };
  }
}
