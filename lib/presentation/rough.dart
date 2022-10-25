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
                    )*/
