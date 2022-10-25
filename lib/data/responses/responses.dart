import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "Code")
  int? status;
  @JsonKey(name: "Message")
  String? message;
}

@JsonSerializable()
class RequestOtpDataResponse {
  @JsonKey(name: "Id")
  int? customerId;
  @JsonKey(name: "Fullname")
  String? fullName;
  @JsonKey(name: "Phone")
  int? mobileNumber;
  @JsonKey(name: "Email")
  String? email;
  @JsonKey(name: "Wallet")
  double? walletAmount;
  @JsonKey(name: "OTP")
  int? otpCode;

  RequestOtpDataResponse(this.customerId, this.fullName, this.mobileNumber,
      this.email, this.walletAmount, this.otpCode);

  factory RequestOtpDataResponse.fromJson(Map<String, dynamic> json) =>
      _$RequestOtpDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RequestOtpDataResponseToJson(this);
}

@JsonSerializable()
class RequestOtpResponse extends BaseResponse {
  @JsonKey(name: "Data")
  RequestOtpDataResponse? requestOtpDataResponse;

  RequestOtpResponse(this.requestOtpDataResponse);

  factory RequestOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$RequestOtpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RequestOtpResponseToJson(this);
}

@JsonSerializable()
class VillageResponse {
  @JsonKey(name: "Id")
  int? id;
  @JsonKey(name: "Name")
  String? villageName;
  @JsonKey(name: "CityId")
  int? cityId;
  @JsonKey(name: "DeliveryCharge")
  double? deliveryCharge;

  VillageResponse(this.id, this.villageName, this.cityId, this.deliveryCharge);

  factory VillageResponse.fromJson(Map<String, dynamic> json) =>
      _$VillageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VillageResponseToJson(this);
}

@JsonSerializable()
class InitResponse extends BaseResponse {
  @JsonKey(name: "Villages")
  List<VillageResponse>? villages;

  InitResponse(this.villages);

  factory InitResponse.fromJson(Map<String, dynamic> json) =>
      _$InitResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InitResponseToJson(this);
}

@JsonSerializable()
class ProductResponse {
  @JsonKey(name: "ProductId")
  int? id;
  @JsonKey(name: "Name")
  String? name;
  @JsonKey(name: "TimeTaken")
  int? preparationTime;
  @JsonKey(name: "Icon")
  String? imageLink;
  @JsonKey(name: "Description")
  String? description;
  @JsonKey(name: "ProductSizeId")
  int? sizeId;
  @JsonKey(name: "Size")
  String? sizeDescription;
  @JsonKey(name: "ActualRate")
  double? actualRate;
  @JsonKey(name: "SellingRate")
  double? sellingRate;

  ProductResponse(
      this.id,
      this.name,
      this.preparationTime,
      this.imageLink,
      this.description,
      this.sizeId,
      this.sizeDescription,
      this.actualRate,
      this.sellingRate);

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}

@JsonSerializable()
class ProductGroupResponse {
  @JsonKey(name: "ProductId")
  int? id;
  @JsonKey(name: "Name")
  String? name;
  @JsonKey(name: "TimeTaken")
  int? preparationTime;
  @JsonKey(name: "Icon")
  String? imageLink;
  @JsonKey(name: "Description")
  String? description;
  @JsonKey(name: "ProductSizeList")
  List<ProductResponse>? products;

  ProductGroupResponse(this.id, this.name, this.preparationTime, this.imageLink,
      this.description, this.products);

  factory ProductGroupResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductGroupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductGroupResponseToJson(this);
}

@JsonSerializable()
class CategoryResponse {
  @JsonKey(name: "CategoryId")
  int? id;
  @JsonKey(name: "Name")
  String? name;
  @JsonKey(name: "Icon")
  String? imageLink;
  @JsonKey(name: "ProductList")
  List<ProductGroupResponse>? productGroups;

  CategoryResponse(this.id, this.name, this.imageLink, this.productGroups);

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}

@JsonSerializable()
class ShopResponse {
  @JsonKey(name: "ShopId")
  int? id;
  @JsonKey(name: "ShopName")
  String? name;
  @JsonKey(name: "Icon")
  String? imageLink;
  @JsonKey(name: "CategoryList")
  List<CategoryResponse>? categories;

  ShopResponse(this.id, this.name, this.imageLink, this.categories);

  factory ShopResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopResponseToJson(this);
}

@JsonSerializable()
class GetProductsResponse extends BaseResponse {
  @JsonKey(name: "Data")
  List<ShopResponse>? shops;
  @JsonKey(name: "Offers")
  List<ProductResponse>? offerProducts;
  @JsonKey(name: "Populars")
  List<ProductResponse>? popularProducts;
  @JsonKey(name: "Favourites")
  List<ProductResponse>? favoriteProducts;

  GetProductsResponse(this.shops, this.offerProducts, this.popularProducts,
      this.favoriteProducts);

  factory GetProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetProductsResponseToJson(this);
}
