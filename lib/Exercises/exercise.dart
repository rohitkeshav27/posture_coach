class Exercise {
  String name;
  String cardInfoFront;
  String cardInfoBack;
  String route;
  String videoURL;
  double paddingValue;

  Exercise(String name, String route, String videoURL, String cardInfoFront,
      String cardInfoBack, double padding) {
    this.name = name;
    this.route = route;
    this.videoURL = videoURL;
    this.cardInfoFront = cardInfoFront;
    this.cardInfoBack = cardInfoBack;
    this.paddingValue = padding;
  }
}

final List<Exercise> exercises = [
  Exercise(
      'Bicep Curl',
      '/bicep/bicepmod',
      "videos/bicep.mp4",
      'Biceps curl is a general term for a series of strength'
          ' exercises that involve brachioradialis, '
          'front deltoid and the main target on biceps brachii. '
          'Includes variations using barbell, dumbbell and resistance band, etc.',
      'Types of Bicep Curl:\n'
          '\t-Concentration Curl \n\t-Hammer Curl\n\t-Spider Curl \n\t-Zottman Curl\n\t-Cable Curls ',
      95.0),
  Exercise(
      "Shoulder Front Raise",
      '/raise/raisemod',
      "videos/frontraise.mp4",
      'The front raise is a weight training exercise.'
          ' This exercise is an isolation exercise which isolates shoulder flexion.'
          'It primarily works the anterior deltoid, with assistance from the serratus anterior,'
          ' biceps brachii ',
      'Types of Shoulder front raise:\n\t-Barbell\n\t-Dumbbell\n\t-Cable',
      40.0),
  Exercise(
      "Shoulder Press",
      '/press/pressmod',
      "videos/press.mp4",
      'The overhead press, also referred to'
          ' as a shoulder press, military press, or simply the press, '
          ' is a weight training exercise with many variations. '
          'The exercise helps build muscular shoulders with bigger arms,',
      'Types of Shoulder Press:\n\t-Military Press\n\t-Push Press\n\t-Bradford Press',
      60.0),
  Exercise(
      "Tricep Extension",
      '/tricepExtension/tricepExtensionmod',
      "videos/Shrug.mp4",
      'TRICEP EXTENSION STUFF',
      'Types of TricepExtension',
      40.0)
];
