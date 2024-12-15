
String extractVideoId(String url) {
  final uri = Uri.parse(url);

  if (uri.queryParameters.containsKey('v')) {
    return uri.queryParameters['v']!;
  }

  if (uri.host == 'youtu.be') {
    return uri.pathSegments.first;
  }

  if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'embed') {
    return uri.pathSegments[1];
  }

  throw const FormatException('URL inválida ou ID do vídeo não encontrado');
}
