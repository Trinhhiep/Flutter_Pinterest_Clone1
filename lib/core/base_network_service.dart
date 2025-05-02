import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseNetworkService {
  final String baseUrl;
  final Map<String, String> defaultHeaders;

  BaseNetworkService({
    required this.baseUrl,
    this.defaultHeaders = const {},
  });

  /// GET method
  Future<dynamic> get(String endpoint, {Map<String, String>? headers, Map<String, dynamic>? params}) async {
    final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params);

    // Log endpoint
    printJson('GET Request:', uri.toString());

    final response = await http.get(uri, headers: {...defaultHeaders, ...?headers});

    // Log response
    printJson('Response (${response.statusCode}):', response.body);

    return _processResponse(response);
  }

  /// POST method
  Future<dynamic> post(String endpoint, {Map<String, String>? headers, Object? body}) async {
    final uri = Uri.parse('$baseUrl$endpoint');

    // Log endpoint and body
    printJson('POST Request:', uri.toString());
    if (body != null) {
      printJson('Body:', body);
    }

    final response = await http.post(
      uri,
      headers: {
        ...defaultHeaders,
        ...?headers,
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    // Log response
    printJson('Response (${response.statusCode}):', response.body);

    return _processResponse(response);
  }



  /// Handle the response and errors
  dynamic _processResponse(http.Response response) {
    final statusCode = response.statusCode;
    if (statusCode >= 200 && statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('HTTP ${response.statusCode}: ${response.reasonPhrase}');
    }
  }

  void printJson(String label, dynamic json) {
  try {
    final jsonString = json is String ? json : jsonEncode(json);
    final decodedJson = jsonDecode(jsonString);
    final prettyJson = JsonEncoder.withIndent('  ').convert(decodedJson);

    print('$label');
    _printLongString(prettyJson);
  } catch (e) {
    print('$label\n$json'); // Nếu không phải JSON, in nguyên văn
  }
}

/// In chuỗi dài theo từng đoạn nhỏ
void _printLongString(String text) {
  const int chunkSize = 800;
  for (var i = 0; i < text.length; i += chunkSize) {
    final end = (i + chunkSize < text.length) ? i + chunkSize : text.length;
    print(text.substring(i, end));
  }
}
}
