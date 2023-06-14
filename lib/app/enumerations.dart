enum RemoteDataResponseStatus {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimedOut,
  cancelled,
  receiveTimedOut,
  sendTimedOut,
  cacheError,
  noInternetConnection,
  defaultStatus
}

enum StateRendererType {
  popUpLoading,
  popUpError,
  popUpSuccess,
  fullScreenLoading,
  fullScreenError,
  emptyScreen,
  content
}

enum StateRendererAction { ok, retry, success }

enum HomeDataState { loading, success, error }

enum ShopTypes { sambarKadai, maligaiKadai }

extension ShopTypesExt on ShopTypes {
  int id() {
    switch (this) {
      case ShopTypes.sambarKadai:
        return 3;
      case ShopTypes.maligaiKadai:
        return 1; //todo: May change the value
    }
  }
}
