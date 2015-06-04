// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'src/httpclient.dart';

import 'src/view/view.dart' as View;


HttpClient client = new HttpClient();


void main() {
  View.UI ui = new View.UI();
}

Future addNewActor(String name) {
  Uri uri = Uri.parse('http://localhost:7777/actor/$name');

  return client.post(uri, '');
}

Future<Iterable<String>> listActors() {
  Uri uri = Uri.parse('http://localhost:7777/actor');

  return client.get(uri).then(JSON.decode);
}


DivElement useCase () {

  return new DivElement()
    ..children =
      [new HeadingElement.h2()..text = 'Name',
       new ParagraphElement()..text = 'description',
       new HeadingElement.h3()..text = 'Primary actor:',
       new ParagraphElement()..text = 'Actor name',
       new HeadingElement.h3()..text = 'Primary actor',
       new UListElement()..children];


}

void hideAll() =>
  querySelectorAll('section').forEach((Element e) => e.hidden = true);
