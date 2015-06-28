part of tcc.client.view;

class TemplatesPanel implements Panel {

  final Element _root;
  final controller.Template _templateController;

  SelectElement get _templateSelector =>
      _root.querySelector('#template-selector');

  TextAreaElement get _editArea => _root.querySelector('#template-edit');

  InputElement get _templateIdInput => _root.querySelector('#template-edit-id');
  InputElement get _templateNameInput => _root.querySelector('#template-edit-name');


  int get _templateId => int.parse(_templateIdInput.value);
  set _templateId (int id) => _templateIdInput.value = id.toString();

  String get _templateName => _templateNameInput.value;
  set _templateName (String name) => _templateNameInput.value = name;

  /**
   *
   */
  TemplatesPanel(this._root, this._templateController) {
    _render();
    _observers();
  }

  /**
   * Observers
   */
  _observers() {
    _templateSelector.onClick.listen((_){
      int tplId = int.parse
          (_templateSelector.options[_templateSelector.selectedIndex].value);

      _templateController.get(tplId).then(_renderTemplate);

    });
  }

  /**
   *
   */
  _select() {
    _root.hidden = false;
    _render();
  }

  /**
   *
   */
  _render() {
    _templateController.list()
      .then((Iterable<libtcc.TestTemplate> templates) {
        _templateSelector
          .children.addAll(templates.map(_templateToOptionElement));
    });
  }

  /**
   *
   */
  _renderTemplate(libtcc.TestTemplate template) {
    _templateId = template.id;
    _templateName = template.name;
    _editArea.text = template.body;
  }

  /**
   *
   */
  OptionElement _templateToOptionElement(libtcc.TestTemplate template) =>
    new OptionElement()
    ..text = template.name
    ..value = template.id.toString()
    ..onClick.listen(print);
}