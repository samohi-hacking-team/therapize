import 'package:flutter/material.dart';

class Therapist {
  final String path;
  
  final String name;

  final String type;
  /*
    Client-Centered Therapist.                    
    Existential Therapist.
    Gestalt Therapist.
    Humanistic Therapist.
    Interpersonal Therapist.
    Rational Emotive Behavioral Therapist.
    Relational Therapist.
  */

  final double rating;

  Therapist({
    @required this.path,
    @required this.name,
    @required this.type,
    @required this.rating,
  });
  
}
