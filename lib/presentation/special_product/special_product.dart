import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:pavigaras/app/extentions.dart';
import 'package:pavigaras/domain/model/model.dart';
import 'package:badges/badges.dart' as badges;
import 'package:pavigaras/presentation/resources/routes_manager.dart';

import '../../app/constants.dart';
import '../controller/cart_controller.dart';
import '../resources/assets_manager.dart';
import '../resources/colors_manager.dart';
import '../resources/font_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class SpecialProductView extends StatefulWidget {
  final Product product;

  const SpecialProductView({Key? key, required this.product}) : super(key: key);

  @override
  State<SpecialProductView> createState() => _SpecialProductViewState();
}

class _SpecialProductViewState extends State<SpecialProductView> {
  CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).viewPadding.top,
          ),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: AppSize.s10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: AppSize.s30,
                    ),
                  ),
                ),
                const SizedBox(
                  width: AppSize.s5,
                ),
                Expanded(child: Container()),
                GetX<CartController>(builder: (snapshot) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Cart Amount:",
                        style: getRegularStyle(fontSize: FontSize.f10),
                      ),
                      Text(
                        "${AppConstants.indianRupeeSymbol}${snapshot.totalCartValue().stringValue}",
                        style: getBoldStyle(
                            color: ColorManager.darkPrimary,
                            fontSize: FontSize.f16),
                      )
                    ],
                  );
                }),
                const SizedBox(
                  width: 10,
                ),
                GetX<CartController>(builder: (snapshot) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(Routes.addressesRoute, arguments: 2);
                    },
                    child: badges.Badge(
                      badgeContent: Text(
                        snapshot.noOfProductsInCart().toString(),
                      ),
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        size: AppSize.s35,
                        color: ColorManager.black,
                      ),
                    ),
                  );
                }),
                const SizedBox(
                  width: AppSize.s10,
                ),
                InkWell(
                  onTap: () {
                    //todo: Add to favorites
                  },
                  child: Icon(
                    Icons.favorite_border,
                    size: AppSize.s35,
                    color: ColorManager.darkPrimary,
                  ),
                ),
                const SizedBox(
                  width: AppSize.s10,
                ),
              ]),
        ),
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          AppSize.s60,
        ),
      ),
      body: _getContentWidget(),
    );
  }

  Widget _getContentWidget() {
    Product product = widget.product;

    //bool isAlreadySelected = false;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
      child: ListView(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppSize.s180,
                width: AppSize.s150,
                child: Stack(
                  children: [
                    Container(
                      height: AppSize.s180,
                      width: AppSize.s150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s15),
                          image: DecorationImage(
                              image: NetworkImage(product.imageLink),
                              fit: BoxFit.fill)),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: AppSize.s10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: product.name,
                            style: getBoldStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.f20)),
                        TextSpan(
                            text: "   ",
                            style: getBoldStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.f20)),
                        WidgetSpan(
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppPadding.p3,
                                  horizontal: AppPadding.p5),
                              decoration: BoxDecoration(
                                color: ColorManager.green,
                                borderRadius: BorderRadius.circular(AppSize.s4),
                              ),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Image.asset(
                                          ImageAssets.bestSellerIcon,
                                          width: AppSize.s12,
                                          fit: BoxFit.contain),
                                    ),
                                    TextSpan(
                                        text: " ${AppStrings.popularChoice} ",
                                        style: getSemiBoldStyle(
                                            color: ColorManager.white,
                                            fontSize: FontSize.f12))
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              )),
                        )
                      ]),
                    ),
                    RatingBar.builder(
                      wrapAlignment: WrapAlignment.start,
                      initialRating: 4.5,
                      minRating: 1,
                      itemSize: AppSize.s20,
                      ignoreGestures: true,
                      unratedColor: ColorManager.primaryOpacity70,
                      allowHalfRating: true,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 0.5),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: ColorManager.darkPrimary,
                      ),
                      onRatingUpdate: (rating) {
                        // print(rating);
                      },
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    InkWell(
                      onTap: () {
                        //todo: Navigate to review view
                      },
                      child: Text(
                        '148 Reviews >',
                        textAlign: TextAlign.left,
                        style: getRegularStyle(
                            color: ColorManager.darkGrey,
                            fontSize: FontSize.f14),
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    product.description.isEmpty
                        ? Container()
                        : RichText(
                            text: TextSpan(children: [
                            TextSpan(
                                text: AppStrings.description,
                                style: getSemiBoldStyle(
                                    color: ColorManager.black,
                                    fontSize: FontSize.f16)),
                            TextSpan(
                                text: product.description,
                                style: getLightStyle(
                                    color: ColorManager.black,
                                    fontSize: FontSize.f16))
                          ])),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppSize.s10, horizontal: AppSize.s25),
            child: Divider(
              color: ColorManager.darkGrey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: AppSize.s10),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 0.2),
                  borderRadius: BorderRadius.circular(5),
                  color: ColorManager.white,
                  boxShadow: [
                    BoxShadow(
                        color: ColorManager.lightGrey,
                        offset: const Offset(0, -1),
                        blurRadius: 4,
                        spreadRadius: 0)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            product.sizeDescription,
                            style: getRegularStyle(
                                color: ColorManager.darkGrey,
                                fontSize: FontSize.f14),
                          ),
                          const SizedBox(
                            height: AppSize.s5,
                          ),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        "${AppConstants.indianRupeeSymbol}${product.sellingRate.stringValue} ",
                                    style: getRegularStyle(
                                        color: ColorManager.black,
                                        fontSize: FontSize.f18)),
                                TextSpan(
                                  text: product.isDiscountToShow()
                                      ? "${AppConstants.indianRupeeSymbol}${product.actualRate.stringValue} "
                                      : "",
                                  style: getRegularStyle(
                                          color: ColorManager.grey,
                                          fontSize: FontSize.f14)
                                      .copyWith(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                                TextSpan(
                                    text: product.isDiscountToShow()
                                        ? " (${product.percentageOff()}% off) "
                                        : "",
                                    style: getRegularStyle(
                                        fontSize: FontSize.f10,
                                        color: ColorManager.green))
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    GetX<CartController>(builder: (snapshot) {
                      return Visibility(
                        visible: product.availableStocksCount() > 0,
                        child: Container(
                          width: AppSize.s100,
                          height: AppSize.s30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: ColorManager.darkPrimary,
                              borderRadius: BorderRadius.circular(AppSize.s6)),
                          child: snapshot.noOfGivenProductInCart(product) > 0
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        int noOfProductInCart = cartController
                                            .noOfGivenProductInCart(product);
                                        if (noOfProductInCart > 0) {
                                          cartController
                                              .removeProductFromCart(product);
                                        }
                                      },
                                      child: Container(
                                        width: AppSize.s35,
                                        padding:
                                            const EdgeInsets.all(AppPadding.p5),
                                        child: Center(
                                          child: Text(
                                            '－',
                                            style: getBoldStyle(
                                                color: ColorManager.white,
                                                fontSize: FontSize.f14),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        snapshot
                                            .noOfGivenProductInCart(product)
                                            .toString(),
                                        style: getBoldStyle(
                                            color: ColorManager.white,
                                            fontSize: FontSize.f16),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        cartController
                                            .addProductToCart(product);
                                      },
                                      child: Container(
                                        width: AppSize.s35,
                                        padding:
                                            const EdgeInsets.all(AppPadding.p5),
                                        alignment: Alignment.center,
                                        child: Center(
                                          child: Text(
                                            "＋",
                                            style: getBoldStyle(
                                                color: ColorManager.white,
                                                fontSize: FontSize.f14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(
                                  padding: const EdgeInsets.all(AppPadding.p5),
                                  child: GestureDetector(
                                      onTap: () {
                                        cartController
                                            .addProductToCart(product);
                                      },
                                      child: Text(
                                        AppStrings.add,
                                        textAlign: TextAlign.center,
                                        style: getMediumStyle(
                                            color: ColorManager.white,
                                            fontSize: FontSize.f12),
                                      )),
                                ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
