import 'package:finalversion/models/package.dart';
import 'package:finalversion/utils/layouts.dart';
import 'package:finalversion/utils/styles.dart';
import 'package:finalversion/widgets/back_button.dart';
import 'package:finalversion/widgets/package_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class GroomingPage2 extends StatefulWidget {
  const GroomingPage2({Key? key}) : super(key: key);

  @override
  State<GroomingPage2> createState() => _GroomingPage2State();
}

class _GroomingPage2State extends State<GroomingPage2> {
  List groomingList = [
    {
      'name': 'Spa Bath',
      'services': 7,
      'bonus': 160,
      'price': 960,
    },
    {
      'name': 'Bath + Basic Grooming',
      'services': 10,
      'bonus': 239,
      'price': 1438,
    },
    {
      'name': 'Full Service',
      'services': 12,
      'bonus': 299,
      'price': 1798,
    },
  ];
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final List _packages = [];

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      for (var i = 0; i < groomingList.length; i++) {
        setState(() {
          listKey.currentState!
              .insertItem(0, duration: Duration(milliseconds: 500 - i * 200));
          _packages.add(groomingList[i]);
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
                                    'assets/svg/person2.svg',
                                    height: value * 200,
                                  ),
                                ),
                                Gap(value * 20),
                                Text(
                                  'Select service',
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
                curve: Curves.easeInExpo,
                duration: const Duration(milliseconds: 500),
                builder: (context, value, _) {
                return Text(
                  'Cat Grooming Packages',
                  style: TextStyle(
                      color: Styles.blackColor,
                      fontSize: value*25,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                );
              }
            ),
            const Gap(30),
            MediaQuery.removeViewPadding(
              context: context,
              removeTop: true,
              child: AnimatedList(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  initialItemCount: _packages.length,
                  key: listKey,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (c, i, animation) {
                    final package = Package.fromJson(groomingList[i]);
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(-0.5, 0),
                        end: const Offset(0, 0),
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeIn,
                      )),
                      child: PackageCard(package),
                    );
                  }),
            ),
            
          ],
        ),
      ),
    );
  }
}
