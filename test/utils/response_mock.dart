class JsonMock {
  final _jsonMockSuccess = {
    "statusCode": 200,
    "data": [
      {"userId": 1, "id": 1, "title": "delectus aut autem", "completed": false},
      {"userId": 1, "id": 2, "title": "quis ut nam facilis et officia qui", "completed": false}
    ]
  };

  final _jsonMockError = {
    "statusCode": 404,
    "body": {"error": "Not Found"}
  };

  get jsonMockSuccess => _jsonMockSuccess;
  get jsonMockError => _jsonMockError;
}
