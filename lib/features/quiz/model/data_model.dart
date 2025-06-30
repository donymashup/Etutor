import 'package:etutor/features/quiz/model/quiz_model.dart';

final class DataModel {
  static List<Quiz> quizList = [
    Quiz(
      type: "keam",
      statement: r"""<h3>What is the correct form of quadratic formula?</h3>""",
      options: [
        QuizOption("id_1", r"""\(x = {-b \pm \sqrt{b^2+4ac} \over 2a}\)""", "A"),
        QuizOption("id_2", r"""\(x = {b \pm \sqrt{b^2-4ac} \over 2a}\)""", "B"),
        QuizOption("id_3", r"""\(x = {-b \pm \sqrt{b^2-4ac} \over 2a}\)""", "C"),
        QuizOption("id_4", r"""\(x = {-b + \sqrt{b^2+4ac} \over 2a}\)""", "D"),
        QuizOption("id_5", r"""\(x = {b + \sqrt{b+4ac} \over 2a}\)""", "E"),
      ],
      correctOptionId: "id_3",
    ),
    Quiz(
      type: "mmcq",
      statement: r"""
        <p style="font-size: 18px;">
          <b>Which of the following represents the formula for kinetic energy?</b><br><br>
          <img src="https://www.fire2fusion.com/assets/images/kinetic-energy/Picture1.png?_cchid=74c1a074cc814493e4574fba722d8b0a" width="250px" />
        </p>
      """,
      options: [
        QuizOption("id_1", r"""<p style="font-size: 18px;">\( KE = \frac{1}{2}mv^2 \)</p>""", "A"),
        QuizOption("id_2", r"""<p style="font-size: 18px;">\( F = ma \)</p>""", "B"),
        QuizOption("id_3", r"""<p style="font-size: 18px;">\( E = mc^2 \)</p>""", "C"),
        QuizOption("id_4", r"""<p style="font-size: 18px;"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/0e/NewtonsLawOfUniversalGravitation.svg/1200px-NewtonsLawOfUniversalGravitation.svg.png" width="200px" /></p>""", "D"),
      ],
      correctOptionIds: ["id_1", "id_4"],
    ),
    Quiz(
      type: "smcq",
      statement: r"""<h3>Choose the correct mathematical form of Bohr's Radius.</h3>""",
      options: [
        QuizOption("id_1", r"""\( a_0 = \frac{{\hbar ^2 }}{{m_e ke^2 }} \)""", "A"),
        QuizOption("id_2", r"""\( a_0 = \frac{{\hbar ^2 }}{{m_e ke^3 }} \)""", "B"),
        QuizOption("id_3", r"""\( a_0 = \frac{{\hbar ^3 }}{{m_e ke^2 }} \)""", "C"),
        QuizOption("id_4", r"""\( a_0 = \frac{{\hbar }}{{m_e ke^2 }} \)""", "D"),
      ],
      correctOptionId: "id_1",
    ),
    Quiz(
      type: "smcq",
      statement: r"""<h3>Select the correct Chemical Balanced Equation.</h3>""",
      options: [
        QuizOption("id_1", r"""\( \ce{CO + C -> 2 CO} \)""", "A"),
        QuizOption("id_2", r"""\( \ce{CO2 + C ->  CO} \)""", "B"),
        QuizOption("id_3", r"""\( \ce{CO + C ->  CO} \)""", "C"),
        QuizOption("id_4", r"""\( \ce{CO2 + C -> 2 CO} \)""", "D"),
      ],
      correctOptionId: "id_4",
    ),
    Quiz(
      type: "numerical",
      statement: r"""<h3>What is the sum of 5 and 3?</h3>""",
      correctAnswer: 8,
    ),
  ];
}
