import 'dart:io';
import 'package:boilerplate/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';

class Images {
  Images._();

  static const coverImages = [
    'assets/images/covers/beige-orange-corners.png',
    'assets/images/covers/blue-pink-stripes.png',
    'assets/images/covers/blue-purple-stripes.png',
    'assets/images/covers/blue-yellow-stripes.png',
    'assets/images/covers/green-yellow-stripes.png',
    'assets/images/covers/light-green-purple-stripes.png',
    'assets/images/covers/light-green-purple-white-stripes.png',
    'assets/images/covers/orange-white-stripes.png',
    'assets/images/covers/purple-brown-corners.png',
    'assets/images/covers/yellow-green-stripes.png',
  ];

  static getCoverImage(String imagePath) {
    if (imagePath.isNullOrWhitespace) {
      // TODO change to default error image, log error when this happens
      return Image.asset(
        'assets/images/covers/default-cover.png',
        fit: BoxFit.cover,
      );
    }

    if (imagePath.contains('data')) {
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
      );
    }

    // TODO handle case where network image is valid url, but not found in server
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
      );
    }

    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
    );
  }

  static getRecipePreviewImage(String imagePath) {
    if (imagePath.isNullOrWhitespace) {
      return Image.asset(
        'assets/images/covers/default-cover.png',
        fit: BoxFit.cover,
        width: 80,
        height: double.infinity,
      );
    }
    // TODO handle case where network image is valid url, but not found in server
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        width: 80,
        height: double.infinity,
      );
    }

    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
      width: 80,
      height: double.infinity,
    );
  }

  static getRecipeFullImage(String imagePath) {
    if (imagePath.isNullOrWhitespace) {
      return Image.asset(
        'assets/images/covers/default-cover.png',
        fit: BoxFit.cover,
        height: double.infinity,
      );
    }
    // TODO handle case where network image is valid url, but not found in server
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        height: double.infinity,
      );
    }

    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
      height: double.infinity,
    );
  }
}
