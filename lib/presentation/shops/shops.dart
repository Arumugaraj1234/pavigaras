import 'package:flutter/material.dart';
import 'package:pavigaras/domain/model/model.dart';
import 'package:pavigaras/presentation/resources/colors_manager.dart';
import 'package:pavigaras/presentation/resources/routes_manager.dart';
import 'package:pavigaras/presentation/shops/shops_viewmodel.dart';
import 'package:pavigaras/presentation/state_renderer/state_renderer_implementer.dart';

import '../../app/di.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class ShopsView extends StatefulWidget {
  const ShopsView({Key? key}) : super(key: key);

  @override
  _ShopsViewState createState() => _ShopsViewState();
}

class _ShopsViewState extends State<ShopsView> {
  final _viewModel = instance<ShopsViewModel>();

  void _bind() {
    _viewModel.start();
    _viewModel.isOneShopOnlyStreamController.listen((value) {
      if (value) {
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top + AppSize.s10,
              bottom: AppSize.s10),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: AppSize.s10,
                ),
                const SizedBox(
                  width: AppSize.s5,
                ),
                Expanded(
                    child: Text(
                  "Shops",
                  style: getMediumStyle(fontSize: FontSize.f25),
                )),
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
      body: Stack(
        children: [
          StreamBuilder<List<Shop>>(
              stream: _viewModel.shopsOutput,
              builder: (context, snapshot) {
                List<Shop> shops = snapshot.data ?? [];
                return ListView.builder(
                    itemCount: shops.length,
                    itemBuilder: (context, index) {
                      Shop shop = shops[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 5),
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                              color: ColorManager.grey,
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: NetworkImage(shop.imageLink),
                                  fit: BoxFit.fill)),
                          child: Center(
                            child: Container(
                              color: ColorManager.white,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  shop.name,
                                  style: getBoldStyle(
                                      fontSize: FontSize.f12,
                                      color: ColorManager.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              }),
          // Column(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
          //       child: Container(
          //         height: 150,
          //         decoration: BoxDecoration(
          //             color: ColorManager.grey,
          //             borderRadius: BorderRadius.circular(5),
          //             image: DecorationImage(
          //                 image: NetworkImage(
          //                     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdnLAcxPB9Z_j6D3r4eeK2DJg295_AO-lAeQ&usqp=CAU"),
          //                 fit: BoxFit.fill)),
          //         child: Center(
          //           child: Container(
          //             color: ColorManager.white,
          //             child: Padding(
          //               padding: const EdgeInsets.all(3.0),
          //               child: Text(
          //                 "சாம்பார் கடை",
          //                 style: getBoldStyle(
          //                     fontSize: FontSize.f12,
          //                     color: ColorManager.black),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          //       child: Container(
          //         height: 150,
          //         decoration: BoxDecoration(
          //             color: ColorManager.grey,
          //             borderRadius: BorderRadius.circular(5),
          //             image: DecorationImage(
          //                 image: NetworkImage(
          //                     "https://static.blog.bolt.eu/LIVE/wp-content/uploads/2022/04/30135418/grocery-list-1024x536.jpg"),
          //                 fit: BoxFit.fill)),
          //         child: Center(
          //           child: Container(
          //             color: ColorManager.white,
          //             child: Padding(
          //               padding: const EdgeInsets.all(3.0),
          //               child: Text(
          //                 "மளிகை கடை",
          //                 style: getBoldStyle(
          //                     fontSize: FontSize.f12,
          //                     color: ColorManager.black),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          StreamBuilder<FlowState>(
              stream: _viewModel.outputFullScreenState,
              builder: (context, snapshot) {
                return snapshot.data?.getWidget(context, (action) {}) ??
                    const SizedBox();
              })
        ],
      ),
    );
  }
}
