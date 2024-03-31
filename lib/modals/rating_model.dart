import 'package:hive/hive.dart';
part 'rating_model.g.dart';

@HiveType(typeId: 2)
class RatingModel {
  @HiveField(0)
  double rating;

  @HiveField(1)
  final String uid;

  RatingModel({required this.rating, required this.uid});

  @override
  factory RatingModel.fromMap(Map<String, dynamic> data) {
    return RatingModel(
        rating: data.containsKey('rating')
            ? double.parse(data['rating'].toString())
            : 0.0,
        uid: data.containsKey('uid') ? data['uid'] : '');
  }
  Map<String, dynamic> toMap() {
    return {
      'rating': rating,
      'uid': uid,
    };
  }
}
