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

enum HomeDataState {loading, success, error}
