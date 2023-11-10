class RouteInfo {
  RouteInfo({
    required this.path,
    required this.pathParams,
    required this.queryParams,
  });

  final String path;
  final Map<String, String> pathParams;
  final Map<String, String> queryParams;
}
