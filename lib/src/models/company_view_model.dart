class CompanyUI {
  final String id;
  String name;
  String imageUrl;
  String description;

  CompanyUI({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
  });

  factory CompanyUI.fromJson(Map<String, dynamic> json) {
    return CompanyUI(
      id: json['company_id'],
      name: json['company_name'],
      imageUrl: json['company_image_url'],
      description: json['company_description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_id': id,
      'company_name': name,
      'company_image_url': imageUrl,
      'company_description': description,
    };
  }
}
