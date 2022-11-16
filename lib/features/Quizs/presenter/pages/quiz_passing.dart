import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nan_class/core/widgets/text_style_quizz.dart';
import 'package:nan_class/ui/colors/app_colors.dart';

class QuizPassing extends StatefulWidget {
  const QuizPassing({super.key});

  @override
  State<QuizPassing> createState() => _QuizPassingState();
}

class ListItemReponseQuizz<T> {
  bool isSelected = false; //Selection property to highlight or not
  T data; //Data of the user
  ListItemReponseQuizz(this.data); //Constructor to assign the data
}

class _QuizPassingState extends State<QuizPassing> {
  Color selectQuizzColor = const Color.fromARGB(214, 141, 142, 147);
  late List<ListItemReponseQuizz<String>> listReponseQuizz;
  @override
  void initState() {
    super.initState();
    populateData();
  }

  void populateData() {
    listReponseQuizz = [];
    for (int i = 0; i < 2; i++) {
      listReponseQuizz
          .add(ListItemReponseQuizz<String>("Un framework opensource $i"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: Container(
          color: AppColors.mainViolet,
          padding: const EdgeInsets.all(10),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 15, top: 10, right: 15, bottom: 10),
                      decoration: BoxDecoration(
                          color: AppColors.mainred.withOpacity(0.3),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: const Text(
                        "Valider Quiz",
                        style: TextStyle(
                          color: AppColors.mainred,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                //Rponse au quizz
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '2 / 10',
                      style: textStyleQuizz(),
                    ),
                    Text(
                      "reponse",
                      style: textStyleQuizz(),
                    ),
                  ],
                ),
                //Timer
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 15, top: 10, right: 15, bottom: 10),
                      decoration: const BoxDecoration(
                          color: AppColors.mainWhite,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: const Text(
                        "4 : 27",
                        style: TextStyle(
                          color: AppColors.darkBg,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height / 2.3,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(10),
          child: Card(
            color: AppColors.mainViolet,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "1. Qu'est ce que Flutter ?",
                    style: textStyleQuizz(),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: listReponseQuizz.length,
                    itemBuilder: getListItemResponse,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getListItemResponse(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        if (listReponseQuizz.any((item) => item.isSelected)) {
          setState(() {
            listReponseQuizz[index].isSelected =
                !listReponseQuizz[index].isSelected;
          });
        }
      },
      onLongPress: () {
        setState(() {
          listReponseQuizz[index].isSelected = true;
        });
      },
      child: Card(
        color: listReponseQuizz[index].isSelected
            ? const Color.fromARGB(213, 126, 224, 147)
            : const Color.fromARGB(214, 141, 142, 147),
        margin: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 10,
        ),
        child: ListTile(
          leading: const Icon(
            Icons.radio_button_off,
            color: AppColors.mainWhite,
          ),
          title: Text(
            listReponseQuizz[index].data,
            style: textStyleQuizz(),
          ),
        ),
      ),
    );
  }
}
