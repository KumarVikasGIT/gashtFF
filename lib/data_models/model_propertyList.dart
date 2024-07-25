import 'package:gasht/data_models/reviewModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'model_propertyList.g.dart';


@JsonSerializable()
class Property {
  Property({
    required this.id,
    required this.landOnwerId,
    required this.ownerid,
    required this.propertyName,
    required this.propertyDescription,
    required this.area,
    required this.livingroom,
    required this.livDescription,
    required this.bedroom,
    required this.bedDescription,
    required this.kitchen,
    required this.kitDescription,
    required this.washroom,
    required this.washDescription,
    required this.pool,
    required this.poolDescription,
    required this.price,
    required this.discountedPrice,
    required this.timeline,
    required this.discount,
    required this.pricepernight,
    required this.discountedPricepernight,
    required this.totalPrice,
    required this.totalDiscountedPrice,
    required this.serviceFee,
    required this.state,
    required this.city,
    required this.longitude,
    required this.latitude,
    required this.propertyType,
    required this.tenentType,
    required this.terms,
    required this.cancellationPolicy,
    required this.avgRating,
    required this.wishlist,
    required this.reviewed,
    required this.images,
    required this.reviews,
  });

  final int? id;
  static const String idKey = "id";

  final int? landOnwerId;
  static const String landOnwerIdKey = "landOnwerId";

  final String? ownerid;
  static const String owneridKey = "ownerid";

  final String? propertyName;
  static const String propertyNameKey = "propertyName";

  final String? propertyDescription;
  static const String propertyDescriptionKey = "propertyDescription";

  final String? area;
  static const String areaKey = "area";

  final String? livingroom;
  static const String livingroomKey = "livingroom";

  final String? livDescription;
  static const String livDescriptionKey = "livDescription";

  final String? bedroom;
  static const String bedroomKey = "bedroom";

  final String? bedDescription;
  static const String bedDescriptionKey = "bedDescription";

  final String? kitchen;
  static const String kitchenKey = "kitchen";

  final String? kitDescription;
  static const String kitDescriptionKey = "kitDescription";

  final String? washroom;
  static const String washroomKey = "washroom";

  final String? washDescription;
  static const String washDescriptionKey = "washDescription";

  final String? pool;
  static const String poolKey = "pool";

  final String? poolDescription;
  static const String poolDescriptionKey = "poolDescription";

  final String? price;
  static const String priceKey = "price";


  @JsonKey(name: 'discounted_price')
  final String? discountedPrice;
  static const String discountedPriceKey = "discounted_price";

  final String? timeline;
  static const String timelineKey = "timeline";

  final String? discount;
  static const String discountKey = "discount";

  final String? pricepernight;
  static const String pricepernightKey = "pricepernight";


  @JsonKey(name: 'discounted_pricepernight')
  final String? discountedPricepernight;
  static const String discountedPricepernightKey = "discounted_pricepernight";


  @JsonKey(name: 'total_price')
  final String? totalPrice;
  static const String totalPriceKey = "total_price";


  @JsonKey(name: 'total_discounted_price')
  final String? totalDiscountedPrice;
  static const String totalDiscountedPriceKey = "total_discounted_price";


  @JsonKey(name: 'service_fee')
  final String? serviceFee;
  static const String serviceFeeKey = "service_fee";

  final String? state;
  static const String stateKey = "state";

  final String? city;
  static const String cityKey = "city";

  final double? longitude;
  static const String longitudeKey = "longitude";

  final double? latitude;
  static const String latitudeKey = "latitude";

  final String? propertyType;
  static const String propertyTypeKey = "propertyType";

  final String? tenentType;
  static const String tenentTypeKey = "tenentType";

  final String? terms;
  static const String termsKey = "terms";

  final String? cancellationPolicy;
  static const String cancellationPolicyKey = "cancellationPolicy";

  final String? avgRating;
  static const String avgRatingKey = "avgRating";

  final bool? wishlist;
  static const String wishlistKey = "wishlist";

  final bool? reviewed;
  static const String reviewedKey = "reviewed";

  final List<String>? images;
  static const String imagesKey = "images";
  final List<ReviewModel>? reviews;
  static const String reviewsKey = "reviews";


  factory Property.fromJson(Map<String, dynamic> json) => _$PropertyFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyToJson(this);

}
