/*Visibility(
                      visible: dish.stocksCount > 0,
                      child: Container(
                        width: SizeManager.s100,
                        height: SizeManager.s40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: ColorManager.orange,
                            borderRadius:
                                BorderRadius.circular(SizeManager.s6)),
                        child: _addedItemsCount > 0
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      //todo: Remove item from cart
                                    },
                                    child: Container(
                                      width: SizeManager.s35,
                                      padding:
                                          const EdgeInsets.all(SizeManager.s5),
                                      child: Center(
                                        child: Text(
                                          '-',
                                          style: getBoldStyle(
                                              color: ColorManager.white,
                                              fontSize: FontSizeManager.f20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GetX<CartController>(builder: (controller) {
                                    return Center(
                                      child: Text(
                                        controller.itemsCount.toString(),
                                        style: getBoldStyle(
                                            color: ColorManager.white,
                                            fontSize: FontSizeManager.f20),
                                      ),
                                    );
                                  }),
                                  GestureDetector(
                                    onTap: () {
                                      cartController.addDish(dish);
                                    },
                                    child: Container(
                                      width: SizeManager.s35,
                                      padding:
                                          const EdgeInsets.all(SizeManager.s5),
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: Text(
                                          '+',
                                          style: getBoldStyle(
                                              color: ColorManager.white,
                                              fontSize: FontSizeManager.f20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                padding:
                                    const EdgeInsets.all(PaddingSizeManager.p5),
                                child: GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      StringsManager.add,
                                      textAlign: TextAlign.center,
                                      style: getBoldStyle(
                                          color: ColorManager.white,
                                          fontSize: FontSizeManager.f20),
                                    )),
                              ),
                      ),
                    )


                    import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pavigaras/app/constants.dart';
import 'package:pavigaras/domain/model/model.dart';
import 'package:pavigaras/presentation/resources/assets_manager.dart';
import 'package:pavigaras/presentation/resources/colors_manager.dart';
import 'package:pavigaras/presentation/resources/font_manager.dart';
import 'package:pavigaras/presentation/resources/strings_manager.dart';
import 'package:pavigaras/presentation/resources/styles_manager.dart';
import 'package:pavigaras/presentation/resources/values_manager.dart';

class ProductView extends StatefulWidget {
  final ProductGroup productGroup;
  const ProductView(this.productGroup, {Key? key}) : super(key: key);

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
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
                Text(
                  "0",
                  style: getBoldStyle(color: ColorManager.black, fontSize: 20),
                ),
                InkWell(
                  onTap: () {
                    //todo: Show No of items selected & navigate to cart view
                  },
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: AppSize.s35,
                    color: ColorManager.black,
                  ),
                ),
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
    ProductGroup productGroup = widget.productGroup;
    Product product = productGroup.products[0];
    bool isAlreadySelected = false;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
      child: ListView(
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: productGroup.name,
                  style: getBoldStyle(
                      color: ColorManager.black, fontSize: FontSize.f20)),
              TextSpan(
                  text: "   ",
                  style: getBoldStyle(
                      color: ColorManager.black, fontSize: FontSize.f20)),
              WidgetSpan(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppPadding.p3, horizontal: AppPadding.p5),
                    decoration: BoxDecoration(
                      color: ColorManager.green,
                      borderRadius: BorderRadius.circular(AppSize.s4),
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Image.asset(ImageAssets.bestSellerIcon,
                                width: AppSize.s12, fit: BoxFit.contain),
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
          const SizedBox(
            height: AppSize.s20,
          ),
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
                              image: NetworkImage(productGroup.imageLink),
                              fit: BoxFit.fill)),
                    ),
                    product.availableStocksCount() < 4 &&
                            product.availableStocksCount() > 0
                        ? Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: AppPadding.p5),
                              child: Container(
                                height: AppSize.s25,
                                width: AppSize.s110,
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.8),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(AppSize.s17),
                                      bottomLeft: Radius.circular(AppSize.s17)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(AppPadding.p3),
                                  child: Center(
                                    child: Text(
                                      'Only ${product.availableStocksCount()} unit(s) left',
                                      style: getSemiBoldStyle(
                                          color: ColorManager.white,
                                          fontSize: FontSize.f12),
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        : const SizedBox()
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
                            text: productGroup.name,
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
                    Text(
                      product.sizeDescription,
                      style: getRegularStyle(color: ColorManager.grey),
                    ),
                    const SizedBox(
                      height: AppSize.s5,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  "${AppConstants.indianRupeeSymbol}${product.sellingRate.toStringAsFixed(2)} ",
                              style: getRegularStyle(
                                  color: ColorManager.black,
                                  fontSize: FontSize.f25)),
                          TextSpan(
                            text: product.isDiscountToShow()
                                ? "${AppConstants.indianRupeeSymbol}${product.actualRate.toStringAsFixed(2)} "
                                : "",
                            style: getRegularStyle(color: ColorManager.grey)
                                .copyWith(
                                    decoration: TextDecoration.lineThrough),
                          ),
                          TextSpan(
                              text: product.isDiscountToShow()
                                  ? " (${product.percentageOff()}% off) "
                                  : "",
                              style: getRegularStyle(
                                  fontSize: FontSize.f12,
                                  color: ColorManager.green))
                        ],
                      ),
                      textAlign: TextAlign.center,
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
                    Visibility(
                      visible: product.availableStocksCount() < 1,
                      child: SizedBox(
                        height: AppSize.s40,
                        child: Row(
                          children: [
                            Text(
                              AppStrings.outOfStocks,
                              style: getSemiBoldStyle(
                                  color: ColorManager.error,
                                  fontSize: FontSize.f12),
                            ),
                            const SizedBox(
                              width: AppSize.s10,
                            ),
                            Expanded(
                              child: Container(
                                width: AppSize.s100,
                                height: AppSize.s40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: ColorManager.darkPrimary,
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s6)),
                                child: GestureDetector(
                                    onTap: () {
                                      //todo: Call notify if available web service
                                    },
                                    child: Text(
                                      AppStrings.notifyIfAvailable,
                                      textAlign: TextAlign.center,
                                      style: getBoldStyle(
                                          color: ColorManager.white,
                                          fontSize: FontSize.f12),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: product.availableStocksCount() > 0,
                      child: Container(
                        width: AppSize.s100,
                        height: AppSize.s40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: ColorManager.darkPrimary,
                            borderRadius: BorderRadius.circular(AppSize.s6)),
                        child: isAlreadySelected
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      //todo: Decrease product count from Cart
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
                                              fontSize: FontSize.f20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "0",
                                      style: getBoldStyle(
                                          color: ColorManager.white,
                                          fontSize: FontSize.f20),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      //todo: Increase product count
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
                                              fontSize: FontSize.f20),
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
                                      // todo: Add first product in carrt
                                    },
                                    child: Text(
                                      AppStrings.add,
                                      textAlign: TextAlign.center,
                                      style: getBoldStyle(
                                          color: ColorManager.white,
                                          fontSize: FontSize.f20),
                                    )),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          productGroup.description.isEmpty
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(top: AppPadding.p20),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: AppStrings.description,
                        style: getSemiBoldStyle(
                            color: ColorManager.black, fontSize: FontSize.f18)),
                    TextSpan(
                        text: productGroup.description,
                        style: getLightStyle(color: ColorManager.black))
                  ])),
                ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppSize.s10, horizontal: AppSize.s25),
            child: Divider(
              color: ColorManager.darkGrey,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 0.5),
                borderRadius: BorderRadius.circular(5),
                color: ColorManager.white,
                boxShadow: [
                  BoxShadow(
                      color: ColorManager.lightGrey,
                      offset: const Offset(0, 0),
                      blurRadius: 5,
                      spreadRadius: 2)
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
                          style: getRegularStyle(color: ColorManager.grey),
                        ),
                        const SizedBox(
                          height: AppSize.s5,
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      "${AppConstants.indianRupeeSymbol}${product.sellingRate.toStringAsFixed(2)} ",
                                  style: getRegularStyle(
                                      color: ColorManager.black,
                                      fontSize: FontSize.f25)),
                              TextSpan(
                                text: product.isDiscountToShow()
                                    ? "${AppConstants.indianRupeeSymbol}${product.actualRate.toStringAsFixed(2)} "
                                    : "",
                                style: getRegularStyle(color: ColorManager.grey)
                                    .copyWith(
                                        decoration: TextDecoration.lineThrough),
                              ),
                              TextSpan(
                                  text: product.isDiscountToShow()
                                      ? " (${product.percentageOff()}% off) "
                                      : "",
                                  style: getRegularStyle(
                                      fontSize: FontSize.f12,
                                      color: ColorManager.green))
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: product.availableStocksCount() > 0,
                    child: Container(
                      width: AppSize.s100,
                      height: AppSize.s40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: ColorManager.darkPrimary,
                          borderRadius: BorderRadius.circular(AppSize.s6)),
                      child: isAlreadySelected
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    //todo: Decrease product count from Cart
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
                                            fontSize: FontSize.f20),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "0",
                                    style: getBoldStyle(
                                        color: ColorManager.white,
                                        fontSize: FontSize.f20),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //todo: Increase product count
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
                                            fontSize: FontSize.f20),
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
                                    // todo: Add first product in carrt
                                  },
                                  child: Text(
                                    AppStrings.add,
                                    textAlign: TextAlign.center,
                                    style: getBoldStyle(
                                        color: ColorManager.white,
                                        fontSize: FontSize.f20),
                                  )),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




                    */
