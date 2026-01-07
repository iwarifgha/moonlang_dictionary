import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/legacy.dart';
 
enum ViewState { busy, done, error, none }

class BaseViewModelState extends Equatable {
  final ViewState viewState;
  final String viewMessage;
  final String? errorMessage;

  const BaseViewModelState({
    this.viewState = ViewState.none,
    this.viewMessage = '',
    this.errorMessage,
  });

  BaseViewModelState copyWith({
    ViewState? viewState,
    String? viewMessage,
    String? errorMessage,
  }) {
    return BaseViewModelState(
      viewState: viewState ?? this.viewState,
      viewMessage: viewMessage ?? this.viewMessage,
      errorMessage: errorMessage,
    );
  }

  bool get hasError => viewState == ViewState.error;

  bool get isBusy => viewState == ViewState.busy;

  @override
  List<Object?> get props => [viewState, viewMessage, errorMessage];
}

class BaseViewModel extends StateNotifier<BaseViewModelState> {
  BaseViewModel(super.initState);

  void setState({ViewState? viewState, String? viewMessage}) {
    state = state.copyWith(viewState: viewState, viewMessage: viewMessage);
  }

  // Future<void> retry(Future<ApiResponse> Function() onRetry) async {
  //   setState(viewState: ViewState.busy);
  //   final result = await onRetry();
  //   setState(viewState: ViewState.done);

  //   if (result.hasError) {
  //     state = state.copyWith(
  //       viewState: ViewState.error,
  //       errorMessage: result.error.toString(),
  //     );
  //   }
  // }
  
}
