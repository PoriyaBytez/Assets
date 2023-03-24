import 'dart:ui';
import 'package:flutter/material.dart';
// String catogary_name = '';


TextStyle? commonTextStyle = const TextStyle(fontSize: 14);

//color
Color Border_color = const Color(0xffffffff);
Color TextFiel_Background = const Color(0x0dE65913);
Color Submit_button = const Color(0xffE65913);
Color BackGround = const Color(0xffE65913);
Color Icon_color = const Color(0xffE65913);


/// get APIs
String baseUrl = 'https://api.sas.co.na/nac/rest/v1/';
String categoryUrl = '${baseUrl}category';
String subCategoryUrl = '${baseUrl}subcategory1';
String locationUrl = '${baseUrl}location';
String descriptionUrl = '${baseUrl}depreciation';
String ownerUrl = '${baseUrl}owner';


/// post APIs
String postAssetsUrl = '${baseUrl}asset';

/*
        "name": "Test Asset",
        "description": null,
        "category": "100117",
        "subcategory1": "100146",
        "subcategory2": "100192",
        "acquired": null,
        "acquired_amt": null,
        "location": "100112",
        "status": null,
        "depreciation": "100114",
        "owner": "100105",
        "hashref": null,
        "image1": "asset_Images/f0b5fdf2.image1.131950.jpg",
        "image2": "asset_Images/f0b5fdf2.image2.131950.jpg",
        "image3": null,
        "image4": null,
        "invoice": null
*/
