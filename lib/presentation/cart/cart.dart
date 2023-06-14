import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pavigaras/app/di.dart';
import 'package:pavigaras/presentation/cart/cart_viewmodel.dart';
import 'package:pavigaras/presentation/controller/cart_controller.dart';
import 'package:pavigaras/presentation/resources/assets_manager.dart';
import 'package:pavigaras/presentation/resources/font_manager.dart';
import 'package:pavigaras/presentation/resources/strings_manager.dart';
import 'package:pavigaras/presentation/resources/values_manager.dart';

import '../../domain/model/model.dart';
import '../resources/colors_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/styles_manager.dart';

class CartView extends StatefulWidget {
  final int fromFlag;
  const CartView(this.fromFlag, {Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  CartController cartController = Get.find();
  final ScrollController _scrollController = ScrollController();
  bool _hideShadow = false;
  //DeliveryType _deliveryType = DeliveryType.SCHEDULED_DELIVERY;
  final _viewModel = instance<CartViewModel>();

  _bind() {
    // _viewModel.setSelectedDishDetails(cartController.selectedDishes);
  }

  _dispose() {
    cartController.dispose();
    _scrollController.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: GetX<CartController>(builder: (snapshot) {
              List<Product> products = snapshot.cartProducts;
              return products.isNotEmpty
                  ? Container(
                      color: ColorManager.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: NotificationListener<ScrollEndNotification>(
                              onNotification: (notification) {
                                double maxScroll =
                                    _scrollController.position.maxScrollExtent;
                                if (maxScroll == notification.metrics.pixels) {
                                  setState(() {
                                    _hideShadow = true;
                                  });
                                } else {
                                  setState(() {
                                    _hideShadow = false;
                                  });
                                }
                                return true;
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: ListView(
                                  controller: _scrollController,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          widget.fromFlag == 0
                                              ? InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: const Icon(
                                                      Icons.arrow_back_ios,
                                                      size: 30,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(),
                                          RichText(
                                            text: TextSpan(
                                                children: [
                                                  const TextSpan(
                                                      text: "Your Cart "),
                                                  WidgetSpan(
                                                      child:
                                                          GetX<CartController>(
                                                              builder:
                                                                  (snapshot) {
                                                        return Text(
                                                          "(${snapshot.noOfProductsInCart()} items)",
                                                          style: getLightStyle(
                                                              color:
                                                                  ColorManager
                                                                      .black,
                                                              fontSize:
                                                                  FontSize.f14),
                                                        );
                                                      }),
                                                      alignment:
                                                          PlaceholderAlignment
                                                              .middle),
                                                ],
                                                style: getSemiBoldStyle(
                                                    color: ColorManager.black,
                                                    fontSize: FontSize.f20)),
                                          ),
                                          const SizedBox(
                                            width: AppSize.s5,
                                          ),
                                          Expanded(child: Container()),
                                        ]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GetX<CartController>(builder: (snapshot) {
                                      List<Product> products =
                                          snapshot.uniqueCartProducts;
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: products.length,
                                          itemBuilder: (cxt, index) {
                                            Product product = products[index];
                                            return CartDishWidget(
                                                product: product);
                                          });
                                    }),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: "Delivery Address   ",
                                          style: getBoldStyle(
                                              color: ColorManager.black,
                                              fontSize: FontSize.f20)),
                                      TextSpan(
                                          text: "CHANGE",
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              var address = await Navigator.of(
                                                      context)
                                                  .pushNamed(
                                                      Routes.addressesRoute);
                                              // DeliveryAddress? dV =
                                              //     address as DeliveryAddress;
                                              // _viewModel.setDeliveryAddress(dV);
                                            },
                                          style: getBoldStyle(
                                                  color:
                                                      ColorManager.darkPrimary,
                                                  fontSize: FontSize.f16)
                                              .copyWith(
                                                  decorationStyle:
                                                      TextDecorationStyle.solid,
                                                  decoration:
                                                      TextDecoration.underline))
                                    ])),
                                    Text(
                                      "No Address got selected",
                                      style: getSemiBoldStyle(
                                          color: ColorManager.black,
                                          fontSize: FontSize.f16),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SmartSelect<int?>.single(
                                      title: AppStrings.paymentMethod,
                                      placeholder:
                                          AppStrings.paymentMethodPlaceHolder,
                                      selectedValue: 0,
                                      onChange: (selected) {
                                        _viewModel.setPaymentTypeIndex(
                                            selected.value ?? 0);
                                      },
                                      modalType: S2ModalType.bottomSheet,
                                      modalHeader: false,
                                      choiceItems:
                                          S2Choice.listFrom<int, PaymentType>(
                                        source: _viewModel.paymentMethods,
                                        value: (index, item) => index,
                                        title: (index, item) => item.title,
                                        subtitle: (index, item) =>
                                            item.imageName,
                                        meta: (index, item) => item,
                                      ),
                                      choiceLayout: S2ChoiceLayout.wrap,
                                      choiceDirection: Axis.horizontal,
                                      choiceBuilder: (context, state, choice) {
                                        return Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              AppSize.s0,
                                              AppSize.s5,
                                              AppSize.s0,
                                              AppSize.s5),
                                          color: choice.selected
                                              ? ColorManager.darkPrimary
                                              : ColorManager.white,
                                          child: InkWell(
                                            onTap: () =>
                                                choice.select?.call(true),
                                            child: SizedBox(
                                              width: AppSize.s100,
                                              height: AppSize.s100,
                                              child: Center(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Container(
                                                      height: AppSize.s56,
                                                      width: AppSize.s56,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .all(
                                                                AppPadding.p18),
                                                        child: Image.asset(
                                                            _viewModel
                                                                .paymentMethods[
                                                                    choice.value ??
                                                                        0]
                                                                .imageName),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: ColorManager
                                                              .white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      AppSize
                                                                          .s28),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: ColorManager
                                                                    .darkPrimaryOpacity50,
                                                                offset:
                                                                    const Offset(
                                                                        AppSize
                                                                            .s0,
                                                                        AppSize
                                                                            .s0),
                                                                blurRadius:
                                                                    AppSize.s4,
                                                                spreadRadius:
                                                                    AppSize.s2)
                                                          ]),
                                                    ),
                                                    const SizedBox(
                                                        height: AppSize.s5),
                                                    Text(
                                                      _viewModel
                                                          .paymentMethods[
                                                              choice.value ?? 0]
                                                          .title,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: choice.selected
                                                            ? ColorManager.white
                                                            : ColorManager
                                                                .black,
                                                        fontFamily:
                                                            FontFamilyManager
                                                                .circularStd,
                                                        fontWeight:
                                                            FontWeightManager
                                                                .regular,
                                                        fontSize: FontSize.f14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      tileBuilder: (context, state) {
                                        String avatar = _viewModel
                                            .paymentMethods[
                                                state.selected?.choice?.value ??
                                                    0]
                                            .imageName;
                                        return S2Tile.fromState(
                                          state,
                                          isTwoLine: true,
                                          leading: Container(
                                            height: AppSize.s50,
                                            width: AppSize.s50,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  AppPadding.p5),
                                              child: Image.asset(avatar),
                                            ),
                                            decoration: BoxDecoration(
                                                color: ColorManager.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppSize.s25),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: ColorManager
                                                          .darkPrimaryOpacity50,
                                                      offset: const Offset(
                                                          AppSize.s0,
                                                          AppSize.s0),
                                                      blurRadius: AppSize.s4,
                                                      spreadRadius: AppSize.s2)
                                                ]),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Order Summary",
                                      style: getBoldStyle(
                                          color: ColorManager.black,
                                          fontSize: FontSize.f20),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Sub-total",
                                            style: getSemiBoldStyle(
                                                color: ColorManager.black,
                                                fontSize: FontSize.f16),
                                          ),
                                        ),
                                        GetX<CartController>(
                                            builder: (snapshot) {
                                          return Text(
                                            "${AppStrings.currencySymbol}${snapshot.subTotalPrice.toStringAsFixed(2)}",
                                            style: getSemiBoldStyle(
                                                color: ColorManager.black,
                                                fontSize: FontSize.f16),
                                          );
                                        }),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Delivery",
                                            style: getSemiBoldStyle(
                                                color: ColorManager.black,
                                                fontSize: FontSize.f16),
                                          ),
                                        ),
                                        GetX<CartController>(
                                            builder: (snapshot) {
                                          return Text(
                                            AppStrings.currencySymbol +
                                                snapshot.deliveryCharge
                                                    .toStringAsFixed(2),
                                            style: getSemiBoldStyle(
                                                color: ColorManager.black,
                                                fontSize: FontSize.f16),
                                          );
                                        }),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: widget.fromFlag == 0 ? 125 : 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                boxShadow: _hideShadow
                                    ? null
                                    : [
                                        BoxShadow(
                                            color: ColorManager.lightGrey,
                                            offset: const Offset(0, 0),
                                            spreadRadius: 1,
                                            blurRadius: 4)
                                      ],
                                color: ColorManager.white),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
