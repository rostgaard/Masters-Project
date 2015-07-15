part of tcc.client.view;

class ConfigPanel implements Panel {

  final Element _root;
  final controller.Config _configController;
  InputElement get _jenkinsInputField => _root.querySelector('#configuration-jenkins-url');
  InputElement get _testPathInputField => _root.querySelector('#configuration-test-path');
  InputElement get _analyzerInputField => _root.querySelector('#configuration-analyzer-path');
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
      _configModel.testLocation = this._testPathInputField.value;
      _configModel.analyzerLocation = this._analyzerInputField.value;

      _configController.save().then((_) => _render());
    });
  }

  _select() {
    _root.hidden = false;
  }

  _render() {
    _jenkinsInputField.value = _configModel.jenkinsUri.toString();
    _testPathInputField.value = _configModel.testLocation;
    _analyzerInputField.value = _configModel.analyzerLocation;
  }

}