part of tcc.client.view;

class ConfigPanel implements Panel {

  final Element _root;
  final controller.Config _configController;
  InputElement get _jenkinsInputField => _root.querySelector('#configuration-jenkins-url');
  ButtonElement get _saveButton => _root.querySelector('button.save');
  final libtcc.Configuration _configModel;

  ConfigPanel(this._root, this._configController, this._configModel) {
    _render();
    _observers();
  }

  _observers() {
    _saveButton.onClick.listen((_) {
      /// Update the model information.
      _configModel.jenkinsUri = Uri.parse(this._jenkinsInputField.value);
      _configController.save().then((_) => _render());
    });
  }

  _select() {
    _root.hidden = false;
  }

  _render() {
    this._jenkinsInputField.value = _configModel.jenkinsUri.toString();
  }

}