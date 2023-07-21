class Contact {
  String name;
  String phoneNumber;
  String desc;
  String email;
  String imageAsset;
  String githubUsername;
  String linkedinUsername;
  String twitterUsername;
  String behanceUsername;
  String dribbleUsername;
  String instagramUsername;
  bool emailExists;
  bool phoneNumberExists;
  bool descExists;
  bool imageAssetExists;
  bool githubExists;
  bool linkedinExists;
  bool twitterExists;
  bool behanceExists;
  bool dribbleExists;
  bool instagramExists;

  Contact({
    required this.name,
    required this.desc,
    required this.email,
    required this.imageAsset,
    required this.phoneNumber,
    required this.githubUsername,
    required this.linkedinUsername,
    required this.twitterUsername,
    required this.behanceUsername,
    required this.dribbleUsername,
    required this.instagramUsername,
    required this.emailExists,
    required this.phoneNumberExists,
    required this.descExists,
    required this.imageAssetExists,
    required this.githubExists,
    required this.linkedinExists,
    required this.twitterExists,
    required this.behanceExists,
    required this.dribbleExists,
    required this.instagramExists,
  });
}
