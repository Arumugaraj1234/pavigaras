import 'package:pavigaras/app/constants.dart';
import 'package:pavigaras/app/enumerations.dart';
import 'package:pavigaras/presentation/state_renderer/state_renderer_implementer.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  final _stateStreamController = BehaviorSubject<FlowState>();

  @override
  dispose() {
    _stateStreamController.close();
  }

  //INPUT POP UP STATE

  @override
  Sink<FlowState> get inputState => _stateStreamController.sink;

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

  // INPUT FULL SCREEN STATE

  @override
  Sink<FlowState> get inputFullScreenState => _stateStreamController.sink;

  @override
  void fullScreenErrorState(String message) {
    inputFullScreenState
        .add(FlowState(StateRendererType.fullScreenError, message, null));
  }

  @override
  void fullScreenLoadingState(String message) {
    inputFullScreenState
        .add(FlowState(StateRendererType.fullScreenLoading, message, null));
  }

  @override
  void fullScreenEmptyState(String message) {
    inputFullScreenState
        .add(FlowState(StateRendererType.emptyScreen, message, null));
  }

  @override
  void hideFullScreenState() {
    inputFullScreenState.add(FlowState(StateRendererType.content, "", null));
  }

  //OUTPUT STATE

  @override
  Stream<FlowState> get outputState =>
      _stateStreamController.stream.map((flowState) => flowState);

  @override
  Stream<FlowState> get outputFullScreenState =>
      _stateStreamController.stream.map((flowState) => flowState);
}

abstract class BaseViewModelInputs {
  void start();
  void dispose();
  void hideState();
  void popUpLoadingState();
  void popUpErrorState(String message);
  void popUpSuccessState(String title, String message);
  void fullScreenErrorState(String message);
  void fullScreenLoadingState(String message);
  void fullScreenEmptyState(String message);
  void hideFullScreenState();

  Sink<FlowState> get inputState;
  Sink<FlowState> get inputFullScreenState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
  Stream<FlowState> get outputFullScreenState;
}
