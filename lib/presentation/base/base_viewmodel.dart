import 'package:pavigaras/app/constants.dart';
import 'package:pavigaras/app/enumerations.dart';
import 'package:pavigaras/presentation/state_renderer/state_renderer_implementer.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  final _inputStateStreamController = BehaviorSubject<FlowState>();

  @override
  dispose() {
    _inputStateStreamController.close();
  }

  @override
  hideState() {
    inputState.add(FlowState(StateRendererType.content,
        AppConstants.emptyString, AppConstants.emptyString));
  }

  @override
  popUpLoadingState() {
    inputState.add(FlowState(
        StateRendererType.popUpLoading, AppConstants.emptyString, null));
  }

  @override
  popUpErrorState(String message) {
    inputState.add(FlowState(StateRendererType.popUpError, message, null));
  }

  @override
  void popUpSuccessState(String title, String message) {
    inputState.add(FlowState(StateRendererType.popUpSuccess, message, title));
  }

  @override
  void fullScreenErrorState(String message) {
    inputState.add(FlowState(StateRendererType.fullScreenError, message, null));
  }

  @override
  Sink<FlowState> get inputState => _inputStateStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStateStreamController.stream.map((flowState) => flowState);
}

abstract class BaseViewModelInputs {
  void start();
  void dispose();
  void hideState();
  void popUpLoadingState();
  void popUpErrorState(String message);
  void popUpSuccessState(String title, String message);
  void fullScreenErrorState(String message);

  Sink<FlowState> get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
