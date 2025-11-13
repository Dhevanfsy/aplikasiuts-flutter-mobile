import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  State<KalkulatorPage> createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  bool isDarkMode = true;
  String userInput = '';
  String result = '0';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  void _onButtonClick(String text) {
    setState(() {
      if (text == 'C') {
        userInput = '';
        result = '0';
      } else if (text == 'DEL') {
        if (userInput.isNotEmpty) {
          userInput = userInput.substring(0, userInput.length - 1);
        }
      } else if (text == '=') {
        _calculate();
      } else if (text == 'ANS') {
        userInput += result;
      } else {
        userInput += text;
      }
    });
  }

  void _calculate() {
    String finalInput = userInput.replaceAll('x', '*');
    Parser p = Parser();
    try {
      Expression exp = p.parse(finalInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      result = eval.toString();
    } catch (e) {
      result = 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isDarkMode ? const Color(0xFF121212) : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color buttonBg =
        isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200;
    final Color accentColor =
        isDarkMode ? Colors.deepPurpleAccent : Colors.blueAccent;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: accentColor,
        elevation: 4,
        centerTitle: true,
        title: const Text(
          'Kalkulator',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Switch(
            value: isDarkMode,
            activeColor: Colors.white,
            inactiveThumbColor: Colors.black,
            onChanged: (value) {
              setState(() {
                isDarkMode = value;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.only(right: 16, top: 40, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      userInput,
                      style: TextStyle(
                        color: textColor.withOpacity(0.7),
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      result,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 5,
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: buttons.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                        ),
                    itemBuilder: (context, index) {
                      final btn = buttons[index];
                      Color btnColor = buttonBg;
                      Color txtColor = textColor;

                      if (btn == 'C' || btn == 'DEL') {
                        btnColor =
                            isDarkMode
                                ? Colors.tealAccent.shade700
                                : Colors.tealAccent;
                        txtColor = Colors.black;
                      } else if (btn == '=' ||
                          btn == '/' ||
                          btn == 'x' ||
                          btn == '-' ||
                          btn == '+' ||
                          btn == '%') {
                        btnColor = accentColor;
                        txtColor = Colors.white;
                      }

                      return GestureDetector(
                        onTap: () => _onButtonClick(btn),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          decoration: BoxDecoration(
                            color: btnColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(2, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              btn,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: txtColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
