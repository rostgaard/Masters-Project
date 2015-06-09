part of tcc.client.view;

enum MenuItem {
 useCases,
 actors,
 concepts,
 tests,
 goals,
 configuration,
 activities
}


class Menu {

  final Element _root;
  final StreamController<MenuItem> _selectedItem =
    new StreamController<MenuItem>();

  Stream<MenuItem> get selectItem => _selectedItem.stream;

  Element get _concepts => _root.querySelector('a.concepts');
  Element get _actors => _root.querySelector('a.actors');
  Element get _useCases => _root.querySelector('a.use-cases');
  Element get _tests => _root.querySelector('a.tests');
  Element get _goals => _root.querySelector('a.goals');
  Element get _configuration => _root.querySelector('a.configuration');
  Element get _activities => _root.querySelector('a.activities');


  Element get _selectedMenuItem => _root.querySelector('li.pure-menu-selected');

  Menu(this._root) {
    _observers();
  }

  void _observers() {
    _concepts.onClick.listen((Event event) {
      _selectedMenuItem.classes.toggle('pure-menu-selected', false);
      _concepts.parent.classes.toggle('pure-menu-selected', true);
      _selectedItem.add(MenuItem.concepts);
    });

    _actors.onClick.listen((_) {
      _selectedMenuItem.classes.toggle('pure-menu-selected', false);
      _actors.parent.classes.toggle('pure-menu-selected', true);
      _selectedItem.add(MenuItem.actors);
    });

    _useCases.onClick.listen((_) {
      _selectedMenuItem.classes.toggle('pure-menu-selected', false);
      _useCases.parent.classes.toggle('pure-menu-selected', true);
      _selectedItem.add(MenuItem.useCases);
    });

    _tests.onClick.listen((_) {
      _selectedMenuItem.classes.toggle('pure-menu-selected', false);
      _tests.parent.classes.toggle('pure-menu-selected', true);
      _selectedItem.add(MenuItem.tests);
    });

    _goals.onClick.listen((_) {
      _selectedMenuItem.classes.toggle('pure-menu-selected', false);
      _goals.parent.classes.toggle('pure-menu-selected', true);
      _selectedItem.add(MenuItem.goals);
    });

    _activities.onClick.listen((_) {
      _selectedMenuItem.classes.toggle('pure-menu-selected', false);
      _activities.parent.classes.toggle('pure-menu-selected', true);
      _selectedItem.add(MenuItem.activities);
    });

    _configuration.onClick.listen((_) {
      _selectedMenuItem.classes.toggle('pure-menu-selected', false);
      _configuration.parent.classes.toggle('pure-menu-selected', true);
      _selectedItem.add(MenuItem.configuration);
    });

  }
}