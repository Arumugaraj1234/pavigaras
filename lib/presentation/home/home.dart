import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pavigaras/app/constants.dart';
import 'package:pavigaras/app/di.dart';
import 'package:pavigaras/app/enumerations.dart';
import 'package:pavigaras/data/network/error_handler.dart';
import 'package:pavigaras/domain/model/model.dart';
import 'package:pavigaras/presentation/home/header_search_bar.dart';
import 'package:pavigaras/presentation/home/home_viewmodel.dart';
import 'package:pavigaras/presentation/resources/colors_manager.dart';
import 'package:pavigaras/presentation/resources/font_manager.dart';
import 'package:pavigaras/presentation/resources/routes_manager.dart';
import 'package:pavigaras/presentation/resources/strings_manager.dart';
import 'package:pavigaras/presentation/resources/styles_manager.dart';
import 'package:pavigaras/presentation/resources/values_manager.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _viewModel = instance<HomeViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: ColorManager.primary,
          appBar: PreferredSize(
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).viewPadding.top,
              ),
              child: const HeaderSearchBar(),
            ),
            preferredSize: Size(
              MediaQuery.of(context).size.width,
              AppSize.s60,
            ),
          ),
          body: Container(
            color: ColorManager.white,
            child: ListView(
              children: [
                _getBannerSlider(context),
                const SideTitleWidget(AppStrings.whyPavigaras),
                _getQualityCardsList(context),
                StreamBuilder<HomeDataState>(
                    stream: _viewModel.outputHomeState,
                    builder: (context, snapshot) {
                      HomeDataState state =
                          snapshot.data ?? HomeDataState.loading;
                      switch (state) {
                        case HomeDataState.loading:
                          return _shimmerLoading(context);
                        case HomeDataState.success:
                          return StreamBuilder<GetProducts>(
                              stream: _viewModel.outputProducts,
                              builder: (context, snapshot) {
                                List<Product> populars =
                                    snapshot.data?.popularProducts ??
                                        const Iterable.empty()
                                            .cast<Product>()
                                            .toList();
                                List<Product> favorites =
                                    snapshot.data?.favoriteProducts ??
                                        const Iterable.empty()
                                            .cast<Product>()
                                            .toList();
                                List<Product> offers =
                                    snapshot.data?.offerProducts ??
                                        const Iterable.empty()
                                            .cast<Product>()
                                            .toList();

                                Shop? curryShop = snapshot.data?.shops
                                    .firstWhere((element) => element.id == 3);
                                List<Category> categories =
                                    curryShop?.categories ??
                                        const Iterable.empty()
                                            .cast<Category>()
                                            .toList();
                                return ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: [
                                    populars.isNotEmpty
                                        ? const SideTitleWidget(
                                            AppStrings.popularChoices)
                                        : Container(),
                                    populars.isNotEmpty
                                        ? _getPopularChoicesCardsList(
                                            context, populars)
                                        : Container(),
                                    favorites.isNotEmpty
                                        ? const SideTitleWidget(
                                            AppStrings.yourFavorites)
                                        : Container(),
                                    favorites.isNotEmpty
                                        ? _getFavoritesCardsList(
                                            context, favorites)
                                        : Container(),
                                    offers.isNotEmpty
                                        ? const SideTitleWidget(
                                            AppStrings.todayOffers)
                                        : Container(),
                                    offers.isNotEmpty
                                        ? _todayOffersCardsList(context, offers)
                                        : Container(),
                                    categories.isNotEmpty
                                        ? const SideTitleWidget(
                                            AppStrings.selectByCategory)
                                        : Container(),
                                    categories.isNotEmpty
                                        ? _selectByCategoryCard(
                                            context, categories)
                                        : Container()
                                  ],
                                );
                              });

                        case HomeDataState.error:
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppPadding.p10,
                                vertical: AppPadding.p25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                StreamBuilder<String>(
                                    stream: _viewModel
                                        .outputGetProductsErrorMessage,
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.data ??
                                            ResponseMessage.defaultStatus,
                                        style: getLightStyle(),
                                        textAlign: TextAlign.center,
                                      );
                                    }),
                                const SizedBox(
                                  height: AppSize.s10,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      _viewModel.getProducts();
                                    },
                                    child: const Text(AppStrings.retry))
                              ],
                            ),
                          );
                      }
                    }),
                const SizedBox(
                  height: AppSize.s100,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  var _current = 0;

  Widget _getBannerSlider(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(
              height: AppSize.s4,
            ),
            SizedBox(
              height: AppSize.s140,
              width: width,
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.98,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                items: AppDataConstants.imgList
                    .map(
                      (item) => Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorManager.white),
                          image: DecorationImage(
                              image: NetworkImage(item), fit: BoxFit.cover),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(
              height: AppSize.s10,
            )
          ],
        ),
        Positioned.fill(
          top: AppSize.s120,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: AppDataConstants.imgList.map(
                (image) {
                  int index = AppDataConstants.imgList.indexOf(image);
                  return Container(
                    width: _current == index ? AppSize.s30 : AppSize.s15,
                    height: AppSize.s6,
                    margin: const EdgeInsets.symmetric(horizontal: AppSize.s2),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(AppSize.s20)),
                        color: _current == index
                            ? ColorManager.primary
                            : ColorManager.lightGrey),
                  );
                },
              ).toList(),

              //
            ),
          ),
        ),
      ],
    );
  }

  Widget _getQualityCardsList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
      child: SizedBox(
          height: AppSize.s130,
          child: ListView.builder(
            itemCount: AppDataConstants.qualities.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              var quality = AppDataConstants.qualities[index];
              return QualityCard(quality);
            },
          )),
    );
  }

  Widget _getPopularChoicesCardsList(
      BuildContext context, List<Product> popular) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
      child: SizedBox(
          height: AppSize.s140,
          child: ListView.builder(
            itemCount: popular.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              var product = popular[index];
              return PopularProductCard(product, () {});
            },
          )),
    );
  }

  Widget _getFavoritesCardsList(BuildContext context, List<Product> favorites) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
      child: SizedBox(
          height: AppSize.s140,
          child: ListView.builder(
            itemCount: favorites.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              var product = favorites[index];
              return PopularProductCard(product, () {});
            },
          )),
    );
  }

  Widget _todayOffersCardsList(
      BuildContext context, List<Product> todayOffers) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
      child: SizedBox(
          height: AppSize.s140,
          child: ListView.builder(
            itemCount: todayOffers.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              var product = todayOffers[index];
              return OfferProductCard(product, () {});
            },
          )),
    );
  }

  Widget _selectByCategoryCard(
      BuildContext context, List<Category> categories) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
      child: SizedBox(
          height: AppSize.s140,
          child: ListView.builder(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              var category = categories[index];
              return CategoryCard(category.name, category.imageLink, () {
                Navigator.of(context)
                    .pushNamed(Routes.productGroupRoute, arguments: category);
              });
            },
          )),
    );
  }

  Widget _shimmerLoading(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Shimmer.fromColors(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 25,
                width: 150,
                color: ColorManager.white,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(
                            height: 100,
                            width: (width - 50) / 4,
                            color: ColorManager.white,
                          ),
                          SizedBox(
                            width: index == 3 ? 0 : 10,
                          )
                        ],
                      );
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 25,
                width: 200,
                color: ColorManager.white,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(
                            height: 100,
                            width: (width - 40) / 3,
                            color: ColorManager.white,
                          ),
                          SizedBox(
                            width: index == 2 ? 0 : 10,
                          )
                        ],
                      );
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 25,
                width: 250,
                color: ColorManager.white,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                    itemCount: 2,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(
                            height: 100,
                            width: (width - 30) / 2,
                            color: ColorManager.white,
                          ),
                          SizedBox(
                            width: index == 1 ? 0 : 10,
                          )
                        ],
                      );
                    }),
              )
            ],
          ),
        ),
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100);
  }
}

class PopularProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onSelect;
  const PopularProductCard(
    this.product,
    this.onSelect, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppPadding.p5),
      child: SizedBox(
          height: AppSize.s130,
          width: AppSize.s130,
          child: Card(
            color: ColorManager.babyBlue,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: AppSize.s100,
                      decoration: BoxDecoration(
                          color: ColorManager.white,
                          image: DecorationImage(
                              image: NetworkImage(product.imageLink),
                              fit: BoxFit.contain)),
                    ),
                    SizedBox(
                      height: AppSize.s100,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          color: ColorManager.blueGreen,
                          child: Text(
                            AppConstants.indianRupeeSymbol +
                                product.sellingRate.toStringAsFixed(2),
                            style: getBoldStyle(fontSize: FontSize.f12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s100,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: onSelect,
                          child: Container(
                            color: ColorManager.darkPrimary,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.p8,
                                  vertical: AppPadding.p5),
                              child: Text(
                                AppStrings.add,
                                style: getBoldStyle(
                                    fontSize: FontSize.f10,
                                    color: ColorManager.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        product.name,
                        overflow: TextOverflow.ellipsis,
                        style: getMediumStyle(
                          fontSize: FontSize.f12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        product.sizeDescription,
                        style: const TextStyle(fontSize: FontSize.f10),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ))
              ],
            ),
          )),
    );
  }
}

class OfferProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onSelect;
  const OfferProductCard(
    this.product,
    this.onSelect, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppPadding.p5),
      child: SizedBox(
          height: AppSize.s130,
          width: AppSize.s130,
          child: Card(
            color: ColorManager.babyBlue,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: AppSize.s100,
                      decoration: BoxDecoration(
                          color: ColorManager.white,
                          image: DecorationImage(
                              image: NetworkImage(product.imageLink),
                              fit: BoxFit.contain)),
                    ),
                    SizedBox(
                      height: AppSize.s100,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          color: ColorManager.blueGreen,
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: AppConstants.indianRupeeSymbol +
                                    product.sellingRate.toStringAsFixed(2) +
                                    " ",
                                style: getBoldStyle(fontSize: FontSize.f12)),
                            TextSpan(
                                text: AppConstants.indianRupeeSymbol +
                                    product.actualRate.toStringAsFixed(2),
                                style: getRegularStyle(fontSize: FontSize.f10)
                                    .copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        color: ColorManager.error))
                          ])),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s100,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: onSelect,
                          child: Container(
                            color: ColorManager.darkPrimary,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.p8,
                                  vertical: AppPadding.p5),
                              child: Text(
                                AppStrings.add,
                                style: getBoldStyle(
                                    fontSize: FontSize.f10,
                                    color: ColorManager.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        product.name,
                        overflow: TextOverflow.ellipsis,
                        style: getMediumStyle(
                          fontSize: FontSize.f12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        product.sizeDescription,
                        style: const TextStyle(fontSize: FontSize.f10),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ))
              ],
            ),
          )),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageLink;
  final VoidCallback onSelect;
  const CategoryCard(
    this.title,
    this.imageLink,
    this.onSelect, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Padding(
        padding: const EdgeInsets.only(right: AppPadding.p10),
        child: SizedBox(
            height: AppSize.s130,
            width: AppSize.s130,
            child: Card(
              color: ColorManager.babyBlue,
              child: Column(
                children: [
                  Container(
                    height: AppSize.s100,
                    decoration: BoxDecoration(
                        color: ColorManager.white,
                        image: DecorationImage(
                            image: NetworkImage(imageLink),
                            fit: BoxFit.contain)),
                  ),
                  Expanded(
                      child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppPadding.p3),
                    child: Center(
                      child: Text(
                        title,
                        style: getMediumStyle(
                          fontSize: FontSize.f12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ))
                ],
              ),
            )),
      ),
    );
  }
}

class SideTitleWidget extends StatelessWidget {
  final String title;
  const SideTitleWidget(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p10, vertical: AppPadding.p15),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: getSemiBoldStyle(
                  color: ColorManager.black, fontSize: FontSize.f20),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_right,
            size: AppSize.s25,
          )
        ],
      ),
    );
  }
}

class QualityCard extends StatelessWidget {
  final Quality quality;
  const QualityCard(this.quality, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppPadding.p15),
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.babyBlue,
            borderRadius: BorderRadius.circular(AppSize.s5)),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p10),
          child: Container(
            width: AppSize.s100,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(quality.iconLink),
                    fit: BoxFit.contain)),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                quality.name,
                style: getBoldStyle(
                    color: ColorManager.black, fontSize: FontSize.f14),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
