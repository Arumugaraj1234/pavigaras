import 'package:pavigaras/app/constants.dart';
import 'package:pavigaras/app/enumerations.dart';
import 'package:pavigaras/data/network/error_handler.dart';
import 'package:pavigaras/data/responses/responses.dart';

abstract class LocalDataSource {
  Future<InitResponse> init();
  Future<void> saveInitToCache(InitResponse initResponse);
  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImplementer implements LocalDataSource {
  Map<String, CachedItem> cacheMap = Map();

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }

  @override
  Future<InitResponse> init() async {
    CachedItem? cachedItem = cacheMap[AppConstants.cacheInitKey];
    if (cachedItem != null && cachedItem.isValid(60 * 1000)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(RemoteDataResponseStatus.cacheError);
    }
  }

  @override
  Future<void> saveInitToCache(InitResponse initResponse) async {
    cacheMap[AppConstants.cacheInitKey] = CachedItem(initResponse);
  }
}

class CachedItem {
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTime) {
    // expirationTime is 60 secs
    int currentTimeInMillis =
        DateTime.now().millisecondsSinceEpoch; // time now is 1:00:00 pm

    bool isCacheValid = currentTimeInMillis - expirationTime <
        cacheTime; // cache time was in 12:59:30
    // false if current time > 1:00:30
    // true if current time <1:00:30
    return isCacheValid;
  }
}
