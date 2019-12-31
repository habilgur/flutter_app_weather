import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpHelper {
  HttpHelper(this.url);
  final url;

  Future getJsonData() async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonObj = jsonDecode(response.body);
      return jsonObj;
    } else {
      return null;
    }
  }
}
