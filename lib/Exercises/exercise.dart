class Exercise {
  String name;
  String cardInfoFront;
  String cardInfoBack;
  String route;
  String videoURL;

  Exercise(String name, String route, String videoURL, String cardInfoFront,
      String cardInfoBack) {
    this.name = name;
    this.route = route;
    this.videoURL = videoURL;
    this.cardInfoFront = cardInfoFront;
    this.cardInfoBack = cardInfoBack;
  }
}

final List<Exercise> exercises = [
  Exercise(
      'Bicep Curl',
      '/bicep/bicepmod',
      "videos/bicepCurl.mp4",
      'Instructions:\n\t'
          '-Face towards the side\n\t'
          '-Train one arm at a time\n\t'
          '-The arm you wish to train should face your phone\n\t'
          '-Using a dumbbell is recommended\n\t'
          '-Start with a light weight and gradually increase\n\n'
          'Tap for description',
      'Biceps curl is a general term for a series of strength '
          'exercises that involve brachioradialis, '
          'front deltoid and the main target on biceps brachii. '
          'Includes variations using barbell, dumbbell and resistance band, etc.'),
  Exercise(
      "Shoulder Front Raise",
      '/raise/raisemod',
      "videos/frontRaise.mp4",
      'Instructions:\n\t'
          '-Face towards the side\n\t'
          '-Train one arm at a time\n\t'
          '-The arm you wish to train should face your phone\n\t'
          '-Using a dumbbell is recommended\n\t'
          '-Start with a light weight and gradually increase\n\n'
          'Tap for description',
      'The front raise is a weight training exercise.'
          ' This exercise is an isolation exercise which isolates shoulder flexion.'
          'It primarily works the anterior deltoid, with assistance from the serratus anterior,'
          ' biceps brachii '),
  Exercise(
      "Shoulder Press",
      '/press/pressmod',
      "videos/ShoulderPress.mp4",
      'Instructions:\n\t'
          '-Face towards your phone\n\t'
          '-Stand while exercising\n\t'
          '-Train both arms simultaneously\n\t'
          '-Using dumbbells are recommended\n\t'
          '-Start with a light weight and gradually increase\n\n'
          'Tap for description',
      'The overhead press, also referred to '
          'as a shoulder press, military press, or simply the press, '
          'is a weight training exercise with many variations. '
          'The exercise helps build muscular shoulders with bigger arms,'),
  Exercise(
      "Squats",
      '/squats/squatsmod',
      "videos/squats.mp4",
      'Instructions:\n\t'
          '-Face towards the side\n\t'
          '-You can keep your arms out to maintain balance\n\t'
          '-Make sure your feet are flat on ground at all times\n\t'
          '-Keep your back straight throughout the exercise\n\t'
          'Tap for description',
      'A squat is a strength exercise in which the trainee lowers their hips from a standing position and then stands back up.')
];
