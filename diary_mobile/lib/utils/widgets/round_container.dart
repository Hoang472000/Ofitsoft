import 'package:flutter/material.dart';

class RoundContainer extends Container {

  RoundContainer({
    super.key,
    super.padding = const EdgeInsets.all(8),
    super.margin = const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
    super.child
  });

  @override
  Decoration? get decoration => const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8))
  );
}