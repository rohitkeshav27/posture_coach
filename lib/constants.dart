import 'package:flutter/material.dart';
import 'package:posture_coach/screens/excercises_screeen.dart';
import 'package:posture_coach/screens/exercise_model_screen.dart';
import 'package:posture_coach/screens/exercise_screen_general.dart';

const kbicep_info_front =
    'Biceps curl is a general term for a series of strength'
    ' exercises that involve brachioradialis, '
    'front deltoid and the main target on biceps brachii.'
    'Includes variations using barbell, dumbbell and resistance band, etc.';

const kbicep_info_back = 'Types of Bicep Curl:\n\n'
    '-Concentration Curl \n-Hammer Curl\n-Spider Curl \n-Zottman Curl\n-Cable Curls ';

const kbicep_info_style = TextStyle(
    //fontFamily: 'Acetone',
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 20.0);

const kraise_info_front = 'The front raise is a weight training exercise.'
    ' This exercise is an isolation exercise which isolates shoulder flexion.'
    'It primarily works the anterior deltoid, with assistance from the serratus anterior,'
    ' biceps brachii ';

const kraise_info_back =
    'Types of Shoulder front raise:\n\n-Barbell\n\n-Dumbbell\n\n-Cable';

const kpress_info_front = 'The overhead press, also referred to'
    ' as a shoulder press, military press, or simply the press, '
    ' is a weight training exercise with many variations. '
    'The exercise helps build muscular shoulders with bigger arms,';

const kpress_info_back =
    'Types of Shoulder Press:\n\n-Military Press\n\n-Push Press\n\n-Bradford Press';

const kshrug_info_front =
    'The shoulder shrug is an exercise in weight training '
    'used to develop the upper trapezius muscle.shoulder shrugs '
    'can be combined with weightlifting to help develop and strengthen'
    'your trapezius muscles or “traps.”';

const kshrug_info_back =
    'Types of shoulder shrugs\n\nSeated Dumbbells\n\nHaney Barbell'
    '\n\nLaying Bar';

final bicep_exercise_screen = ExerciseScreenGeneral(
  video_name: "videos/bicep.mp4",
  padding_value: 95.0,
  exercise_name: 'Biceps Curl',
  card_front_info: kbicep_info_front,
  card_back_info: kbicep_info_back,
  route_grind_now: 'bicep/bicepmod',
);
final bicep_model_screen =
    ExerciseModelScreen(exercise_name: 'Bicep Curl Model Screen');

final press_exercise_screen = ExerciseScreenGeneral(
  video_name: "videos/press.mp4",
  padding_value: 60.0,
  exercise_name: "Shoulder Press",
  card_front_info: kpress_info_front,
  card_back_info: kpress_info_back,
  route_grind_now: '/press/pressmod',
);

final press_model_screen =
    ExerciseModelScreen(exercise_name: 'Shoulder Press Model Screen');

final raise_exercise_screen = ExerciseScreenGeneral(
  video_name: "videos/frontraise.mp4",
  padding_value: 40.0,
  exercise_name: "Shoulder Front Raise",
  card_front_info: kraise_info_front,
  card_back_info: kraise_info_back,
  route_grind_now: 'raise/raisemod',
);

final raise_model_screen =
    ExerciseModelScreen(exercise_name: 'Shoulder Front Raise Model Screen');

final shrug_exercise_screen = ExerciseScreenGeneral(
  video_name: "videos/Shrug.mp4",
  padding_value: 40.0,
  exercise_name: "Shoulder Shrugs",
  card_front_info: kshrug_info_front,
  card_back_info: kshrug_info_back,
  route_grind_now: 'shrug/shrugmod',
);
final shrug_model_screen =
    ExerciseModelScreen(exercise_name: 'Shoulder Shrugs Model Screen');
