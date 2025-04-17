// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      price: json['price'] as num,
      rating: (json['rating'] as num).toDouble(),
      thumbnail: json['thumbnail'] as String,
      category: json['category'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'rating': instance.rating,
      'thumbnail': instance.thumbnail,
      'category': instance.category,
      'tags': instance.tags,
    };

ProductModelResponse _$ProductModelResponseFromJson(
        Map<String, dynamic> json) =>
    ProductModelResponse(
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductModelResponseToJson(
        ProductModelResponse instance) =>
    <String, dynamic>{
      'products': instance.products,
    };
