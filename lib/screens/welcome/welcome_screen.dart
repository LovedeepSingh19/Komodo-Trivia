import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:komodo_trivia/api/api_fetch.dart';
import 'package:komodo_trivia/constants.dart';
import 'package:komodo_trivia/provider/dataProvider.dart';
import 'package:komodo_trivia/screens/quiz/quiz_screen.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

String selectedDifficulty = DifficultyList[0];
String selectedCategory = CategoryList[0];
String selectedType = TypesList[0];
bool buttonLoading = false;

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController nameInputController = TextEditingController();
  TextEditingController amountInputController = TextEditingController();
  @override
  void dispose() {
    nameInputController.dispose();
    amountInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<DataProvider>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 2), //2/6
                  Text(
                    "Let's Play Quiz,",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const Text("Enter your informations below"),
                  const Spacer(), // 1/6
                  TextField(
                    controller: nameInputController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF1C2341),
                      hintText: "User Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 80, right: 80, top: 10, bottom: 10),
                    child: TextField(
                      controller: amountInputController,
                      decoration: const InputDecoration(
                        // helperText: ,
                        filled: true,
                        fillColor: Color(0xFF1C2341),
                        hintText: "No. of questions",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DropdownButton<String>(
                        value: selectedDifficulty,
                        onChanged: (value) {
                          setState(() {
                            selectedDifficulty = value!;
                          });
                        },
                        items: DifficultyList.map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                      DropdownButton<String>(
                        value: selectedType,
                        onChanged: (value) {
                          setState(() {
                            selectedType = value!;
                          });
                        },
                        items: TypesList.map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  // SizedBox(
                  // width: 100,
                  // child:
                  DropdownButton<String>(
                    alignment: Alignment.center,
                    value: selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                    items: CategoryList.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                  ),
                  // ),
                  const Spacer(), // 1/6

                  InkWell(
                    onTap: () async => {
                      setState(() => buttonLoading = true),
                      if (amountInputController.text.isEmpty)
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No. of Questions empty'),
                              backgroundColor:
                                  Colors.red, // Customize the background color
                            ),
                          )
                        }
                      else
                        {
                          dataProvider.setAPIData(
                              amountInputController.text,
                              nameInputController.text.isNotEmpty
                                  ? nameInputController.text
                                  : null,
                              selectedType != 'Any Type' ? selectedType : null,
                              selectedDifficulty != 'Any Difficulty'
                                  ? selectedDifficulty
                                  : null,
                              selectedCategory != 'Any Category'
                                  ? '${CategoryList.indexOf(selectedCategory) + 8}'
                                  : null),
                          await runAPIFetchFunction(context),
                          setState(() => buttonLoading = false),
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuizScreen()))
                        },
                      setState(() => buttonLoading = false),
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding:
                          const EdgeInsets.all(kDefaultPadding * 0.75), // 15
                      decoration: const BoxDecoration(
                        gradient: kPrimaryGradient,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: buttonLoading == false
                          ? Text(
                              "Lets Start Quiz",
                              style: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .copyWith(color: Colors.black),
                            )
                          : CircularProgressIndicator(),
                    ),
                  ),
                  const Spacer(flex: 2), // it will take 2/6 spaces
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
