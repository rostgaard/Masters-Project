part of tcc.service.test;

void testConceptRole () {
  test('Create concept', () {
    Model.Concept concept = new Model.Concept('Test')..role = 'Some test';

    shelf.Request request =
        createRequest(POST, '/concept', body: JSON.encode(concept));

    router
        .handler(request)
        .then(
            (_) => fail('did not raise a BadRequestException as expected'))
        .catchError((error) {
      expect(error, equals(new isInstanceOf<Exception>()));
    });
  });
}