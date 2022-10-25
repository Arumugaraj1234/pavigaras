import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pavigaras/app/constants.dart';
import 'package:pavigaras/app/di.dart';
import 'package:pavigaras/domain/model/model.dart';
import 'package:pavigaras/presentation/home/home_viewmodel.dart';
import 'package:pavigaras/presentation/resources/assets_manager.dart';
import 'package:pavigaras/presentation/resources/colors_manager.dart';
import 'package:pavigaras/presentation/resources/font_manager.dart';
import 'package:pavigaras/presentation/resources/strings_manager.dart';
import 'package:pavigaras/presentation/resources/styles_manager.dart';
import 'package:pavigaras/presentation/resources/values_manager.dart';

class HeaderSearchBar extends StatefulWidget {
  const HeaderSearchBar({Key? key}) : super(key: key);

  @override
  _HeaderSearchBarState createState() => _HeaderSearchBarState();
}

class _HeaderSearchBarState extends State<HeaderSearchBar> {
  final _viewModel = instance<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorManager.white, boxShadow: [
        BoxShadow(
            spreadRadius: AppSize.s0,
            blurRadius: AppSize.s3,
            color: ColorManager.lightGrey,
            offset: const Offset(AppSize.s0, AppSize.s3))
      ]),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          child: Row(mainAxisSize: MainAxisSize.max, children: [
            Container(
                alignment: Alignment.center,
                child: Image.asset(
                  ImageAssets.locationIcon,
                  width: AppSize.s50,
                  height: AppSize.s50,
                  fit: BoxFit.contain,
                )),
            const SizedBox(
              width: AppSize.s5,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: AppSize.s2,
                  ),
                  Text(
                    AppStrings.deliveringArea,
                    textAlign: TextAlign.left,
                    style: getLightStyle(color: ColorManager.black),
                  ),
                  Expanded(
                    child: StreamBuilder<Village>(
                        stream: _viewModel.outputSelectedVillage,
                        builder: (context, snapshot) {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: ColorManager.black,
                                size: AppSize.s35,
                              ),
                              value: snapshot.data?.villageName ??
                                  AppDataConstants.villages[0].villageName,
                              items: AppDataConstants.villages
                                  .map((Village village) {
                                return DropdownMenuItem<String>(
                                  value: village.villageName.toString(),
                                  child: Text(
                                    village.villageName,
                                    style: getMediumStyle(
                                        color: ColorManager.black,
                                        fontSize: FontSize.f12),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                Village v = AppDataConstants.villages
                                    .firstWhere((element) =>
                                        element.villageName == val);
                                _viewModel.setSelectedVillage(v);
                              },
                            ),
                          );
                        }),
                  ),
                ],
              ),
            )
          ]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {},
              child: const Icon(
                Icons.timer,
                size: AppSize.s30,
              ),
            ),
            const SizedBox(
              width: AppSize.s10,
            ),
            InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.favorite,
                  size: AppSize.s30,
                )),
            const SizedBox(
              width: AppSize.s10,
            ),
            InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.notifications_rounded,
                  size: AppSize.s30,
                )),
          ],
        ),
      ]),
    );
  }
}
