# EduVerse

EduVerse est une application mobile Flutter dédiée à l'apprentissage en ligne. Elle permet aux apprenants de parcourir un catalogue de cours, suivre leur progression, répondre à des quiz, participer à des exercices, gérer leurs favoris et consulter leur profil.

## Fonctionnalités

- Authentification simple et fluide
- Catalogue de cours avec recherche
- Suivi de progression personnalisée
- Quiz et exercices d’apprentissage
- Favoris et notifications
- Communauté, forum et chat coach
- Profil avec certificats et mode hors ligne

## Stack technique

- Flutter
- Dart
- Provider pour la gestion d’état
- Architecture orientée domaine / données / présentation

## Prérequis

- Flutter SDK installé et configuré
- Android Studio ou Xcode selon votre cible de test
- Un émulateur ou un appareil physique connecté

## Démarrage rapide

1. Clonez le projet
2. Installez les dépendances :
   `flutter pub get`
3. Lancez l’application :
   `flutter run`

## Structure du projet

```text
lib/
  data/
    datasources/
    repositories/
  domain/
    entities/
    repositories/
  presentation/
    screens/
    state/
  main.dart
```

## Architecture

Le projet suit une logique Clean Architecture avec une séparation claire entre :

- le domaine métier
- les sources de données
- la couche présentation et l’état applicatif

Cette organisation permet de préparer sans friction le remplacement de la source de données par un backend réel.

## Scripts utiles

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

## Roadmap

- branchement d’un backend réel
- authentification sécurisée
- synchronisation des données utilisateur
- enrichissement des parcours d’apprentissage
- analytics et recommandations

## Contribution

Les contributions sont les bienvenues. Avant de proposer une modification, vérifiez le bon fonctionnement avec les commandes ci-dessus.
