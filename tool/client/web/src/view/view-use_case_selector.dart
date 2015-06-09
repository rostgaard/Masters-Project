part of tcc.client.view;

class UseCaseSelector {

  final HtmlElement _root;

  UListElement get _menu => _root.querySelector('ul.pure-menu-list');

  UseCaseSelector(this._root);

  Iterable<LIElement> get testElements =>
    [_menuItem ('ost'), _menuItem ('skinke')];

  LIElement _menuItem (String useCaseName) =>
    new LIElement()
      ..classes.add('pure-menu-item')
      ..children.add(new AnchorElement()
        ..href = "#use-case.$useCaseName"
        ..text = useCaseName
        ..classes.add('pure-menu-link'));

  void render(Iterable<LIElement> links) {
    _menu.children = links.toList(growable: false);

    links.forEach((LIElement li) {
      li.onClick.listen(print);
    });
  }

}