//todo: Implement the discount
                                    },
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Got a discount code?",
                                        style: TextStyle(
                                            color: ColorManager.black,
                                            fontFamily:
                                                FontFamilyManager.circularStd,
                                            fontSize: FontSize.f14,
                                            fontWeight:
                                                FontWeightManager.regular,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                ColorManager.black),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Total",
                                          style: getBoldStyle(
                                              color: ColorManager.black,
                                              fontSize: FontSize.f18),
                                        ),
                                      ),
                                      GetX<CartController>(builder: (snapshot) {
                                        return Text(
                                          AppStrings.currencySymbol +
                                              snapshot.grandTotal
                                                  .toStringAsFixed(2),
                                          style: getBoldStyle(
                                              color: ColorManager.black,
                                              fontSize: FontSize.f18),
                                        );
                                      }),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            // _viewModel.placeOrder();
                                          },
                                          child: const Text("CHECKOUT")))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Lottie.asset(JsonAssets.empty),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Your Cart is ",
                                style: getRegularStyle(
                                    color: ColorManager.darkGrey,
                                    fontSize: FontSize.f18),
                              ),
                              TextSpan(
                                text: "Empty",
                                style: getBoldStyle(
                                    color: ColorManager.error,
                                    fontSize: FontSize.f18),
                              )
                            ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Add items to get started",
                            style: getRegularStyle(
                                color: ColorManager.lightGrey,
                                fontSize: FontSize.f16),
                          ),
                          SizedBox(
                            height: 100,
                          )
                        ],
                      ),
                    );
            }),
          ),
        ),
        // StreamBuilder<FlowState>(
        //     stream: _viewModel.outputState,
        //     builder: (context, snapshot) {
        //       return snapshot.data?.getWidget(context, (action) {
        //             if (action == StateRendererAction.ok) {
        //               _viewModel.hideState();
        //             } else if (action == StateRendererAction.success) {
        //               cartController.setDefaultValue();
        //               Navigator.of(context).pushNamedAndRemoveUntil(
        //                   Routes.mainRoute, (route) => false);
        //             }
        //           }) ??
        //           const SizedBox();
        //     })
      ],
    );
  }
}

