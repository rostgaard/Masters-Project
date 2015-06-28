part of tcc.client.view;

class UIExamples extends Panel {
  final Element _root;
  final controller.Concept _conceptController;

  DivElement get _useCaseBody => _root.querySelector('.use-case');
  DivElement get _definitions => _root.querySelector('.definitions ');

  ButtonElement get _markActorButton => _root.querySelector('.mark-actor');
  ButtonElement get _markConceptButton => _root.querySelector('.mark-concept');

  bool get _hasSelectedText => window.getSelection().rangeCount > 0 &&
      window.getSelection().getRangeAt(0).cloneContents().innerHtml != '';


  String get _selectedText => _hasSelectedText
      ? window.getSelection().getRangeAt(0).cloneContents().innerHtml
      : '';

  libtcc.UseCase buc1;
  libtcc.Definitions bucDefinitions;

  /**
   * Default constructor.
   */
  UIExamples(this._root, this._conceptController) {
    libtcc.UseCaseEntry pickupCall =
        new libtcc.UseCaseEntry('Receptionist picks up call');
    libtcc.UseCaseEntry giveGreeting =
        new libtcc.UseCaseEntry('Receptionist gives greeting');
    libtcc.UseCaseEntry lookupEmployee =
        new libtcc.UseCaseEntry('Receptionist looks up employee');

    libtcc.UseCaseEntry specificEmployee =
        new libtcc.UseCaseEntry('Receptionist select specific employee');

    libtcc.UseCaseEntry searchEmployee =
        new libtcc.UseCaseEntry('Receptionist searches for employee');
    libtcc.UseCaseEntry dialContact =
        new libtcc.UseCaseEntry('Receptionist dials contact');

    libtcc.UseCaseEntry initiateTransfer =
        new libtcc.UseCaseEntry('Receptionist initiates transfer');

    libtcc.UseCaseExtension noSpecificEmployee = new libtcc.UseCaseExtension(
        lookupEmployee, [searchEmployee])..returnsTo = dialContact;

    libtcc.UseCaseExtension contactNotAvailable = new libtcc.UseCaseExtension(
        lookupEmployee, [searchEmployee])..returnsTo = lookupEmployee;

    libtcc.UseCaseBlock block1 = new libtcc.UseCaseBlock([
      pickupCall,
      giveGreeting,
      lookupEmployee,
      specificEmployee,
      dialContact,
      initiateTransfer
    ]);

    bucDefinitions = new libtcc.Definitions([
      new libtcc.Definition(
          new libtcc.Actor.withRole('Receptionist', 'Receptionist')),
      new libtcc.Definition(new libtcc.Actor('User')),
      new libtcc.Definition(new libtcc.Concept.withRole('Message', 'message'))
    ]);

    buc1 = new libtcc.UseCase('some use case')
      ..scenario = block1
      ..extensions = [noSpecificEmployee, contactNotAvailable];

    _render();
    _observers();
  }

  /**
   * Observers.
   */
  _observers() {
    _markActorButton.disabled = !_hasSelectedText;
    _markConceptButton.disabled = !_hasSelectedText;
    _root.onClick.listen((_) {
      print( window.getSelection().rangeCount);
      _markActorButton.disabled = !_hasSelectedText;
      _markConceptButton.disabled = !_hasSelectedText;
    });


    _markActorButton.onClick.listen((_) {
      if (_hasSelectedText) {
        this.bucDefinitions
            .add(new libtcc.Definition(new libtcc.Actor(_selectedText)));
        _render();
      }
    });

    _markConceptButton.onClick.listen((_) {
      if (_hasSelectedText) {
        this.bucDefinitions
            .add(new libtcc.Definition(new libtcc.Concept(_selectedText)));

        _render();
      }
    });
  }

  /**
   * Select the widget.
   */
  _select() {
    _root.hidden = false;
    _render();
  }

  /**
   * Render the content of the widget.
   */
  _render() {
    String template = '''
import domain_model;

int main () {
}

[%USECASES]
''';


    _useCaseBody.children = [
      new HeadingElement.h3()..text = 'Use Case',
      new UseCaseBlock(buc1.scenario, bucDefinitions).element
    ];

    int i = 1;
    buc1.extensions.forEach((libtcc.UseCaseExtension ext) {
      _useCaseBody.children
      ..add(new HeadingElement.h3()..text = 'Extension ${i++}')
      ..add(new UseCaseBlock(ext.entries, bucDefinitions).element);

    });


    _definitions.children = [
      new HeadingElement.h3()..text = 'Definitions',
      new Definitions(bucDefinitions, _conceptController).element
    ];

    _conceptController.list().then((Iterable<libtcc.Concept> concepts) {
      Iterable<libtcc.Definition> definitions = concepts.map((libtcc.Concept concept) => new libtcc.Definition(concept));
      _definitions.children.add(new Definitions(definitions, _conceptController).element);
    });

    String testBody = libtcc.useCasesToCode(buc1, bucDefinitions, template);
    PreElement tests = new PreElement()..text = testBody;


    _definitions.children.add(tests);
  }
}
