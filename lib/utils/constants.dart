const String apiKey = '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';
const String apiBaseUrl = 'api.openai.com';
const String apiEndPoint = '/v1/completions';

const Map<String, String> apiHeader = <String, String>{
  'Authorization': 'Bearer $apiKey',
  'Content-Type': 'application/json; charset=utf-8'
};

Map<String, dynamic> generatePostBody(String msg) {
  return
  {
    "model": "text-davinci-003",
    "prompt": msg,
    "max_tokens": 2048,
    "temperature": 0,
    "top_p": 1,
    "n":1,
    "frequency_penalty": 0.0,
    "presence_penalty": 0.0
  };
}
