import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget getDummyUserConnectionwidget(double width) {
  return Container(
    width: width,
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width - 32,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Suggested for you',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Gantari',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              const Spacer(),
              Container(
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'See more',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF965EFF),
                        fontSize: 16,
                        fontFamily: 'Gantari',
                        fontWeight: FontWeight.w600,
                        height: 0.08,
                      ),
                    ),
                    SizedBox(width: 6),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: width - 32,
          height: 237,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 24,
                  left: 12,
                  right: 12,
                  bottom: 16,
                ),
                decoration: ShapeDecoration(
                  color: const Color(0xFF242325),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF383739)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: const Stack(children: []),
                    ),
                    Container(
                      width: 86,
                      height: 86,
                      decoration: const ShapeDecoration(
                        image: DecorationImage(
                          image:
                              NetworkImage("https://via.placeholder.com/86x86"),
                          fit: BoxFit.fill,
                        ),
                        shape: OvalBorder(),
                      ),
                    ),
                    const SizedBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 124,
                            height: 19,
                            child: Text(
                              'Chandni Karelia',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Gantari',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                          SizedBox(
                            width: 131,
                            height: 34,
                            child: Text(
                              'Product designer at NovaHQ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xB2F1F1F1),
                                fontSize: 14,
                                fontFamily: 'Gantari',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 131,
                      height: 32,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF965EFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 13,
                            height: 13,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: Stack(
                              children: [
                                const Positioned(
                                  left: 3.25,
                                  top: 1.08,
                                  child: SizedBox(
                                    width: 8.82,
                                    height: 5.73,
                                    child: Stack(children: []),
                                  ),
                                ),
                                Positioned(
                                  left: 0.30,
                                  top: 6.50,
                                  child: Container(
                                    width: 10.21,
                                    height: 6.50,
                                    decoration: const ShapeDecoration(
                                      shape: OvalBorder(
                                        side: BorderSide(
                                            width: 1.18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            'Connect',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Gantari',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.only(
                  top: 24,
                  left: 12,
                  right: 12,
                  bottom: 16,
                ),
                decoration: ShapeDecoration(
                  color: const Color(0xFF242325),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF383739)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: const Stack(children: []),
                    ),
                    Container(
                      width: 86,
                      height: 86,
                      decoration: const ShapeDecoration(
                        image: DecorationImage(
                          image:
                              NetworkImage("https://via.placeholder.com/86x86"),
                          fit: BoxFit.fill,
                        ),
                        shape: OvalBorder(),
                      ),
                    ),
                    const SizedBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 124,
                            height: 19,
                            child: Text(
                              'Sakhshi Yadav',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Gantari',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                          SizedBox(
                            width: 131,
                            height: 34,
                            child: Text(
                              'Entrepreneur | Fintech startup ow..',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xB2F1F1F1),
                                fontSize: 14,
                                fontFamily: 'Gantari',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 131,
                      height: 32,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF965EFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 13,
                            height: 13,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: Stack(
                              children: [
                                const Positioned(
                                  left: 3.25,
                                  top: 1.08,
                                  child: SizedBox(
                                    width: 8.82,
                                    height: 5.73,
                                    child: Stack(children: []),
                                  ),
                                ),
                                Positioned(
                                  left: 0.30,
                                  top: 6.50,
                                  child: Container(
                                    width: 10.21,
                                    height: 6.50,
                                    decoration: const ShapeDecoration(
                                      shape: OvalBorder(
                                        side: BorderSide(
                                            width: 1.18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            'Connect',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Gantari',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.only(
                  top: 24,
                  left: 12,
                  right: 12,
                  bottom: 16,
                ),
                decoration: ShapeDecoration(
                  color: const Color(0xFF242325),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF383739)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: const Stack(children: []),
                    ),
                    Container(
                      width: 86,
                      height: 86,
                      decoration: const ShapeDecoration(
                        image: DecorationImage(
                          image:
                              NetworkImage("https://via.placeholder.com/86x86"),
                          fit: BoxFit.fill,
                        ),
                        shape: OvalBorder(),
                      ),
                    ),
                    const SizedBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 124,
                            height: 19,
                            child: Text(
                              'Chandni Karelia',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Gantari',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                          SizedBox(
                            width: 131,
                            height: 34,
                            child: Text(
                              'Product designer at NovaHQ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xB2F1F1F1),
                                fontSize: 14,
                                fontFamily: 'Gantari',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 131,
                      height: 32,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF965EFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 13,
                            height: 13,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: Stack(
                              children: [
                                const Positioned(
                                  left: 3.25,
                                  top: 1.08,
                                  child: SizedBox(
                                    width: 8.82,
                                    height: 5.73,
                                    child: Stack(children: []),
                                  ),
                                ),
                                Positioned(
                                  left: 0.30,
                                  top: 6.50,
                                  child: Container(
                                    width: 10.21,
                                    height: 6.50,
                                    decoration: const ShapeDecoration(
                                      shape: OvalBorder(
                                        side: BorderSide(
                                            width: 1.18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            'Connect',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Gantari',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 24,
                  left: 12,
                  right: 12,
                  bottom: 16,
                ),
                decoration: ShapeDecoration(
                  color: const Color(0xFF242325),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF383739)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: const Stack(children: []),
                    ),
                    Container(
                      width: 86,
                      height: 86,
                      decoration: const ShapeDecoration(
                        image: DecorationImage(
                          image:
                              NetworkImage("https://via.placeholder.com/86x86"),
                          fit: BoxFit.fill,
                        ),
                        shape: OvalBorder(),
                      ),
                    ),
                    Container(
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 124,
                            height: 19,
                            child: Text(
                              'Chandni Karelia',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Gantari',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                          SizedBox(
                            width: 131,
                            height: 34,
                            child: Text(
                              'Product designer at NovaHQ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xB2F1F1F1),
                                fontSize: 14,
                                fontFamily: 'Gantari',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 131,
                      height: 32,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF965EFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 13,
                            height: 13,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: Stack(
                              children: [
                                const Positioned(
                                  left: 3.25,
                                  top: 1.08,
                                  child: SizedBox(
                                    width: 8.82,
                                    height: 5.73,
                                    child: Stack(children: []),
                                  ),
                                ),
                                Positioned(
                                  left: 0.30,
                                  top: 6.50,
                                  child: Container(
                                    width: 10.21,
                                    height: 6.50,
                                    decoration: const ShapeDecoration(
                                      shape: OvalBorder(
                                        side: BorderSide(
                                            width: 1.18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            'Connect',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Gantari',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.only(
                  top: 24,
                  left: 12,
                  right: 12,
                  bottom: 16,
                ),
                decoration: ShapeDecoration(
                  color: const Color(0xFF242325),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF383739)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: const Stack(children: []),
                    ),
                    Container(
                      width: 86,
                      height: 86,
                      decoration: const ShapeDecoration(
                        image: DecorationImage(
                          image:
                              NetworkImage("https://via.placeholder.com/86x86"),
                          fit: BoxFit.fill,
                        ),
                        shape: OvalBorder(),
                      ),
                    ),
                    Container(
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 124,
                            height: 19,
                            child: Text(
                              'Sakhshi Yadav',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Gantari',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                          SizedBox(
                            width: 131,
                            height: 34,
                            child: Text(
                              'Entrepreneur | Fintech startup ow..',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xB2F1F1F1),
                                fontSize: 14,
                                fontFamily: 'Gantari',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 131,
                      height: 32,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF965EFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 13,
                            height: 13,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: Stack(
                              children: [
                                const Positioned(
                                  left: 3.25,
                                  top: 1.08,
                                  child: SizedBox(
                                    width: 8.82,
                                    height: 5.73,
                                    child: Stack(children: []),
                                  ),
                                ),
                                Positioned(
                                  left: 0.30,
                                  top: 6.50,
                                  child: Container(
                                    width: 10.21,
                                    height: 6.50,
                                    decoration: const ShapeDecoration(
                                      shape: OvalBorder(
                                        side: BorderSide(
                                            width: 1.18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            'Connect',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Gantari',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.only(
                  top: 24,
                  left: 12,
                  right: 12,
                  bottom: 16,
                ),
                decoration: ShapeDecoration(
                  color: const Color(0xFF242325),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF383739)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: const Stack(children: []),
                    ),
                    Container(
                      width: 86,
                      height: 86,
                      decoration: const ShapeDecoration(
                        image: DecorationImage(
                          image:
                              NetworkImage("https://via.placeholder.com/86x86"),
                          fit: BoxFit.fill,
                        ),
                        shape: OvalBorder(),
                      ),
                    ),
                    Container(
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 124,
                            height: 19,
                            child: Text(
                              'Chandni Karelia',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Gantari',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                          SizedBox(
                            width: 131,
                            height: 34,
                            child: Text(
                              'Product designer at NovaHQ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xB2F1F1F1),
                                fontSize: 14,
                                fontFamily: 'Gantari',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 131,
                      height: 32,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF965EFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 13,
                            height: 13,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: Stack(
                              children: [
                                const Positioned(
                                  left: 3.25,
                                  top: 1.08,
                                  child: SizedBox(
                                    width: 8.82,
                                    height: 5.73,
                                    child: Stack(children: []),
                                  ),
                                ),
                                Positioned(
                                  left: 0.30,
                                  top: 6.50,
                                  child: Container(
                                    width: 10.21,
                                    height: 6.50,
                                    decoration: const ShapeDecoration(
                                      shape: OvalBorder(
                                        side: BorderSide(
                                            width: 1.18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            'Connect',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Gantari',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 24,
                  left: 12,
                  right: 12,
                  bottom: 16,
                ),
                decoration: ShapeDecoration(
                  color: const Color(0xFF242325),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF383739)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: const Stack(children: []),
                    ),
                    Container(
                      width: 86,
                      height: 86,
                      decoration: const ShapeDecoration(
                        image: DecorationImage(
                          image:
                              NetworkImage("https://via.placeholder.com/86x86"),
                          fit: BoxFit.fill,
                        ),
                        shape: OvalBorder(),
                      ),
                    ),
                    Container(
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 124,
                            height: 19,
                            child: Text(
                              'Chandni Karelia',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Gantari',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                          SizedBox(
                            width: 131,
                            height: 34,
                            child: Text(
                              'Product designer at NovaHQ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xB2F1F1F1),
                                fontSize: 14,
                                fontFamily: 'Gantari',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 131,
                      height: 32,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF965EFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 13,
                            height: 13,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: Stack(
                              children: [
                                const Positioned(
                                  left: 3.25,
                                  top: 1.08,
                                  child: SizedBox(
                                    width: 8.82,
                                    height: 5.73,
                                    child: Stack(children: []),
                                  ),
                                ),
                                Positioned(
                                  left: 0.30,
                                  top: 6.50,
                                  child: Container(
                                    width: 10.21,
                                    height: 6.50,
                                    decoration: const ShapeDecoration(
                                      shape: OvalBorder(
                                        side: BorderSide(
                                            width: 1.18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            'Connect',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Gantari',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.only(
                  top: 24,
                  left: 12,
                  right: 12,
                  bottom: 16,
                ),
                decoration: ShapeDecoration(
                  color: const Color(0xFF242325),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF383739)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: const Stack(children: []),
                    ),
                    Container(
                      width: 86,
                      height: 86,
                      decoration: const ShapeDecoration(
                        image: DecorationImage(
                          image:
                              NetworkImage("https://via.placeholder.com/86x86"),
                          fit: BoxFit.fill,
                        ),
                        shape: OvalBorder(),
                      ),
                    ),
                    Container(
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 124,
                            height: 19,
                            child: Text(
                              'Sakhshi Yadav',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Gantari',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                          SizedBox(
                            width: 131,
                            height: 34,
                            child: Text(
                              'Entrepreneur | Fintech startup ow..',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xB2F1F1F1),
                                fontSize: 14,
                                fontFamily: 'Gantari',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 131,
                      height: 32,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF965EFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 13,
                            height: 13,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: Stack(
                              children: [
                                const Positioned(
                                  left: 3.25,
                                  top: 1.08,
                                  child: SizedBox(
                                    width: 8.82,
                                    height: 5.73,
                                    child: Stack(children: []),
                                  ),
                                ),
                                Positioned(
                                  left: 0.30,
                                  top: 6.50,
                                  child: Container(
                                    width: 10.21,
                                    height: 6.50,
                                    decoration: const ShapeDecoration(
                                      shape: OvalBorder(
                                        side: BorderSide(
                                            width: 1.18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            'Connect',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Gantari',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.only(
                  top: 24,
                  left: 12,
                  right: 12,
                  bottom: 16,
                ),
                decoration: ShapeDecoration(
                  color: const Color(0xFF242325),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF383739)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: const Stack(children: []),
                    ),
                    Container(
                      width: 86,
                      height: 86,
                      decoration: const ShapeDecoration(
                        image: DecorationImage(
                          image:
                              NetworkImage("https://via.placeholder.com/86x86"),
                          fit: BoxFit.fill,
                        ),
                        shape: OvalBorder(),
                      ),
                    ),
                    Container(
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 124,
                            height: 19,
                            child: Text(
                              'Chandni Karelia',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Gantari',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                          SizedBox(
                            width: 131,
                            height: 34,
                            child: Text(
                              'Product designer at NovaHQ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xB2F1F1F1),
                                fontSize: 14,
                                fontFamily: 'Gantari',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 131,
                      height: 32,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF965EFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 13,
                            height: 13,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: Stack(
                              children: [
                                const Positioned(
                                  left: 3.25,
                                  top: 1.08,
                                  child: SizedBox(
                                    width: 8.82,
                                    height: 5.73,
                                    child: Stack(children: []),
                                  ),
                                ),
                                Positioned(
                                  left: 0.30,
                                  top: 6.50,
                                  child: Container(
                                    width: 10.21,
                                    height: 6.50,
                                    decoration: const ShapeDecoration(
                                      shape: OvalBorder(
                                        side: BorderSide(
                                            width: 1.18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            'Connect',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Gantari',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
