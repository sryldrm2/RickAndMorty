import 'package:flutter/material.dart';
import 'package:rickandmorty/app/locator.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/services/api_services.dart';

class CharactersViewmodel extends ChangeNotifier {
  final _apiServices = locator<ApiServices>();

  CharactersModel? _charactersModel;
  CharactersModel? get charactersModel => _charactersModel;

  void clearCharacters() {
    _charactersModel = null;
    currentPageIndex = 1;
    notifyListeners();
  }

  void getCharacters() async {
    _charactersModel = await _apiServices.getCharacters();
    notifyListeners();
  }

  bool loadMore = false;
  int currentPageIndex = 1;

  void setLoadMore(bool value) {
    loadMore = value;
    notifyListeners();
  }

  void getCharactersMore() async {
    if (loadMore) return;

    if (_charactersModel!.info.pages == currentPageIndex) return;

    setLoadMore(true);
    final data = await _apiServices.getCharacters(
      url: _charactersModel?.info.next,
    );
    setLoadMore(false);

    currentPageIndex++;

    _charactersModel!.info = data.info;
    _charactersModel!.characters.addAll(data.characters);

    notifyListeners();
  }

  void getCharactersByName(String name) async {
    clearCharacters();
    _charactersModel = await _apiServices.getCharacters(args: {'name': name});
    notifyListeners();
  }
}
