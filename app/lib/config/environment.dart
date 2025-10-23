import 'app_config.dart';
import 'dev_config.dart';
import 'prod_config.dart';

class Environment {
  // Private constructor to prevent instantiation
  Environment._();

  static late AppConfig _config;

  // --dart-define=ENV=<dev|prod>
  static const String _env = String.fromEnvironment('ENV', defaultValue: 'dev');

  static void initialize() {
    switch (_env.toLowerCase()) {
      case 'prod':
      case 'production':
        _config = ProdConfig();
        break;
      case 'dev':
      case 'development':
      default:
        _config = DevConfig();
    }
  }

  static AppConfig get config => _config;
}