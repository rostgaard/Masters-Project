part of tcc.service.test;

const String GET = 'GET';
const String POST = 'POST';
const String PUT = 'PUT';

/**
 * Create a dummy Shelf.Request object.
 */
shelf.Request createRequest(String method, String path, {String body: ''}) {
  return new shelf.Request(method, Uri.parse('http://localhost${path}'),
      body: new Stream.fromFuture(new Future.value(UTF8.encode(body))));
}

void testRouterConcept() {

  group('Router.Concept', () {
    Logger log = new Logger('Router.Concept');
    shelf_route.Router router;
    setUp(() {
      return Router.setupRouter().then((shelf_route.Router r) {
        router = r;
      });
    });

    tearDown(() {
      router = null;
    });

    test('Create concept', () {
      Model.Concept concept = new Model.Concept('Test')..role = 'Some test';

      shelf.Request request =
          createRequest(POST, '/concept', body: JSON.encode(concept));

      router
          .handler(request)
          .then((_) => fail('did not raise a BadRequestException as expected'))
          .catchError((error) {
        expect(error, equals(new isInstanceOf<Exception>()));
      });
    });
  });
}