class CartDishWidget extends StatelessWidget {
  const CartDishWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: AppSize.s150,
            width: AppSize.s120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s10),
                image: DecorationImage(
                    image: NetworkImage(product.imageLink), fit: BoxFit.fill)),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    style: getBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.f18)),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  product.sizeDescription,
                  style: getRegularStyle(color: ColorManager.grey),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: AppSize.s100,
                      height: AppSize.s40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: ColorManager.primary,
                          borderRadius: BorderRadius.circular(AppSize.s6)),
                      child: GetX<CartController>(builder: (snapshot) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                snapshot.removeProductFromCart(product);
                              },
                              child: Container(
                                width: AppSize.s35,
                                padding: const EdgeInsets.all(AppSize.s5),
                                child: Center(
                                  child: Text(
                                    '-',
                                    style: getBoldStyle(
                                        color: ColorManager.white,
                                        fontSize: FontSize.f20),
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
                                    fontSize: FontSize.f20),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                snapshot.addProductToCart(product);
                              },
                              child: Container(
                                width: AppSize.s35,
                                padding: const EdgeInsets.all(AppSize.s5),
                                alignment: Alignment.center,
                                child: Center(
                                  child: Text(
                                    '+',
                                    style: getBoldStyle(
                                        color: ColorManager.white,
                                        fontSize: FontSize.f20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    Text("  x   "),
                    Text(
                      "${AppStrings.currencySymbol}${product.actualRate.toStringAsFixed(2)} ",
                      style: getRegularStyle(
                          color: ColorManager.black, fontSize: FontSize.f25),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
