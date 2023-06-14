import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:pavigaras/app/di.dart';
import 'package:pavigaras/app/extentions.dart';
import 'package:pavigaras/presentation/search/search_viewmodel.dart';

import '../../app/constants.dart';
import '../../domain/model/model.dart';
import '../controller/cart_controller.dart';
import '../resources/colors_manager.dart';
import '../resources/font_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _viewModel = instance<SearchItemViewModel>();

  CartController cartController = Get.find();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  void _bind() {
    _viewModel.start();
  }

  void _dispose() {
    _viewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.darkPrimary,
      body: SafeArea(
        child: Column(
          children: [
            Container(
                height: 80,
                color: ColorManager.darkPrimary,
                child: Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(10)),
                        height: 45,
                        child: TextFormField(
                          onChanged: (String val) {
                            _viewModel.searchTextChanged(val);
                          },
                          decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              prefixIcon: Icon(Icons.search),
                              hintText: "Search your item"),
                        ),
                      )),
                )),
            Expanded(
                child: Container(
              color: ColorManager.white,
              child: StreamBuilder<List<Product>>(
                  stream: _viewModel.outputSearchResults,
                  builder: (context, snapshot) {
                    List<Product> products = snapshot.data ?? [];
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          Product product = products[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppPadding.p10),
                            child: ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
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
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppSize.s15),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        product.imageLink),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            ]),
                                          ),
                                          RatingBar.builder(
                                            wrapAlignment: WrapAlignment.start,
                                            initialRating: 4.5,
                                            minRating: 1,
                                            itemSize: AppSize.s20,
                                            ignoreGestures: true,
                                            unratedColor:
                                                ColorManager.primaryOpacity70,
                                            allowHalfRating: true,
                                            direction: Axis.horizontal,
                                            itemCount: 5,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 0.5),
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
                                                      text: AppStrings
                                                          .description,
                                                      style: getSemiBoldStyle(
                                                          color: ColorManager
                                                              .black,
                                                          fontSize:
                                                              FontSize.f16)),
                                                  TextSpan(
                                                      text: product.description,
                                                      style: getLightStyle(
                                                          color: ColorManager
                                                              .black,
                                                          fontSize:
                                                              FontSize.f16))
                                                ])),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: AppSize.s10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 0.2),
                                      borderRadius: BorderRadius.circular(5),
                                      color: ColorManager.white,
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //       color: ColorManager.lightGrey,
                                      //       offset: const Offset(0, -1),
                                      //       blurRadius: 4,
                                      //       spreadRadius: 0)
                                      // ]
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  product.sizeDescription,
                                                  style: getRegularStyle(
                                                      color:
                                                          ColorManager.darkGrey,
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
                                                              color:
                                                                  ColorManager
                                                                      .black,
                                                              fontSize: FontSize
                                                                  .f18)),
                                                      TextSpan(
                                                        text: product
                                                                .isDiscountToShow()
                                                            ? "${AppConstants.indianRupeeSymbol}${product.actualRate.stringValue} "
                                                            : "",
                                                        style: getRegularStyle(
                                                                color:
                                                                    ColorManager
                                                                        .grey,
                                                                fontSize:
                                                                    FontSize
                                                                        .f14)
                                                            .copyWith(
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough),
                                                      ),
                                                      TextSpan(
                                                          text: product
                                                                  .isDiscountToShow()
                                                              ? " (${product.percentageOff()}% off) "
                                                              : "",
                                                          style: getRegularStyle(
                                                              fontSize:
                                                                  FontSize.f10,
                                                              color:
                                                                  ColorManager
                                                                      .green))
                                                    ],
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                          GetX<CartController>(
                                              builder: (snapshot) {
                                            return Visibility(
                                              visible: product
                                                      .availableStocksCount() >
                                                  0,
                                              child: Container(
                                                width: AppSize.s100,
                                                height: AppSize.s30,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: ColorManager
                                                        .darkPrimary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppSize.s6)),
                                                child: snapshot
                                                            .noOfGivenProductInCart(
                                                                product) >
                                                        0
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              int noOfProductInCart =
                                                                  cartController
                                                                      .noOfGivenProductInCart(
                                                                          product);
                                                              if (noOfProductInCart >
                                                                  0) {
                                                                cartController
                                                                    .removeProductFromCart(
                                                                        product);
                                                              }
                                                            },
                                                            child: Container(
                                                              width:
                                                                  AppSize.s35,
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      AppPadding
                                                                          .p5),
                                                              child: Center(
                                                                child: Text(
                                                                  '－',
                                                                  style: getBoldStyle(
                                                                      color: ColorManager
                                                                          .white,
                                                                      fontSize:
                                                                          FontSize
                                                                              .f14),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Center(
                                                            child: Text(
                                                              snapshot
                                                                  .noOfGivenProductInCart(
                                                                      product)
                                                                  .toString(),
                                                              style: getBoldStyle(
                                                                  color:
                                                                      ColorManager
                                                                          .white,
                                                                  fontSize:
                                                                      FontSize
                                                                          .f16),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              cartController
                                                                  .addProductToCart(
                                                                      product);
                                                            },
                                                            child: Container(
                                                              width:
                                                                  AppSize.s35,
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      AppPadding
                                                                          .p5),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Center(
                                                                child: Text(
                                                                  "＋",
                                                                  style: getBoldStyle(
                                                                      color: ColorManager
                                                                          .white,
                                                                      fontSize:
                                                                          FontSize
                                                                              .f14),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .all(
                                                                AppPadding.p5),
                                                        child: GestureDetector(
                                                            onTap: () {
                                                              cartController
                                                                  .addProductToCart(
                                                                      product);
                                                            },
                                                            child: Text(
                                                              AppStrings.add,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: getMediumStyle(
                                                                  color:
                                                                      ColorManager
                                                                          .white,
                                                                  fontSize:
                                                                      FontSize
                                                                          .f12),
                                                            )),
                                                      ),
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: AppSize.s10,
                                      horizontal: AppSize.s0),
                                  child: Divider(
                                    thickness: 1,
                                    color: ColorManager.primary,
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  }),
            ))
          ],
        ),
      ),
    );
  }
}
