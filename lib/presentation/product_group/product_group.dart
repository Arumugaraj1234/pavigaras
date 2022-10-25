import 'package:flutter/material.dart';
import 'package:pavigaras/domain/model/model.dart';
import 'package:pavigaras/presentation/resources/colors_manager.dart';
import 'package:pavigaras/presentation/resources/font_manager.dart';
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
    ProductGroup productGroup = widget.category.productGroups[0];
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = (screenWidth - 40) / 3;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: cardWidth + 40,
        width: cardWidth,
        child: Card(
          color: ColorManager.babyBlue,
          child: Column(
            children: [
              Container(
                height: cardWidth,
                decoration: BoxDecoration(
                    color: ColorManager.white,
                    image: DecorationImage(
                        image: NetworkImage(productGroup.imageLink),
                        fit: BoxFit.contain)),
              ),
              Expanded(child: Center(child: Text(productGroup.name)))
            ],
          ),
        ),
      ),
    );
  }
}
