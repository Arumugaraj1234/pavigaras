// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..status = json['Code'] as int?
  ..message = json['Message'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'Code': instance.status,
      'Message': instance.message,
    };

RequestOtpDataResponse _$RequestOtpDataResponseFromJson(
        Map<String, dynamic> json) =>
    RequestOtpDataResponse(
      json['Id'] as int?,
      json['Fullname'] as String?,
      json['Phone'] as int?,
      json['Email'] as String?,
      (json['Wallet'] as num?)?.toDouble(),
      json['OTP'] as int?,
    );

Map<String, dynamic> _$RequestOtpDataResponseToJson(
        RequestOtpDataResponse instance) =>
    <String, dynamic>{
      'Id': instance.customerId,
      'Fullname': instance.fullName,
      'Phone': instance.mobileNumber,
      'Email': instance.email,
      'Wallet': instance.walletAmount,
      'OTP': instance.otpCode,
    };

RequestOtpResponse _$RequestOtpResponseFromJson(Map<String, dynamic> json) =>
    RequestOtpResponse(
      json['Data'] == null
          ? null
          : RequestOtpDataResponse.fromJson(
              json['Data'] as Map<String, dynamic>),
    )
      ..status = json['Code'] as int?
      ..message = json['Message'] as String?;

Map<String, dynamic> _$RequestOtpResponseToJson(RequestOtpResponse instance) =>
    <String, dynamic>{
      'Code': instance.status,
      'Message': instance.message,
      'Data': instance.requestOtpDataResponse,
    };

VillageResponse _$VillageResponseFromJson(Map<String, dynamic> json) =>
    VillageResponse(
      json['Id'] as int?,
      json['Name'] as String?,
      json['CityId'] as int?,
      (json['DeliveryCharge'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$VillageResponseToJson(VillageResponse instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.villageName,
      'CityId': instance.cityId,
      'DeliveryCharge': instance.deliveryCharge,
    };

InitResponse _$InitResponseFromJson(Map<String, dynamic> json) => InitResponse(
      (json['Villages'] as List<dynamic>?)
          ?.map((e) => VillageResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['Code'] as int?
      ..message = json['Message'] as String?;

Map<String, dynamic> _$InitResponseToJson(InitResponse instance) =>
    <String, dynamic>{
      'Code': instance.status,
      'Message': instance.message,
      'Villages': instance.villages,
    };

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      json['ProductId'] as int?,
      json['Name'] as String?,
      json['TimeTaken'] as int?,
      json['Icon'] as String?,
      json['Description'] as String?,
      json['ProductSizeId'] as int?,
      json['Size'] as String?,
      (json['ActualRate'] as num?)?.toDouble(),
      (json['SellingRate'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'ProductId': instance.id,
      'Name': instance.name,
      'TimeTaken': instance.preparationTime,
      'Icon': instance.imageLink,
      'Description': instance.description,
      'ProductSizeId': instance.sizeId,
      'Size': instance.sizeDescription,
      'ActualRate': instance.actualRate,
      'SellingRate': instance.sellingRate,
    };

ProductGroupResponse _$ProductGroupResponseFromJson(
        Map<String, dynamic> json) =>
    ProductGroupResponse(
      json['ProductId'] as int?,
      json['Name'] as String?,
      json['TimeTaken'] as int?,
      json['Icon'] as String?,
      json['Description'] as String?,
      (json['ProductSizeList'] as List<dynamic>?)
          ?.map((e) => ProductResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductGroupResponseToJson(
        ProductGroupResponse instance) =>
    <String, dynamic>{
      'ProductId': instance.id,
      'Name': instance.name,
      'TimeTaken': instance.preparationTime,
      'Icon': instance.imageLink,
      'Description': instance.description,
      'ProductSizeList': instance.products,
    };

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    CategoryResponse(
      json['CategoryId'] as int?,
      json['Name'] as String?,
      json['Icon'] as String?,
      (json['ProductList'] as List<dynamic>?)
          ?.map((e) => ProductGroupResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      'CategoryId': instance.id,
      'Name': instance.name,
      'Icon': instance.imageLink,
      'ProductList': instance.productGroups,
    };

ShopResponse _$ShopResponseFromJson(Map<String, dynamic> json) => ShopResponse(
      json['ShopId'] as int?,
      json['ShopName'] as String?,
      json['Icon'] as String?,
      (json['CategoryList'] as List<dynamic>?)
          ?.map((e) => CategoryResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShopResponseToJson(ShopResponse instance) =>
    <String, dynamic>{
      'ShopId': instance.id,
      'ShopName': instance.name,
      'Icon': instance.imageLink,
      'CategoryList': instance.categories,
    };

GetProductsResponse _$GetProductsResponseFromJson(Map<String, dynamic> json) =>
    GetProductsResponse(
      (json['Data'] as List<dynamic>?)
          ?.map((e) => ShopResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['Offers'] as List<dynamic>?)
          ?.map((e) => ProductResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['Populars'] as List<dynamic>?)
          ?.map((e) => ProductResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['Favourites'] as List<dynamic>?)
          ?.map((e) => ProductResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['Code'] as int?
      ..message = json['Message'] as String?;

Map<String, dynamic> _$GetProductsResponseToJson(
        GetProductsResponse instance) =>
    <String, dynamic>{
      'Code': instance.status,
      'Message': instance.message,
      'Data': instance.shops,
      'Offers': instance.offerProducts,
      'Populars': instance.popularProducts,
      'Favourites': instance.favoriteProducts,
    };
