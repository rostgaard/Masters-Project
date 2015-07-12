part of tcc.service.test;

const String GET = 'GET';
const String POST = 'POST';
const String PUT = 'PUT';

void testRouterConcept() {
  group('Service.Concept', () {
    IO.HttpServer httpServer;
    Service.TestCaseService service;

    setUp(() {
      return HTTPService.start().then((IO.HttpServer startedServer) {
        httpServer = startedServer;
        service = new Service.TestCaseService(
            Uri.parse('http://localhost:7777'), null);
      });

      });
    tearDown(() {
      httpServer.close(force: true);
    });
  });
}
