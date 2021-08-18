import 'package:flight_survey/ProfileUpdation.dart';
import 'package:flight_survey/Registration.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Showcase.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
    home: FlightsStepper(),
  ));
}

class FlightsStepper extends StatefulWidget {
  @override
  _FlightsStepperState createState() => _FlightsStepperState();
}

class _FlightsStepperState extends State<FlightsStepper> {
  int pageNumber = 1;

  @override
  Widget build(BuildContext context) {
    Widget page = pageNumber == 1
        ? Page(
            key: Key('page1'),
            onOptionSelected: () => setState(() => pageNumber = 2),
            question: 'Registration',
            answers: <String>['Next'],
            number: 1,
          )
        : pageNumber == 2
            ? Page(
                onOptionSelected: () => setState(() => pageNumber = 3),
                question: 'Profile Updation',
                answers: <String>[
                  'Next',
                ],
                number: 2,
              )
            : pageNumber == 3
                ? Page(
                    key: Key('page3'),
                    onOptionSelected: () => setState(() => pageNumber = 4),
                    question: 'Information',
                    answers: <String>[
                      'Show Data',
                    ],
                    number: 3,
                  )
                : pageNumber == 4
                    ? Page(
                        key: Key('page4'),
                        onOptionSelected: () => setState(() => pageNumber = 1),
                        question: 'ShowCase',
                        answers: <String>[
                          'Register',
                        ],
                        number: 4,
                      )
                    : null;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: backgroundDecoration,
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              // ArrowIcons(),
              Plane(),
              Line(),
              Positioned.fill(
                left: 32.0 + 8,
                child: AnimatedSwitcher(
                  child: page,
                  duration: Duration(milliseconds: 250),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Line extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 32.0 + 32 + 8,
      top: 40,
      bottom: 0,
      width: 1,
      child: Container(color: Colors.white.withOpacity(0.5)),
    );
  }
}

class Page extends StatefulWidget {
  final int number;
  final String question;
  final List<String> answers;
  final VoidCallback onOptionSelected;

  Page(
      {Key key,
      @required this.onOptionSelected,
      @required this.number,
      @required this.question,
      @required this.answers})
      : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> with SingleTickerProviderStateMixin {
  List<GlobalKey<_ItemFaderState>> keys;
  int selectedOptionKeyIndex;
  AnimationController _animationController;
  TextEditingController locationController =
      new TextEditingController(text: '');
  TextEditingController informationController =
      new TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    keys = List.generate(
      4 + widget.answers.length,
      (_) => GlobalKey<_ItemFaderState>(),
    );
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    onInit();
  }

  Future<void> animateDot(Offset startOffset) async {
    OverlayEntry entry = OverlayEntry(
      builder: (context) {
        double minTop = MediaQuery.of(context).padding.top + 52;
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Positioned(
              left: 26.0 + 32 + 8,
              top: minTop +
                  (startOffset.dy - minTop) * (1 - _animationController.value),
              child: child,
            );
          },
          child: Dot(),
        );
      },
    );
    Overlay.of(context).insert(entry);
    await _animationController.forward(from: 0);
    entry.remove();
  }

  @override
  Widget build(BuildContext context) {
    // print('pageee = ${widget.number}');
    return widget.number == 1
        ? registrationScreen(context)
        : widget.number == 2
            ? profileUpdationScreen(context)
            : widget.number == 3
                ? informationScreen(context)
                : widget.number == 4
                    ? showcase(context)
                    : Container();
  }

  registrationScreen(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 32),
              ItemFader(key: keys[0], child: StepNumber(number: widget.number)),
              ItemFader(
                key: keys[1],
                child: StepQuestion(question: widget.question),
              ),
              SizedBox(
                height: 50,
              ),
              Spacer(),
              ...widget.answers.map((String answer) {
                int answerIndex = widget.answers.indexOf(answer);
                int keyIndex = answerIndex;
                return Column(
                  children: [
                    ItemFader(
                      key: keys[2],
                      child: Registration(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ItemFader(
                      key: keys[3],
                      child: OptionItem(
                        name: answer,
                        onTap: (offset) => onTap(keyIndex, offset),
                        showDot: selectedOptionKeyIndex != keyIndex,
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(height: 64),
            ]),
          )
        ],
      ),
    );
  }

  showcase(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 32),
        ItemFader(key: keys[0], child: StepNumber(number: widget.number)),
        ItemFader(
          key: keys[1],
          child: StepQuestion(question: widget.question),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        ...widget.answers.map((String answer) {
          int answerIndex = widget.answers.indexOf(answer);
          int keyIndex = answerIndex;
          return Column(
            children: [
              ItemFader(
                key: keys[2],
                child: Showcase(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              ItemFader(
                key: keys[3],
                child: OptionItem(
                  name: answer,
                  onTap: (offset) => onTap(keyIndex, offset),
                  showDot: selectedOptionKeyIndex != keyIndex,
                ),
              ),
            ],
          );
        }),
        SizedBox(height: 64),
      ],
    );
  }

  profileUpdationScreen(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ItemFader(key: keys[0], child: StepNumber(number: widget.number)),
          ItemFader(
            key: keys[1],
            child: StepQuestion(question: widget.question),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          ...widget.answers.map((String answer) {
            int answerIndex = widget.answers.indexOf(answer);
            int keyIndex = answerIndex;
            return Column(
              children: [
                ItemFader(
                  key: keys[2],
                  child: ProfileUpdation(),
                ),
                SizedBox(
                  height: 25,
                ),
                ItemFader(
                    key: keys[3],
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: TextFormField(
                            onChanged: (value) async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              setState(() {
                                prefs.setString('location', value);
                              });
                            },
                            enabled: true,
                            controller: locationController,
                            autofocus: false,
                            decoration: new InputDecoration(
                              hintText: 'Location',
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              hintStyle: TextStyle(
                                  color: Colors.white54,
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w700),
                              fillColor: Colors.white54,
                              border: OutlineInputBorder(
                                gapPadding: 5,
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    color: Color(0xffffffff), width: 3),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    color: Color(0xffF4ADB3), width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    color: Color(0xffffffff), width: 3),
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.17,
                ),
                ItemFader(
                  key: keys[4],
                  child: OptionItem(
                    name: answer,
                    onTap: (offset) => onTap(keyIndex, offset),
                    showDot: selectedOptionKeyIndex != keyIndex,
                  ),
                ),
              ],
            );
          }),
          SizedBox(height: 64),
        ],
      ),
    );
  }

  informationScreen(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverList(
          delegate: SliverChildListDelegate(
        [
          SizedBox(height: 32),
          ItemFader(key: keys[0], child: StepNumber(number: widget.number)),
          ItemFader(
            key: keys[1],
            child: StepQuestion(question: widget.question),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          ...widget.answers.map((String answer) {
            int answerIndex = widget.answers.indexOf(answer);
            int keyIndex = answerIndex;
            return Column(
              children: [
                ItemFader(
                    key: keys[2],
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                onChanged: (value) async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  setState(() {
                                    prefs.setString('information', value);
                                  });
                                },
                                maxLines: 6,
                                enabled: true,
                                controller: informationController,
                                autofocus: false,
                                decoration: new InputDecoration(
                                  hintText: 'Information',
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  hintStyle: TextStyle(
                                      color: Colors.white54,
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w700),
                                  fillColor: Colors.white54,
                                  border: OutlineInputBorder(
                                    gapPadding: 5,
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        color: Color(0xffffffff), width: 3),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        color: Color(0xffF4ADB3), width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        color: Color(0xffffffff), width: 3),
                                  ),
                                ),
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                ItemFader(
                  key: keys[3],
                  child: OptionItem(
                    name: answer,
                    onTap: (offset) => onTap(keyIndex, offset),
                    showDot: selectedOptionKeyIndex != keyIndex,
                  ),
                ),
              ],
            );
          }),
          SizedBox(height: 64),
        ],
      ))
    ]);
  }

  void onTap(int keyIndex, Offset offset) async {
    for (GlobalKey<_ItemFaderState> key in keys) {
      await Future.delayed(Duration(milliseconds: 40));
      key.currentState.hide();
      if (keys.indexOf(key) == keyIndex) {
        setState(() => selectedOptionKeyIndex = keyIndex);
        animateDot(offset).then((_) => widget.onOptionSelected());
      }
    }
  }

  void onInit() async {
    for (GlobalKey<_ItemFaderState> key in keys) {
      await Future.delayed(Duration(milliseconds: 40));
      key.currentState.show();
    }
  }
}

