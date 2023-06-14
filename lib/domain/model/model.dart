class Village {
  int id;
  String villageName;
  int cityId;
  double deliveryCharge;

  Village(this.id, this.villageName, this.cityId, this.deliveryCharge);
}

class Init {
  int status;
  String message;
  List<Village> villages;

  Init(this.status, this.message, this.villages);
}

class RequestOtpData {
  int customerId;
  String fullName;
  int mobileNumber;
  String email;
  double walletAmount;
  int otpCode;

  RequestOtpData(this.customerId, this.fullName, this.mobileNumber, this.email,
      this.walletAmount, this.otpCode);
}

class RequestOtp {
  int status;
  String message;
  RequestOtpData? data;

  RequestOtp(this.status, this.message, this.data);
}

class Quality {
  String iconLink;
  String name;

  Quality(this.iconLink, this.name);
}

class Product {
  int id;
  String name;
  int preparationTime;
  String imageLink;
  String description;
  int sizeId;
  String sizeDescription;
  double actualRate;
  double sellingRate;

  Product(
      this.id,
      this.name,
      this.preparationTime,
      this.imageLink,
      this.description,
      this.sizeId,
      this.sizeDescription,
      this.actualRate,
      this.sellingRate);

  int availableStocksCount() {
    return 4;
  }

  bool isDiscountToShow() {
    return actualRate > sellingRate;
  }

  int percentageOff() {
    return (((actualRate - sellingRate) / actualRate) * 100).toInt();
  }

  String get hintsToSearch {
    String nameWithNoSpace = name.replaceAll(" ", "");
    String descriptionWithNoSpace = description.replaceAll(" ", "");
    String n = name.toLowerCase() +
        name.toUpperCase() +
        nameWithNoSpace.toLowerCase() +
        nameWithNoSpace.toUpperCase();
    String d = description.toLowerCase() +
        description.toUpperCase() +
        descriptionWithNoSpace.toLowerCase() +
        descriptionWithNoSpace.toUpperCase();
    return n + d;
  }
}

class ProductGroup {
  int id;
  String name;
  int preparationTime;
  String imageLink;
  String description;
  List<Product> products;

  ProductGroup(this.id, this.name, this.preparationTime, this.imageLink,
      this.description, this.products);
}

class Category {
  int id;
  String name;
  String imageLink;
  List<ProductGroup> productGroups;

  Category(this.id, this.name, this.imageLink, this.productGroups);
}

class Shop {
  int id;
  String name;
  String imageLink;
  List<Category> categories;

  Shop(this.id, this.name, this.imageLink, this.categories);
}

class GetProducts {
  int status;
  String message;
  List<Shop> shops;
  List<Product> offerProducts;
  List<Product> popularProducts;
  List<Product> favoriteProducts;

  GetProducts(this.status, this.message, this.shops, this.offerProducts,
      this.popularProducts, this.favoriteProducts);
}

class PaymentType {
  int id;
  String title;
  String imageName;

  PaymentType(this.id, this.title, this.imageName);
}

class DeliveryAddress {
  int addressId;
  String fullAddress;
  String postalCode;
  double latitude;
  double longitude;

  DeliveryAddress(this.addressId, this.fullAddress, this.postalCode,
      this.latitude, this.longitude);
}

class GetAllDeliveryAddresses {
  int status;
  String message;
  List<DeliveryAddress>? addresses;

  GetAllDeliveryAddresses(this.status, this.message, this.addresses);
}

class GoogleAddress {
  double latitude;
  double longitude;
  String formattedAddress;
  String streetNoShort;
  String streetNoLong;
  String streetNameShort;
  String streetNameLong;
  String cityNameShort;
  String cityNameLong;
  String provinceNameShort;
  String provinceNameLong;
  String countryNameShort;
  String countryNameLong;
  String postalCodeShort;
  String postalCodeLong;

  GoogleAddress(
      this.latitude,
      this.longitude,
      this.formattedAddress,
      this.streetNoShort,
      this.streetNoLong,
      this.streetNameShort,
      this.streetNameLong,
      this.cityNameShort,
      this.cityNameLong,
      this.provinceNameShort,
      this.provinceNameLong,
      this.countryNameShort,
      this.countryNameLong,
      this.postalCodeShort,
      this.postalCodeLong);
}

class UpdateAddress {
  int status;
  String message;

  UpdateAddress(this.status, this.message);
}
