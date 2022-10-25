import 'dart:ffi';

import 'package:pavigaras/app/constants.dart';
import 'package:pavigaras/domain/usecase/init_usecase.dart';
import 'package:pavigaras/presentation/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

class SplashViewModel extends BaseViewModel {
  final initSuccessStreamController = BehaviorSubject<void>();
  final InitUseCase _initUseCase;

  SplashViewModel(this._initUseCase);

  @override
  void start() {
    init();
  }

  @override
  void dispose() {
    super.dispose();
    initSuccessStreamController.close();
  }

  void init() async {
    // ignore: void_checks
    (await _initUseCase.execute(Void)).fold((failure) {
      fullScreenErrorState(failure.message);
    }, (data) {
      AppDataConstants.villages = data.villages;
      initSuccessStreamController.add(null);
    });
  }
}
