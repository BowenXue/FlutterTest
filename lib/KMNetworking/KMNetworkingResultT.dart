class KMNetworkingResultT {
  static T generateObject<T>(json) {
    if (json == null) {
      return null;
    } else {
      return json as T;
    }
  }
}
