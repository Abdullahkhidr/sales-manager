import 'package:flutter/material.dart';
import 'package:manager/core/theme_app/fonts_app.dart';
import 'package:manager/core/theme_app/theme_app.dart';

// ignore: non_constant_identifier_names
SliverAppBar AppBarWidget(String title,
        {Widget? iconButton, bool center = true}) =>
    SliverAppBar(
        snap: true,
        floating: true,
        pinned: true,
        title: Text(title, style: Fonts.t2(fontWeight: FontWeight.w500)),
        centerTitle: center,
        backgroundColor: colorScheme.background,
        actions: [if (iconButton != null) iconButton]);
