import 'dart:io';
import 'package:logger/logger.dart';
import 'package:yaml/yaml.dart';

// import 'package:app_launcher/app_launcher.dart' as app_launcher;

void main(List<String> arguments) {
  var logger = Logger();
  var configFile = File('config.yaml');
  if (!configFile.existsSync()) {
    logger.e('config.yaml file not found!');
    exit(-1);
  }
  var config = loadYaml(configFile.readAsStringSync());
  logger.i('config: $config');
  var result = Process.runSync(
    config['app'],
    (config['arguments'] as YamlList).value.map((e) => e.toString()).toList(),
    runInShell: false,
  );
  logger.i('result: ${result.exitCode}, ${result.stdout}, ${result.stderr}');
}