class StepNumber extends StatelessWidget {
  final int number;

  const StepNumber({Key key, @required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 64, right: 16),
      child: Text(
        '0$number',
        style: TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.bold,
          color: Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }
}

class StepQuestion extends StatelessWidget {
  final String question;

  const StepQuestion({Key key, @required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 64, right: 16),
      child: Text(
        question,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class OptionItem extends StatefulWidget {
  final String name;
  final void Function(Offset dotOffset) onTap;
  final bool showDot;

  const OptionItem(
      {Key key, @required this.name, @required this.onTap, this.showDot = true})
      : super(key: key);

  @override
  _OptionItemState createState() => _OptionItemState();
}

class _OptionItemState extends State<OptionItem> {
  @override
  Widget build(BuildContext context) {
    // print('name -> ${widget.name}');
    // print('onTap -> ${widget.onTap}');
    // print('showDot -> ${widget.showDot}');
    return InkWell(
      onTap: () {
        RenderBox object = context.findRenderObject();
        Offset globalPosition = object.localToGlobal(Offset.zero);
        widget.onTap(globalPosition);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: <Widget>[
            SizedBox(width: 26),
            Dot(visible: widget.showDot),
            SizedBox(width: 26),
            Text(
              widget.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            )
          ],
        ),
      ),
    );
  }
}

class ItemFader extends StatefulWidget {
  final Widget child;

  const ItemFader({Key key, @required this.child}) : super(key: key);

  @override
  _ItemFaderState createState() => _ItemFaderState();
}

class _ItemFaderState extends State<ItemFader>
    with SingleTickerProviderStateMixin {
  //1 means its below, -1 means its above
  int position = 1;
  AnimationController _animationController;
  Animation _animation;

  void show() {
    setState(() => position = 1);
    _animationController.forward();
  }

  void hide() {
    setState(() => position = -1);
    _animationController.reverse();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 64 * position * (1 - _animation.value)),
          child: Opacity(
            opacity: _animation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

class Dot extends StatelessWidget {
  final bool visible;

  const Dot({Key key, this.visible = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: visible ? Colors.white : Colors.transparent,
      ),
    );
  }
}

class ArrowIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 8,
      bottom: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_upward),
            onPressed: () {},
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              color: Color.fromRGBO(120, 58, 183, 1),
              icon: Icon(Icons.arrow_downward),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class Plane extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 32.0 + 8,
      top: 32,
      child: RotatedBox(
        quarterTurns: 2,
        child: Icon(
          Icons.airplanemode_active,
          size: 64,
        ),
      ),
    );
  }
}

const backgroundDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Color.fromRGBO(76, 61, 243, 1),
      Color.fromRGBO(120, 58, 183, 1),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
);
