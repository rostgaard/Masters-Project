part of tcc.client.view;

///TODO: implement.
class UseCase {

  UseCase._internal();

  factory UseCase.fromModel() {
    var uc = new UseCase._internal();

  }
}

LIElement useCaseToLI (libtcc.UseCase uc) {
  HeadingElement name = new HeadingElement.h1()..text = uc.name;
  ParagraphElement description = new ParagraphElement()..text = uc.description;

  return new LIElement()
    ..children = [
      name,
      description
      ];
}