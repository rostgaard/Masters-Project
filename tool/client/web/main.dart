// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'src/httpclient.dart';

HttpClient client = new HttpClient();

void main() {
  hideAll();

  querySelector('nav a.use-cases').onClick.listen((_) {

    hideAll();
    querySelector('#use-cases').hidden= false;

  });

  querySelector('nav a.actors').onClick.listen((_) {
    UListElement list = querySelector('#actors ul');

    listActors().then((Iterable<String> actorNames) {
      list.children = actorNames.map((String actorName) => new LIElement()..text = actorName).toList();
    });

    hideAll();
    querySelector('#actors').hidden= false;

  });

  querySelector('#actors button.add').onClick.listen((_) {
    InputElement e = querySelector('#actors input.add');

    addNewActor(e.value).then((_) {
      UListElement list = querySelector('#actors ul');

      listActors().then((Iterable<String> actorNames) {
        list.children = actorNames.map((String actorName) => new LIElement()..text = actorName).toList();
      });
    });
  });

  querySelector('nav a.concepts').onClick.listen((_) {
    hideAll();
    querySelector('#concepts').hidden= false;


  });

  querySelector('nav a.use-cases').click();

}

Future addNewActor(String name) {
  Uri uri = Uri.parse('http://localhost:7777/actor/$name');

  return client.post(uri, '');
}

Future<Iterable<String>> listActors() {
  Uri uri = Uri.parse('http://localhost:7777/actor');

  return client.get(uri).then(JSON.decode);
}



void hideAll() =>
  querySelectorAll('section').forEach((Element e) => e.hidden = true);
