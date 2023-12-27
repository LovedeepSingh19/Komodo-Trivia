import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:komodo_trivia/constants.dart';
import 'package:komodo_trivia/provider/dataProvider.dart';
import 'package:provider/provider.dart';

Future<void> runAPIFetchFunction(context) async {
  var dataProvider = Provider.of<DataProvider>(context, listen: false);

  String amount = dataProvider.questions.amount;

  String finalURL = '$URL?amount=$amount';

  final Map<String, String?> queryParams = {
    'type': dataProvider.questions.type,
    'difficulty': dataProvider.questions.difficulty,
    'category': dataProvider.questions.category,
  };

  final Map<String, dynamic> nonNullParams = queryParams
    ..removeWhere((key, value) => value == null);

  finalURL += '&${Uri(queryParameters: nonNullParams).query}';

  final response = await http.get(Uri.parse('$finalURL'));

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    List<dynamic> results = data['results'];

    print("data fetch done");
    var data_provider = Provider.of<DataProvider>(context, listen: false);
    data_provider.setData(results);
  } else {
    print("Error: ${response.statusCode}");
    throw Exception("Failed to fetch data from the API");
  }
}
