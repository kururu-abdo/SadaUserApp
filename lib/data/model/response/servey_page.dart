import 'package:flutter/material.dart';
import 'package:flutter_survey/flutter_survey.dart';

class ServeyPage extends StatefulWidget {
  const ServeyPage({ Key key }) : super(key: key);

  @override
  _ServeyPageState createState() => _ServeyPageState();
}

class _ServeyPageState extends State<ServeyPage> {


  List<Question> _initialData = [
  Question(
    isMandatory: true,
    question: 'Do you like drinking coffee?',
    answerChoices: {
      "Yes": [
        Question(
            singleChoice: false,
            question: "What are the brands that you've tried?",
            answerChoices: {
              "Nestle": null,
              "Starbucks": null,
              "Coffee Day": [
                Question(
                  question: "Did you enjoy visiting Coffee Day?",
                  isMandatory: true,
                  answerChoices: {
                    "Yes": [
                      Question(
                        question: "Please tell us why you like it",
                      )
                    ],
                    "No": [
                      Question(
                        question: "Please tell us what went wrong",
                      )
                    ],
                  },
                )
              ],
            })
      ],
      "No": [
        Question(
          question: "Do you like drinking Tea then?",
          answerChoices: {
            "Yes": [
              Question(
                  question: "What are the brands that you've tried?",
                  answerChoices: {
                    "Nestle": null,
                    "ChaiBucks": null,
                    "Indian Premium Tea": [
                      Question(
                        question: "Did you enjoy visiting IPT?",
                        answerChoices: {
                          "Yes": [
                            Question(
                              question: "Please tell us why you like it",
                            )
                          ],
                          "No": [
                            Question(
                              question: "Please tell us what went wrong",
                            )
                          ],
                        },
                      )
                    ],
                  })
            ],
            "No": null,
          },
        )
      ],
    },
  ),
  Question(
      question: "What age group do you fall in?",
      isMandatory: true,
      answerChoices: const {
        "18-20": null,
        "20-30": null,
        "Greater than 30": null,
      })
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Survey(
          initialData: _initialData,
          onNext:(questionResults){
              print(questionResults);
              //store the result
          },
        ),
    );
  }
}