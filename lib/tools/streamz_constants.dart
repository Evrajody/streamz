import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Politiques de couleurs  !!
///

Color sorrellBrown = const Color(0xffceb197);
Color woodsmoke = const Color(0xff0f1113);
Color shakespeare = const Color(0xff58a8c9);
Color tallPoppy = const Color(0xffbd2c2d);
Color sanMarino = const Color(0xff426eab);
Color william = const Color(0xff3c5e6a);
Color rhino = const Color(0xff2b365f);
Color kindDark = const Color.fromARGB(255, 30, 33, 38);
Color prussianBlue = const Color(0xff142739);
Color erieBlack = const Color(0xff2E2E2E);

///Constant de l'API
///

const String baseUrl = 'https://gogoanime.wiki/';
const String search = '/search.html?keyword=';
final mediaFileRegExp =
    RegExp(r"(https)://[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+[.m3u8]");
final resolutionRegExp = RegExp(r'[0-9]+(P)');
const userAgent =
    'Mozilla/5.0 (X11; Fedora; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36';
const origin = 'https://goload.one';
const referer = 'https://gogoplay.io';
Map<String, String> header = {
  'User-Agent': userAgent,
  // 'Origin': origin,
  'Referer': referer,
};

// Liste des items de la barre de navigation
List navbarTools = [
  {
    "icon": const Icon(CupertinoIcons.scribble, color: Colors.white),
    "label": "Acceuil"
  },
  {
    "icon": const Icon(CupertinoIcons.search, color: Colors.white),
    "label": "Recherche"
  },
  {
    "icon": const Icon(CupertinoIcons.square_arrow_down, color: Colors.white),
    "label": "Telecharges"
  },
  {
    "icon": const Icon(CupertinoIcons.person, color: Colors.white),
    "label": "Vous"
  },
];

List animeBoxData = [
  {
    "watchings": [
      {
        "animeName": "L'Attaque des Titans",
        "animeLink":
            "https://media.kitsu.io/manga/poster_images/14916/original.jpg",
        "animeProgess": "Saison 1"
      },
      {
        "animeName": "Cowboy Bebop",
        "animeLink": "https://media.kitsu.io/anime/poster_images/1/large.jpg",
        "animeProgess": "Saison 1"
      },
      {
        "animeName": "Trigun",
        "animeLink":
            "https://media.kitsu.io/anime/poster_images/3/original.jpg",
        "animeProgess": "Saison 1"
      },
      {
        "animeName": "Witch Hunter Robin",
        "animeLink":
            "https://media.kitsu.io/anime/poster_images/4/original.jpg",
        "animeProgess": "Saison 1"
      },
      {
        "animeName": "Beet the Vandel Buster",
        "animeLink":
            "https://media.kitsu.io/anime/poster_images/5/original.jpg",
        "animeProgess": "Saison 1"
      },
      {
        "animeName": "Trigun",
        "animeLink":
            "https://media.kitsu.io/anime/poster_images/3/original.jpg",
        "animeProgess": "Saison 1"
      },
    ],
    "recently": [
      {
        "animeName": "Eyeshield 21",
        "animeLink":
            "https://media.kitsu.io/anime/poster_images/6/original.jpg",
        "animeProgess": "Saison 1"
      },
      {
        "animeName": "Cowboy Bebop",
        "animeLink":
            "https://media.kitsu.io/anime/poster_images/1/original.jpg",
        "animeProgess": "Saison 1"
      },
      {
        "animeName": "Trigun",
        "animeLink":
            "https://media.kitsu.io/anime/poster_images/3/original.jpg",
        "animeProgess": "Saison 1"
      },
    ],
    "recommendation": [
      {
        "animeName": "Fullmetal Alchemist",
        "animeLink": "https://media.kitsu.io/anime/poster_images/100/large.jpg",
        "animeProgess": "Saison 1"
      },
      {
        "animeName": "Monster",
        "animeLink": "https://media.kitsu.io/anime/poster_images/10/large.jpg",
        "animeProgess": "Saison 1"
      },
      {
        "animeName": "Naruto",
        "animeLink": "https://cdn.myanimelist.net/images/anime/13/17405.jpg",
        "animeProgess": "Saison 1"
      },
    ]
  },
];

String imagelink = "https://w.wallhaven.cc/full/43/wallhaven-43m99n.jpg";
