class FlavorConfig {
  final String name;
  final String apiBaseUrl;

  static late FlavorConfig instance;

  FlavorConfig({required this.name, required this.apiBaseUrl}) {
    instance = this;
  }
}
