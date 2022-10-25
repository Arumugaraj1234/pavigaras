import 'package:pavigaras/data/network/error_handler.dart';
import 'package:pavigaras/data/responses/responses.dart';
import 'package:pavigaras/domain/model/model.dart';
import 'package:pavigaras/app/constants.dart';

extension RequestOtpDataResponseMapper on RequestOtpDataResponse {
  RequestOtpData doMap() => RequestOtpData(customerId ?? 0, fullName ?? "",
      mobileNumber ?? 0, email ?? "", walletAmount ?? 0.0, otpCode ?? 0);
}

extension RequestOtpResponseMapper on RequestOtpResponse {
  RequestOtp doMap() =>
      RequestOtp(status ?? 0, message ?? "", requestOtpDataResponse?.doMap());
}

extension VillageResponseMapper on VillageResponse {
  Village doMap() =>
      Village(id ?? 0, villageName ?? "", cityId ?? 0, deliveryCharge ?? 0.0);
}

extension InitResponseMapper on InitResponse {
  Init doMap() => Init(
      status ?? 0,
      message ?? ResponseMessage.defaultStatus,
      villages?.map((e) => e.doMap()).toList() ??
          const Iterable.empty().cast<Village>().toList());
}

extension ProductResponseMapper on ProductResponse {
  Product doMap() => Product(
      id ?? 0,
      name ?? "",
      preparationTime ?? 0,
      imageLink ?? AppConstants.defaultImage,
      description ?? "",
      sizeId ?? 0,
      sizeDescription ?? "",
      actualRate ?? 0.0,
      sellingRate ?? 0.0);
}

extension ProductGroupResponseMapper on ProductGroupResponse {
  ProductGroup doMap() => ProductGroup(
      id ?? 0,
      name ?? "",
      preparationTime ?? 0,
      imageLink ?? AppConstants.defaultImage,
      description ?? "",
      products?.map((e) => e.doMap()).toList() ??
          const Iterable.empty().cast<Product>().toList());
}

extension CategoryResponseMapper on CategoryResponse {
  Category doMap() => Category(
      id ?? 0,
      name ?? "",
      imageLink ?? AppConstants.defaultImage,
      productGroups?.map((e) => e.doMap()).toList() ??
          const Iterable.empty().cast<ProductGroup>().toList());
}

extension ShopResponseMapper on ShopResponse {
  Shop doMap() => Shop(
      id ?? 0,
      name ?? "",
      imageLink ?? AppConstants.defaultImage,
      categories?.map((e) => e.doMap()).toList() ??
          const Iterable.empty().cast<Category>().toList());
}

extension GetProductsResponseMapper on GetProductsResponse {
  GetProducts doMap() => GetProducts(
        status ?? 0,
        message ?? ResponseMessage.defaultStatus,
        shops?.map((e) => e.doMap()).toList() ??
            const Iterable.empty().cast<Shop>().toList(),
        offerProducts?.map((e) => e.doMap()).toList() ??
            const Iterable.empty().cast<Product>().toList(),
        popularProducts?.map((e) => e.doMap()).toList() ??
            const Iterable.empty().cast<Product>().toList(),
        favoriteProducts?.map((e) => e.doMap()).toList() ??
            const Iterable.empty().cast<Product>().toList(),
      );
}
