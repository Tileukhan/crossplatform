import 'package:finalversion/models/package.dart';
import 'package:finalversion/models/package2.dart';
import 'package:finalversion/utils/layouts.dart';
import 'package:finalversion/utils/styles.dart';
import 'package:finalversion/widgets/back_button.dart';
import 'package:finalversion/widgets/package_card2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  List helpingList = [
    {
      'email': 'help_pets1@gmail.com',
      'number': 777777,
      'address': 'Astana, Kabanbay batyra 60',
    },
    {
      'email': 'help_pets2@gmail.com',
      'number': 777777,
      'address': 'Moscow, Pushkin 99',
    },
    {
      'email': 'help_pets3@gmail.com',
      'number': 887777,
      'address': 'Boston, Generals 14',
    },
  ];
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final List<Package2> _packages2 = [];


  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      for (var i = 0; i < helpingList.length; i++) {
        setState(() {
          listKey.currentState!
              .insertItem(0, duration: Duration(milliseconds: 500 - i * 200));
          _packages2.add(Package2.fromJson(helpingList[i]));
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);

    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 500),
                    builder: (context, value, _) {
                      return Stack(
                        children: [
                          Container(
                            width: value * size.width,
                            height: value * size.width,
                            decoration: BoxDecoration(
                                color: Styles.bgColor,
                                borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(value * size.width / 2),
                                  bottomRight:
                                      Radius.circular(value * size.width / 2),
                                )),
                            child: Column(
                              children: [
                                Gap(value * 50),
                                AnimatedSize(
                                  curve: Curves.bounceInOut,
                                  duration: const Duration(seconds: 1),
                                  child: SvgPicture.asset(
                                    'assets/svg/help.svg',
                                    height: value * 200,
                                  ),
                                ),
                                Gap(value * 20),
                                Text(
                                  'Help Desk',
                                  style: TextStyle(
                                      fontSize: value * 30, height: 3),
                                ),
                                const Spacer()
                              ],
                            ),
                          ),
                          const Positioned(
                              left: 15, top: 50, child: PetBackButton()),
                          Positioned(
                              left: size.width * 0.3,
                              right: size.width * 0.3,
                              bottom: 40,
                              child: AnimatedScale(
                                scale: value,
                                curve: Curves.bounceInOut,
                                duration: const Duration(milliseconds: 400),
                              
                              ))
                        ],
                      );
                    }),
              ],
            ),
        const Gap(30),
            TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 500),
                builder: (context, value, _) {
                  return Text(
                    'Contact us',
                    style: TextStyle(
                        color: Styles.blackColor,
                        fontSize: value * 25,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  );
                }),
            const Gap(30),
            AnimatedList(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                initialItemCount: _packages2.length,
                key: listKey,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index, animation) {
                  final package = _packages2[index];
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(-0.5, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: ContactCard(package),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
