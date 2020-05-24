import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:therapize/components/platform_widgets/platform_page_route.dart';
import 'package:therapize/components/themed_text.dart';
import 'package:therapize/components/therapist_card.dart';
import 'package:therapize/models/therapist.dart';

class MyTherapists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ThemedText(
                  "My Therapists",
                  textType: TextType.header,
                ),
              ),
              Material(
                type: MaterialType.transparency,
                child: InkWell(
                  // onTap: () =>Navigator.of(context).push(
                  //   platformPageRoute()
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ThemedText(
                      "See all",
                      textType: TextType.selectable,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 130,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                TherapistCard(
                  therapist: Therapist(
                    name: "Benjamin Swerdlow",
                    imagePath: "sm",
                    description:
                        """When I was a freshman in high school I accidentally found myself inside the City of Santa Monica's report database through a project with Hack for LA. Instead of reprimanding me, they offered me an internship...until they realized I was 15.

TL;DR:
- Highschool Student
- Aspiring Developer
- Mobile Development Experience
- UX Experience
- Self Motivated

Mobile dev:
I wrote my first Swift app that year too. Sophomore year (I'm still a sophomore) I switched to Flutter, Google's Mobile UI Framework. Since then I have published 4 Flutter apps, and I am working on 2 more in my free time. I contributed to The Orange Alliance, the data provider for FIRST Tech Challenge.
Web dev:
I've also contributed to the Yale Open Lab Climate Collaboration and was a part of the team that won the Community Choice Award and the Most Innovative Contribution Award. I am also working with K.I.C.K. to revamp their website.

Qualifications:
Though I may not have as much traditional experience as many other programmers, I am a fast learner, and I am self-motivated. I am self-taught in Flutter, and I am currently teaching myself ReactJS. I taught myself Python and Java in middle school. While I would like to say I am completely self-taught, I have taken Javascript, C, Python, and AWS classes at SMC and have earned an "Entry Level Programmer" certificate from the SMC Computer Science Department.

Extras:
- Experience with Node.js
- Experience with Stripe Payment Processing
- Experience with client-side networking """,
                    rating: 4.2,
                    type: "Existential Therapist",
                    path: "sgsdgsg",
                  ),
                ),
                TherapistCard(
                  therapist: Therapist(
                    path: "aasfasf",
                    name: "Jessica Golden",
                    rating: 5.0,
                    type: "Humanistic Therapist",
                    imagePath: "Sgsdg",
                    description: """Hi, I am Jessica.
                    
My hobbies define me. They have evolved over the years, but I have always had an intense passion for math in particular. My older brother used to "tutor" me in math when I was in preschool and it stuck. In school, I am known as the math nerd that finds joy in tutoring friends. Additionally, I am one of the captains of both the Samohi Mathletes and Science Olympiad teams which has given me so many amazing leadership opportunities. In my free time, I like to solve puzzles and I am excessively obsessed with cryptograms in particular. Furthermore, I am a passionate percussionist currently enrolled in three music classes. Last but not least, I have been working diligently on improving my skill set in graphic design."""
                  ),
                ),
                TherapistCard(
                  therapist: Therapist(
                    path: "sgsdgdsg",
                    name: "Jason Telanoff",
                    rating: 2.0,
                    type: "Bad Therapist",
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
