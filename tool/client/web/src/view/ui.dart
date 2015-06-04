part of tcc.client.view;

class UI {
  Element get _title => querySelector('#main .header .title');

  final Menu _menu = new Menu(querySelector('nav#menu'));

  Element get _currentPanel =>
      querySelectorAll('section').firstWhere((Element e) => !e.hidden);

  Element get _actorsPanel => querySelector('section#actors');
  Element get _conceptsPanel => querySelector('section#concepts');
  Element get _testsPanel => querySelector('section#tests');
  Element get _useCasesPanel => querySelector('section#use-cases');
  Element get _configurationPanel => querySelector('section#configuration');

  UI() {
    _menu.selectItem.listen((MenuItem itemSelected) {
      switch (itemSelected) {
        case MenuItem.actors:
          _select(_actorsPanel, 'Actors');
          break;
        case MenuItem.concepts:
          _select(_conceptsPanel, 'Concepts');
          break;

        case MenuItem.tests:
          _select(_testsPanel, 'Tests');
          break;

        case MenuItem.useCases:
          _select(_useCasesPanel, 'Use Cases');
          break;

        case MenuItem.configuration:
          _select(_configurationPanel, 'Configuration');
          break;
      }
    });
  }

  _select(Element panel, title) {
    _currentPanel.hidden = true;
    panel.hidden = false;
    _title.text = title;
  }
}
