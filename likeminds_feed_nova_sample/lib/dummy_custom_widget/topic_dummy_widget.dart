import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget getTopicDummyWidet(double width) {
  return Container(
    width: width,
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Topics you might like',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Gantari',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          clipBehavior: Clip.hardEdge,
          width: width - 32,
          height: 118,
          decoration: const BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                width: width - 32,
                height: 30,
                decoration: const BoxDecoration(),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: 119,
                      padding: const EdgeInsets.only(
                          top: 8, left: 12, right: 16, bottom: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF965EFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(83),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: const Stack(children: []),
                          ),
                          const Text(
                            'Entrepreneur ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Gantari',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 92,
                      padding: const EdgeInsets.only(
                          top: 8, left: 12, right: 16, bottom: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF2A2A2B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(83),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: const Stack(children: []),
                          ),
                          const Text(
                            'Founder',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0x7FF1F1F1),
                              fontSize: 12,
                              fontFamily: 'Gantari',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 95,
                      padding: const EdgeInsets.only(
                          top: 8, left: 12, right: 16, bottom: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF2A2A2B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(83),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: const Stack(children: []),
                          ),
                          const Text(
                            'ChatGPT',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0x7FF1F1F1),
                              fontSize: 12,
                              fontFamily: 'Gantari',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 95,
                      padding: const EdgeInsets.only(
                          top: 8, left: 12, right: 16, bottom: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF2A2A2B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(83),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: const Stack(children: []),
                          ),
                          const Text(
                            'ChatGPT',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0x7FF1F1F1),
                              fontSize: 12,
                              fontFamily: 'Gantari',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: width - 32,
                height: 30,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: 85,
                      padding: const EdgeInsets.only(
                          top: 8, left: 12, right: 16, bottom: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF2A2A2B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(83),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: const Stack(children: []),
                          ),
                          const Text(
                            'Movies',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0x7FF1F1F1),
                              fontSize: 12,
                              fontFamily: 'Gantari',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 121,
                      padding: const EdgeInsets.only(
                          top: 8, left: 12, right: 16, bottom: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF2A2A2B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(83),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: const Stack(children: []),
                          ),
                          const Text(
                            'UI/UX Design',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0x7FF1F1F1),
                              fontSize: 12,
                              fontFamily: 'Gantari',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 88,
                      padding: const EdgeInsets.only(
                          top: 8, left: 12, right: 16, bottom: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF2A2A2B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(83),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: const Stack(children: []),
                          ),
                          const Text(
                            'AI Tools',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0x7FF1F1F1),
                              fontSize: 12,
                              fontFamily: 'Gantari',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 74,
                      padding: const EdgeInsets.only(
                          top: 8, left: 12, right: 16, bottom: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF2A2A2B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(83),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: const Stack(children: []),
                          ),
                          const Text(
                            'GenZ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0x7FF1F1F1),
                              fontSize: 12,
                              fontFamily: 'Gantari',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 92,
                      padding: const EdgeInsets.only(
                          top: 8, left: 12, right: 16, bottom: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF2A2A2B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(83),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: const Stack(children: []),
                          ),
                          const Text(
                            'Founder',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0x7FF1F1F1),
                              fontSize: 12,
                              fontFamily: 'Gantari',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: width - 32,
                height: 30,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: 79,
                      padding: const EdgeInsets.only(
                          top: 8, left: 12, right: 16, bottom: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF2A2A2B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(83),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: const Stack(children: []),
                          ),
                          const Text(
                            'Coder',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0x7FF1F1F1),
                              fontSize: 12,
                              fontFamily: 'Gantari',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 91,
                      padding: const EdgeInsets.only(
                          top: 8, left: 12, right: 16, bottom: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF2A2A2B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(83),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: const Stack(children: []),
                          ),
                          const Text(
                            'Hip Hop',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0x7FF1F1F1),
                              fontSize: 12,
                              fontFamily: 'Gantari',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 85,
                      padding: const EdgeInsets.only(
                          top: 8, left: 12, right: 16, bottom: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF2A2A2B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(83),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: const Stack(children: []),
                          ),
                          const Text(
                            'Movies',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0x7FF1F1F1),
                              fontSize: 12,
                              fontFamily: 'Gantari',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 92,
                      padding: const EdgeInsets.only(
                          top: 8, left: 12, right: 16, bottom: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF2A2A2B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(83),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: const Stack(children: []),
                          ),
                          const Text(
                            'Founder',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0x7FF1F1F1),
                              fontSize: 12,
                              fontFamily: 'Gantari',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.25,
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
