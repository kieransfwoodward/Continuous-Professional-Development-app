import 'package:cpd/screens/splash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'home_screen.dart';
import 'package:hexcolor/hexcolor.dart';

// void main() => runApp(App());
//
// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
//     );
//
//     return MaterialApp(
//       title: 'Introduction screen',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: OnBoardingPage(),
//     );
//   }
// }

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => welcomeSplash()),
    );
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 300]) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Image.asset('assets/$assetName', width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 18.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      // globalHeader: Align(
      //   alignment: Alignment.topRight,
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.only(top: 16, right: 16),
      //       child: _buildImage('logoAlt.PNG', 75),
      //     ),
      //   ),
      // ),
      // globalFooter: SizedBox(
      //   width: double.infinity,
      //   height: 45,
      //   child: ElevatedButton(
      //     child: const Text(
      //       'Let\'s go right away!',
      //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      //     ),
      //     onPressed: () => _onIntroEnd(context),
      //   ),
      // ),
      pages: [
        PageViewModel(
          title: "Earn Points and Develop Skills",
          body:
          "Complete each of the modules to develop your skills and to earn points. Don't worry "
              "if you don't get it first time, jump back in when you're ready to try again.",
          image: _buildImage('introHome.PNG'),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 12),
            bodyFlex: 1,
            imageFlex: 2 ,
          ),
        ),
        PageViewModel(
          title: "Get Briefed",
          body:
          "Before you jump into the module, see what knowledge you will gain and the benefits "
              "it has on your work.",
          image: _buildImage('introModule.PNG'),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 12),
            bodyFlex: 1,
            imageFlex: 2,
          ),
        ),
        PageViewModel(
          title: "Test Your Knowledge",
          body:
          "Throughout the modules you will get the chance to test your knowledge. Don't worry if you "
              "get the answer wrong, there will be plenty of opportunities throughout to earn "
              "enough points to pass the module.",
          image: _buildImage('introKnowledge.PNG'),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 12),
            bodyFlex: 1,
            imageFlex: 2,
          ),
        ),
        PageViewModel(
          title: "Learn with Images and Videos",
          body:
          "Don't worry, it's not all reading. There are various videos and images from workers within the field to "
              "see their opinions.",
          image: _buildImage('introImage.PNG'),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 12),
            bodyFlex: 1,
            imageFlex: 2,
          ),
        ),
        PageViewModel(
          title: "See What Others Think",
          body:
          "Fill the box with your answer and compare it to what other people have said to the same question.",
          image: _buildImage('introInput.PNG'),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 12),
            bodyFlex: 1,
            imageFlex: 2,
          ),
        ),
        PageViewModel(
          title: "Complete Interactive Activities",
          body:
          "Various interactive opportunities are available to help you gain a deeper understanding "
              "of the information being given.",
          image: _buildImage('introInteract.PNG'),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 12),
            bodyFlex: 1,
            imageFlex: 2,
          ),
        ),
        PageViewModel(
          title: "Build Your Score",
          body:
          "Earn points throughout to build your score. See how you compare to other users "
              "by clicking on the leaderboard.",
          image: _buildImage('introLeader.PNG'),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 12),
            bodyFlex: 1,
            imageFlex: 2,
          ),
        ),
        PageViewModel(
          title: "Have Fun",
          body:
          "The most important thing is to have fun while you play.",
          image: _buildImage('introFinal.PNG'),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 12),
            bodyFlex: 1,
            imageFlex: 2,
          ),
        ),
        // PageViewModel(
        //   title: "Full Screen Page",
        //   body:
        //   "Pages can be full screen as well.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
        //   image: _buildFullscreenImage(),
        //   decoration: pageDecoration.copyWith(
        //     contentMargin: const EdgeInsets.symmetric(horizontal: 16),
        //     fullScreen: true,
        //     bodyFlex: 2,
        //     imageFlex: 3,
        //   ),
        // ),
        // PageViewModel(
        //   title: "Another title page",
        //   body: "Another beautiful body text for this example onboarding",
        //   image: _buildImage('img2.jpg'),
        //   footer: ElevatedButton(
        //     onPressed: () {
        //       introKey.currentState?.animateScroll(0);
        //     },
        //     child: const Text(
        //       'FooButton',
        //       style: TextStyle(color: Colors.white),
        //     ),
        //     style: ElevatedButton.styleFrom(
        //       primary: Colors.lightBlue,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(8.0),
        //       ),
        //     ),
        //   ),
        //   decoration: pageDecoration,
        // ),
        // PageViewModel(
        //   title: "Title of last page - reversed",
        //   bodyWidget: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: const [
        //       Text("Click on ", style: bodyStyle),
        //       Icon(Icons.edit),
        //       Text(" to edit a post", style: bodyStyle),
        //     ],
        //   ),
        //   decoration: pageDecoration.copyWith(
        //     bodyFlex: 2,
        //     imageFlex: 4,
        //     bodyAlignment: Alignment.bottomCenter,
        //     imageAlignment: Alignment.topCenter,
        //   ),
        //   image: _buildImage('img1.jpg'),
        //   reverse: true,
        // ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(8),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.white,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: ShapeDecoration(
        color: buildMaterialColor(HexColor("#d47828")),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}


buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  };
  return MaterialColor(color.value, swatch);
}



// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Home')),
//       body: const Center(child: Text("This is the screen after Introduction")),
//     );
//   }
// }
