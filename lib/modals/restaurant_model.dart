import 'package:hive/hive.dart';
import 'package:quick_eats/modals/rating_model.dart';
part 'restaurant_model.g.dart';

@HiveType(typeId: 1)
class RestaurantModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final List<RatingModel> ratings;

  const RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.ratings,
  });
  @override
  factory RestaurantModel.fromMap(Map<String, dynamic> data) {
    return RestaurantModel(
      id: data.containsKey('id') ? data['id'] : '',
      name: data.containsKey('name') ? data['name'] : '',
      description: data.containsKey('desc') ? data['desc'] : '',
      imageUrl: data.containsKey('image_url') ? data['image_url'] : '',
      ratings: data.containsKey('ratings')
          ? (data['ratings'] as List)
              .map((e) => RatingModel.fromMap(e))
              .toList()
          : [],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'desc': description,
      'image_url': imageUrl,
      'ratings': ratings.map((e) => e.toMap()).toList(),
    };
  }
}
