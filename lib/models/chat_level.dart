class ChatLevel {
  static const BOT_KEY = 'bot';
  static const USER_KEY = 'user';

  final String levelName;
  final String botName;
  final String botImg;
  final String userImg;
  final Map<String, List<String>> chatList;
  final List<String> successMessages;
  final List<String> failureMessages;

  ChatLevel({
    this.levelName,
    this.botName,
    this.botImg,
    this.userImg,
    this.chatList,
    this.successMessages,
    this.failureMessages,
  });

  bool isSuccessMessage(String message) =>
      this.successMessages.contains(message);
  bool isErrorMessage(String message) => this.failureMessages.contains(message);
  bool get willSenderInitiateChat => chatList.keys.first == BOT_KEY;
  String get getSenderMessage => chatList[BOT_KEY][0];
  String get getReceiverMessage => chatList[USER_KEY][0];
  static bool isLie(String message) => message.contains('(Lie)');
  static bool isTruth(String message) => message.contains('(Truth)');
  static String truncateLie(String message) =>
      message.replaceAll('(Lie)', '').trim();
  static String truncateTruth(String message) =>
      message.replaceAll('(Truth)', '').trim();

  static ChatLevel firstLevel() {
    Map<String, List<String>> chatList = Map();

    chatList[BOT_KEY] = ['Hi! Do you have shoes in your shop?'];
    chatList['Hi! Do you have shoes in your shop?'] = ['No sorry', 'Yes'];
    chatList['No sorry'] = ['I really need them 😞'];
    chatList['I really need them 😞'] = [
      'No sorry 😏',
      'ok we\'ll figure it out!'
    ];
    chatList['No sorry 😏'] = ['Bruhhhhhh 🤯'];
    chatList['Yes'] = ['Great I want a new sneakers!'];
    chatList['ok we\'ll figure it out!'] = ['Great I want a new sneakers!'];
    chatList['Great I want a new sneakers!'] = [
      'we don\'t have teacher\'s sneakers',
      'what\'s your size?'
    ];
    chatList['we don\'t have teacher\'s sneakers'] = ['Bruhhhhhh 🤯'];
    chatList['what\'s your size?'] = ['One inverted foot'];
    chatList['One inverted foot'] = ['That\'s too scary', 'What color?'];
    chatList['That\'s too scary'] = ['Bruhhhhhh 🤯'];
    chatList['What color?'] = ['Red with white stripes'];
    chatList['Red with white stripes'] = ['Good choice!', '2 or 4 sneakers?'];
    chatList['Good choice!'] = ['I want 4. One for each leg!'];
    chatList['2 or 4 sneakers?'] = ['I want 4. One for each leg!'];
    chatList['I want 4. One for each leg!'] = ['It\'ll be 49\$'];
    chatList['It\'ll be 49\$'] = ['Can I pay in diamonds?'];
    chatList['Can I pay in diamonds?'] = ['NO!', 'Uhh ok..'];
    chatList['NO!'] = ['Bruhhhhhh 🤯'];
    chatList['Uhh ok..'] = ['Great! Thank you 😍'];

    return ChatLevel(
      levelName: 'Sell teacher shoes',
      botName: 'Scary Teacher',
      botImg: 'assets/images/avatar/boy.png',
      userImg: 'assets/default.jpg',
      chatList: chatList,
      successMessages: ['Great! Thank you 😍'],
      failureMessages: ['Bruhhhhhh 🤯'],
    );
  }

  static List<ChatLevel> allLevels() {
    return [
      level1(),
      level2(),
      level3(),
      level4(),
      level5(),
      level6(),
      level7(),
      level8(),
      level9(),
      level10(),
      level1(),
      level2(),
      level3(),
      level4(),
      level5(),
      level6(),
      level7(),
      level8(),
      level9(),
      level10(),
    ];
  }

  static ChatLevel anotherLevel() {
    Map<String, List<String>> chatList = Map();

    chatList[USER_KEY] = ['No sorry', 'Yes'];
    chatList['No sorry'] = ['I really need them 😞'];
    chatList['I really need them 😞'] = [
      'No sorry 😏',
      'ok we\'ll figure it out!'
    ];
    chatList['No sorry 😏'] = ['Bruhhhhhh 🤯'];
    chatList['Yes'] = ['Great I want a new sneakers!'];
    chatList['ok we\'ll figure it out!'] = ['Great I want a new sneakers!'];
    chatList['Great I want a new sneakers!'] = [
      'we don\'t have teacher\'s sneakers',
      'what\'s your size?'
    ];
    chatList['we don\'t have teacher\'s sneakers'] = ['Bruhhhhhh 🤯'];
    chatList['what\'s your size?'] = ['One inverted foot'];
    chatList['One inverted foot'] = ['That\'s too scary', 'What color?'];
    chatList['That\'s too scary'] = ['Bruhhhhhh 🤯'];
    chatList['What color?'] = ['Red with white stripes'];
    chatList['Red with white stripes'] = ['Good choice!', '2 or 4 sneakers?'];
    chatList['Good choice!'] = ['I want 4. One for each leg!'];
    chatList['2 or 4 sneakers?'] = ['I want 4. One for each leg!'];
    chatList['I want 4. One for each leg!'] = ['It\'ll be 49\$'];
    chatList['It\'ll be 49\$'] = ['Can I pay in diamonds?'];
    chatList['Can I pay in diamonds?'] = ['NO!', 'Uhh ok..'];
    chatList['NO!'] = ['Bruhhhhhh 🤯'];
    chatList['Uhh ok..'] = ['Great! Thank you 😍'];

    return ChatLevel(
      levelName: 'Borrow his car',
      botName: 'Felix',
      botImg: 'assets/images/avatar/boy.png',
      userImg: 'assets/default.jpg',
      chatList: chatList,
      successMessages: ['Great! Thank you 😍'],
      failureMessages: ['Bruhhhhhh 🤯'],
    );
  }

  static ChatLevel level1() {
    Map<String, List<String>> chatList = Map();

    chatList[USER_KEY] = ['Hi!'];
    chatList['Hi!'] = ['Hi'];
    chatList['Hi'] = ['You Know a new cafe opened recently?'];
    chatList['You Know a new cafe opened recently?'] = [
      'Yes, I\'m interested in it!'
    ];

    chatList['Yes, I\'m interested in it!'] = [
      'let\'s go together',
      'you should go alone'
    ];
    chatList['let\'s go together'] = ['sure!'];
    chatList['you should go alone'] = ['Don\'t text me again'];

    return ChatLevel(
      levelName: 'Ask for Date',
      botName: 'Anna',
      botImg: 'assets/images/avatar/girl.png',
      userImg: 'assets/images/avatar/boy.png',
      chatList: chatList,
      successMessages: ['sure!'],
      failureMessages: ['Don\'t text me again'],
    );
  }

  static ChatLevel level2() {
    Map<String, List<String>> chatList = Map();

    chatList[USER_KEY] = ['Hi!'];
    chatList['Hi!'] = ['Hi, What\'s up?'];
    chatList['Hi, What\'s up?'] = [
      'Sadly, the amusement park is going to be very crowded'
    ];
    chatList['Sadly, the amusement park is going to be very crowded'] = [
      'Oh, i don\'t wanna go to crowded place.'
    ];

    chatList['Oh, i don\'t wanna go to crowded place.'] = [
      'Ok, let\'s go to another place',
      'But we must go to the amusement park',
    ];
    chatList['Ok, let\'s go to another place'] = ['Sounds good'];
    chatList['But we must go to the amusement park'] = [
      'Okay bye leave me alone.'
    ];

    return ChatLevel(
      levelName: 'Go to Date',
      botName: 'Anna',
      botImg: 'assets/images/avatar/girl.png',
      userImg: 'assets/images/avatar/boy.png',
      chatList: chatList,
      successMessages: ['Sounds good'],
      failureMessages: ['Okay bye leave me alone.'],
    );
  }

  static ChatLevel level3() {
    Map<String, List<String>> chatList = Map();

    chatList[BOT_KEY] = ['I love this resturant'];
    chatList['I love this resturant'] = [
      'Yeah, but it costs more than I thought'
    ];
    chatList['Yeah, but it costs more than I thought'] = ['Ah, i think so too'];
    chatList['Ah, i think so too'] = [
      'Do you have have money?',
      'I think i have no money'
    ];
    chatList['Do you have have money?'] = ['Why are you asking?'];
    chatList['Why are you asking?'] = ['Because you have to pay the bill'];
    chatList['Because you have to pay the bill'] = ['Get lost'];
    chatList['I think i have no money'] = ['Ah, what do you say?'];
    chatList['Ah, what do you say?'] = ['Don\'t worry i have Card'];
    chatList['Don\'t worry i have Card'] = ['Thank God you are So nice'];
    chatList['Thank God you are So nice'] = ['Welcome it\'s on me'];

    return ChatLevel(
      levelName: 'Enjoy Talk!',
      botName: 'Anna',
      botImg: 'assets/images/avatar/girl.png',
      userImg: 'assets/images/avatar/boy.png',
      chatList: chatList,
      successMessages: ['Welcome it\'s on me'],
      failureMessages: ['Get lost'],
    );
  }

  static ChatLevel level4() {
    Map<String, List<String>> chatList = Map();

    chatList[USER_KEY] = ['Have you had lunch yet?'];
    chatList['Have you had lunch yet?'] = ['No'];
    chatList['No'] = ['Wanna eat ice cream with me?'];
    chatList['Wanna eat ice cream with me?'] = [
      'I\'m in the mood for something spicy'
    ];
    chatList['I\'m in the mood for something spicy'] = [
      'No we must have ice cream',
      'How about pizza?'
    ];
    chatList['No we must have ice cream'] = [
      'I will have lunch with my friends'
    ];
    chatList['I will have lunch with my friends'] = ['Okay bye', 'Wait'];
    chatList['Wait'] = ['What happened now?'];
    chatList['What happened now?'] = ['Tell me what do you want?'];
    chatList['Tell me what do you want?'] = ['I think you better know'];
    chatList['I think you better know'] = ['How about pizza?'];
    chatList['How about pizza?'] = ['O yeah let\'s go'];

    return ChatLevel(
      levelName: 'Go Lunch',
      botName: 'Anna',
      botImg: 'assets/images/avatar/girl.png',
      userImg: 'assets/images/avatar/boy.png',
      chatList: chatList,
      successMessages: [
        'O yeah let\'s go',
      ],
      failureMessages: ['Okay bye'],
    );
  }

  static ChatLevel level5() {
    Map<String, List<String>> chatList = Map();

    chatList[USER_KEY] = ['Hey Pretty Girl'];
    chatList['Hey Pretty Girl'] = ['Yes my boy'];
    chatList['Yes my boy'] = ['Let\'s go on a trip'];
    chatList['Let\'s go on a trip'] = ['Where do you wanna go for the trip?'];
    chatList['Where do you wanna go for the trip?'] = [
      'Nice, what shall we do?'
    ];
    chatList['Nice, what shall we do?'] = ['Ski', 'Surfing'];
    chatList['Ski'] = ['I said winter vacation😒'];
    chatList['Surfing'] = ['Sounds good😍'];
    chatList[''] = [''];

    return ChatLevel(
      levelName: 'ASK For Trip',
      botName: 'Anna',
      botImg: 'assets/images/avatar/girl.png',
      userImg: 'assets/images/avatar/boy.png',
      chatList: chatList,
      successMessages: ['I said winter vacation😒'],
      failureMessages: ['Sounds good😍'],
    );
  }

  static ChatLevel level6() {
    Map<String, List<String>> chatList = Map();

    chatList[USER_KEY] = ['Hey love'];
    chatList['Hey love'] = ['Yes sweet heart'];
    chatList['Yes sweet heart'] = [
      'I have to talk with you about something important'
    ];
    chatList['I have to talk with you about something important'] = [
      'What is it?'
    ];
    chatList['What is it?'] = ['I\'m little bit nervous'];
    chatList['I\'m little bit nervous'] = ['Why?'];
    chatList['Why?'] = ['I want to say that aaaaa will you?'];
    chatList['I want to say that aaaaa will you?'] = [
      'What will you? can you tell me what\'s going on😤'
    ];
    chatList['What will you? can you tell me what\'s going on😤'] = [
      'I think i can\'t ask',
      'I mean will you marry me?💍'
    ];
    chatList['I think i can\'t ask'] = ['Okay don\'t talk to me again bye😡'];
    chatList['I mean will you marry me?💍'] = ['Sorry, No😕'];
    chatList['Sorry, No😕'] = ['What but you said you love me🥺'];
    chatList['What but you said you love me🥺'] = [
      'Oh don\'t be said i am joking😂'
    ];
    chatList['Oh don\'t be said i am joking😂'] = ['What is it a joke to you?'];
    chatList['What is it a joke to you?'] = ['Okay my love yes for marriage❤️'];
    chatList['Okay my love yes for marriage❤️'] = ['OMG i\'m so happy now❤️❤️'];

    return ChatLevel(
      levelName: 'Pupose her',
      botName: 'Anna',
      botImg: 'assets/images/avatar/girl.png',
      userImg: 'assets/images/avatar/boy.png',
      chatList: chatList,
      successMessages: ['OMG i\'m so happy now❤️❤️'],
      failureMessages: ['Okay don\'t talk to me again bye😡'],
    );
  }

  static ChatLevel level7() {
    Map<String, List<String>> chatList = Map();

    chatList[USER_KEY] = ['I bought a new car!'];
    chatList['I bought a new car!'] = ['Wow!'];
    chatList['Wow!'] = ['My red one is great!', 'Wanna go for a drive?'];
    chatList['Wanna go for a drive?'] = ['No i dont want to go today sorry😒'];
    chatList['My red one is great!'] = ['I wanna go for a drive!'];
    chatList['I wanna go for a drive!'] = [
      'OK, go tommorow!',
      'No this car is only for me'
    ];
    chatList['No this car is only for me'] = ['Huh?🤬🤬'];
    chatList['OK, go tommorow!'] = ['Yeah!😍😍'];

    return ChatLevel(
      levelName: 'Ask for First Drive',
      botName: 'Anna',
      botImg: 'assets/images/avatar/girl.png',
      userImg: 'assets/images/avatar/boy.png',
      chatList: chatList,
      successMessages: ['Yeah!😍😍'],
      failureMessages: ['No i dont want to go today sorry😒', 'Huh?🤬🤬'],
    );
  }

  static ChatLevel level8() {
    Map<String, List<String>> chatList = Map();

    chatList[BOT_KEY] = ['What do you do in this weekend?'];
    chatList['What do you do in this weekend?'] = [
      'Worked out in gym',
      'Played instruments'
    ];
    chatList['Worked out in gym'] = ['But i want to spend time with you'];
    chatList['But i want to spend time with you'] = [
      'Sorry i don\'t have time',
      'don\'t worry i will cancel my plan'
    ];
    chatList['Sorry i don\'t have time'] = ['Okay bye😢'];
    chatList['don\'t worry i will cancel my plan'] = ['O yeah😁'];
    chatList['Played instruments'] = ['Wow! i\'m intrested in it lately'];
    chatList['Wow! i\'m intrested in it lately'] = ['Let\'s do it together!'];
    chatList['Let\'s do it together!'] = ['Really? Why not!'];
    chatList['Really? Why not!'] = [
      'Ok, Lets do it next time!',
      'Actually I want to do this alone'
    ];
    chatList['Ok, Lets do it next time!'] = ['I can\'t wait❤️'];
    chatList['Actually I want to do this alone'] = [
      'Ok never ask you again 🥺'
    ];

    return ChatLevel(
      levelName: 'Enjoy weekend',
      botName: 'Anna',
      botImg: 'assets/images/avatar/girl.png',
      userImg: 'assets/images/avatar/boy.png',
      chatList: chatList,
      successMessages: ['O yeah😁', 'I can\'t wait❤️'],
      failureMessages: ['Okay bye😢', 'Ok never ask you again 🥺'],
    );
  }

  static ChatLevel level9() {
    Map<String, List<String>> chatList = Map();

    chatList[USER_KEY] = ['Hey Jane! Any plans tonight?'];
    chatList['Hey Jane! Any plans tonight?'] = ['What? Wait, who is jane?🤔😡'];
    chatList['What? Wait, who is jane?🤔😡'] = ['um, jane is my sister'];
    chatList['um, jane is my sister'] = [
      'I know you don\'t have a sister, you liar!'
    ];
    chatList['I know you don\'t have a sister, you liar!'] = [
      'Wait, she was just born last month',
      'She is my bro\'s wife'
    ];
    chatList['Wait, she was just born last month'] = [
      'How a baby can use the phone you liar 😡😡😡'
    ];
    chatList['She is my bro\'s wife'] = ['Ah ok, i understand❤️'];

    return ChatLevel(
      levelName: 'Dodge her',
      botName: 'Anna',
      botImg: 'assets/images/avatar/girl.png',
      userImg: 'assets/images/avatar/boy.png',
      chatList: chatList,
      successMessages: ['Ah ok, i understand❤️'],
      failureMessages: ['How a baby can use the phone you liar 😡😡😡'],
    );
  }

  static ChatLevel level10() {
    Map<String, List<String>> chatList = Map();

    chatList[BOT_KEY] = ['My work has been tough lately.'];
    chatList['My work has been tough lately.'] = ['Oh, did something happen?'];
    chatList['Oh, did something happen?'] = [
      'I don\'t get along with my new boss'
    ];
    chatList['I don\'t get along with my new boss'] = [
      'Why?',
      'Is every thing Alright?'
    ];
    chatList['Is every thing Alright?'] = ['I will tell you later'];
    chatList['Why?'] = ['He shout on every one all the time😕'];
    chatList['I will tell you later'] = ['Okay bye'];
    chatList['He shout on every one all the time😕'] = [
      'That\'s a lot of work, go out for a change!',
      'I think your fault, not your boss'
    ];
    chatList['That\'s a lot of work, go out for a change!'] = [
      'your are so sweet thanks for helping me out😍❤️'
    ];
    chatList['I think your fault, not your boss'] = [
      'You are bad you never help me out🥺🥺'
    ];

    return ChatLevel(
      levelName: 'Help her',
      botName: 'Anna',
      botImg: 'assets/images/avatar/girl.png',
      userImg: 'assets/images/avatar/boy.png',
      chatList: chatList,
      successMessages: ['your are so sweet thanks for helping me out😍❤️'],
      failureMessages: ['You are bad you never help me out🥺🥺', 'Okay bye'],
    );
  }

  static printUnreachableKeys() {
    allLevels().forEach((level) {
      final chatList = level.chatList;
      final allKeys = chatList.keys.toList();

      _printUnReachableKeys(level.willSenderInitiateChat ? BOT_KEY : USER_KEY,
          chatList, level, allKeys);
    });
  }

  static _printUnReachableKeys(String root, Map<String, List<String>> chatList,
      ChatLevel level, List<String> allKeys) {
    if (level.isSuccessMessage(root)) {
      // print('success message hit: $root');
      return;
    } else if (level.isErrorMessage(root)) {
      // print('error message hit: $root');
      return;
    } else if (!allKeys.contains(root)) {
      print('key does not exist: ' + root);
      return;
    }

    final list = chatList[root];

    for (int i = 0; i < list.length; i++) {
      _printUnReachableKeys(list[i], chatList, level, allKeys);
    }
  }
}
