// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoryModel {
  final String name;
  final String? image;
  final String description;
  final double? perHourRate;
  String id;

  CategoryModel({
    required this.name,
    this.image,
    required this.description,
    this.perHourRate,
    required this.id,
  });

static CategoryModel empty() {
    return CategoryModel(
      name: '',
      image: '',
      description: '',
      perHourRate: 0.0,
      id: '',
    );
  }
 
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    if (image != null) {
      result.addAll({'image': image});
    }
    result.addAll({'description': description});
    if (perHourRate != null) {
      result.addAll({'perHourRate': perHourRate});
    }
    result.addAll({'id': id});

    return result;
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['name'] ?? '',
      image: map['image'],
      description: map['description'] ?? '',
      perHourRate: map['perHourRate']?.toDouble(),
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CategoryModel(name: $name, image: $image, description: $description, perHourRate: $perHourRate, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryModel &&
        other.name == name &&
        other.image == image &&
        other.description == description &&
        other.perHourRate == perHourRate &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        image.hashCode ^
        description.hashCode ^
        perHourRate.hashCode ^
        id.hashCode;
  }

  
  CategoryModel copyWith({
    String? name,
    String? image,
    String? description,
    double? perHourRate,
    String? id,
  }) {
    return CategoryModel(
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      perHourRate: perHourRate ?? this.perHourRate,
      id: id ?? this.id,
    );
  }

  static List<CategoryModel> dummyData = [
    CategoryModel(
      id: '',
        name: 'Building & Construction',
        image:
            'https://majuba.edu.za/wp-content/uploads/2018/12/majuba-civil-4.jpg',
        description: 'Any building or construction related services',
        perHourRate: 100.00),
    CategoryModel(
      id: '',
        name: 'Cleaning & Laundry',
        image:
            'https://cf.ltkcdn.net/cleaning/images/std/257114-800x515r1-how-properly-do-laundry.webp',
        description: 'Any cleaning or laundry related services',
        perHourRate: 72.00),
    CategoryModel(
      id: '',
        name: 'Electrical & Electronics',
        image:
            'https://www.iit.edu.ng/storage/Pictures%20/Programmes/Electrotechncis%201.png',
        description: 'Any electrical or electronics related services',
        perHourRate: 120.00),
    CategoryModel(
      id: '',
        name: 'Mechanics & Auto',
        image:
            'https://res.cloudinary.com/hkf2ycaep/image/fetch/d_project-placeholder.png,f_auto,fl_lossy/https://d23vk1trp0fmbf.cloudfront.net/projects/44b55e8a-e7c8-404c-be4e-caf1c97c5d5b/project-image',
        description: 'Any mechanics or auto related services',
        perHourRate: 150.00),
    CategoryModel(
      id: '',
        name: 'Plumbing & Water',
        image:
            'https://media.istockphoto.com/id/665043432/photo/plumber-repairing-a-sink.jpg?s=612x612&w=0&k=20&c=rRfckKtMkg8Xn49oUPOzdafqC8r9ObOfelstMbjgsfQ=',
        description: 'Any plumbing or water related services',
        perHourRate: 80.00),
    CategoryModel(
      id: '',
        name: 'Woodwork & Carpentry',
        image:
            'https://www.familyhandyman.com/wp-content/uploads/2022/10/GettyImages-1391067760.jpg?resize=700,467',
        description: 'Any woodwork or carpentry related services',
        perHourRate: 90.00),
    CategoryModel(
      id: '',
        name: 'Painting & Decoration',
        image:
            'https://tradesmencosts.co.uk/wp-content/uploads/2020/05/painter-decorator-working.jpg',
        description: 'Any painting or decoration related services',
        perHourRate: 100.00),
    CategoryModel(
      id: '',
        name: 'Gardening & Landscaping',
        image:
            'https://www.neponset.org/wp-content/uploads/2019/01/black-man-garden_landscape-1024x683.jpg',
        description: 'Any gardening or landscaping related services',
        perHourRate: 80.00),
    CategoryModel(
      id: '',
        name: 'Furniture & Fixtures',
        image:
            'https://www.ghanaskills.org/sites/default/files/inline-images/Rwanda-DED-Dirk-Gebhardt-147%20Furniture%20Work.jpg',
        description: 'Any furniture or fixtures related services',
        perHourRate: 100.00),
    CategoryModel(
      id: '',
        name: 'Fashion & Beauty',
        image:
            'https://ghanainsider.com/wp-content/uploads/2020/04/1578510803_maxresdefault.webp',
        description: 'Any fashion or beauty related services',
        perHourRate: 100.00),
  ];

}
