import 'package:flutter/material.dart';
import 'package:pavigaras/domain/model/model.dart';
import 'package:pavigaras/presentation/resources/colors_manager.dart';
import 'package:pavigaras/presentation/resources/font_manager.dart';
import 'package:pavigaras/presentation/resources/routes_manager.dart';
import 'package:pavigaras/presentation/resources/styles_manager.dart';
import 'package:pavigaras/presentation/resources/values_manager.dart';

class ProductGroupView extends StatefulWidget {
  final Category category;

  const ProductGroupView(this.category, {Key? key}) : super(key: key);

  @override
  _ProductGroupViewState createState() => _ProductGroupViewState();
}

class _ProductGroupViewState extends State<ProductGroupView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
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
                Expanded(
                    child: Text(
                  widget.category.name,
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
      body: _content(context),
    );
  }

  _content(BuildContext context) {
    List<ProductGroup> productGroups = widget.category.productGroups;
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = (screenWidth - 40) / 3;

    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: productGroups.length,
        itemBuilder: (_, i) {
          ProductGroup productGroup = productGroups[i];
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(Routes.productRoute, arguments: productGroup);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              child: Card(
                color: ColorManager.babyBlue,
                child: SizedBox(
                  height: cardWidth + 40,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorManager.white,
                              image: DecorationImage(
                                  image: NetworkImage(productGroup.imageLink),
                                  fit: BoxFit.contain)),
                        ),
                      ),
                      SizedBox(
                          height: 30,
                          child: Center(
                            child: Text(
                              productGroup.name,
                              textAlign: TextAlign.center,
                              style: getLightStyle(fontSize: FontSize.f12),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
