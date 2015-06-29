part of tcc.client.view;

class TemplatesPanel implements Panel {

  final Element _root;
  final controller.Template _templateController;

  SelectElement get _templateSelector =>
      _root.querySelector('#template-selector');

  TextAreaElement get _editArea => _root.querySelector('#template-edit');

  InputElement get _templateIdInput => _root.querySelector('#template-edit-id');
  InputElement get _templateNameInput => _root.querySelector('#template-edit-name');
  InputElement get _templateDescriptionInput => _root.querySelector('#template-edit-description');
  ButtonElement get _addButton => _root.querySelector('button.create');
  ButtonElement get _saveButton => _root.querySelector('button.save');


  int get _templateId => int.parse(_templateIdInput.value);
  set _templateId (int id) => _templateIdInput.value = id.toString();

  String get _templateName => _templateNameInput.value;
  set _templateName (String name) => _templateNameInput.value = name;

  /**
   * Default constructor.
   */
  TemplatesPanel(this._root, this._templateController) {
    _render();
    _observers();
  }

  /**
   * 'getter' for extracting the information about the currently selected
   * template and returning it as an object.
   */
  libtcc.TestTemplate get _currentTemplate =>
      new libtcc.TestTemplate.empty()
        ..body = _editArea.text
        ..description = _templateDescriptionInput.value
        ..name = _templateNameInput.value
        ..id = _templateId;

  /**
   * Observers
   */
  _observers() {
    _templateSelector.onClick.listen((_){
      int tplId = int.parse
          (_templateSelector.options[_templateSelector.selectedIndex].value);

      if (tplId != _templateId) {
        _templateController.get(tplId).then(_renderTemplate);
      }

    });

    _addButton.onClick.listen((_) {
      _saveButton.disabled = true;
      _templateId = libtcc.TestTemplate.noId;
      _templateNameInput.value = '';
      _editArea.text = 'int main () {\n}';

      _templateNameInput.focus();
    });

    _templateNameInput.onInput.listen((_) {
      _saveButton.disabled = _templateNameInput.value.isEmpty;
    });

    _editArea.onInput.listen((_) {
      _saveButton.disabled = _templateNameInput.value.isEmpty;
    });

    _saveButton.onClick.listen((_) {
      if(_templateId == libtcc.TestTemplate.noId) {
        _templateController.create(_currentTemplate).whenComplete(_render);
      }
      else {
        _templateController.update(_currentTemplate).whenComplete(_render);
      }
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
          .children = []..addAll(templates.map(_templateToOptionElement));
        _templateSelector.children.last.focus();
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