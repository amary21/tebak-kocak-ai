abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    // You can implement connectivity check here
    // For now, returning true
    return true;
  }
}
