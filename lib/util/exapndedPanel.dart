import 'dart:math' as math;

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gasht/ui/controllers/langaugeCotroller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class Card1 extends StatelessWidget {
  String title;
  String body;

   Card1(this.title,this.body,{super.key});

  final TranslationController _translationController= Get.put(TranslationController());


  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right:10,top: 1),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[

                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header:  Padding(
                        padding: const EdgeInsets.all(10),
                        child:                     FutureBuilder(future: _translationController.getTransaltion(title),
                            builder: (context,snapshot){
                              if(snapshot.hasData)
                              {
                                return
                                  Text(
                                    snapshot.data!,

                                  );
                              }
                              else
                              {
                                return

                                  Text(
                                    title,

                                  );
                              }
                            }),

                    ),
                    collapsed:
                    FutureBuilder(future: _translationController.getTransaltion(body),
                        builder: (context,snapshot){
                          if(snapshot.hasData)
                          {
                            return
                              Text(
                                snapshot.data!,
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,

                              );
                          }
                          else
                          {
                            return

                              Text(
                                body,
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              );
                          }
                        }),



                    expanded:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // for (var _ in Iterable.generate(1))
                        Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child:
                            FutureBuilder(future: _translationController.getTransaltion(body),
                                builder: (context,snapshot){
                                  if(snapshot.hasData)
                                  {
                                    return
                                      Text(
                                        snapshot.data!,

                                      );
                                  }
                                  else
                                  {
                                    return

                                      Text(
                                        body,

                                      );
                                  }
                                }),

                        ),
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
