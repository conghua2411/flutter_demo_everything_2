import 'package:flutter/material.dart';

class NeumorphismDemo extends StatefulWidget {
  const NeumorphismDemo({Key? key}) : super(key: key);

  @override
  State<NeumorphismDemo> createState() => _NeumorphismDemoState();
}

class _NeumorphismDemoState extends State<NeumorphismDemo> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Neumorphism'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _firstButton(),
              SizedBox(
                height: 24,
              ),
              _secondButton(),
              SizedBox(
                height: 24,
              ),
              _thirdButton(),
              SizedBox(
                height: 24,
              ),
              Text('value: ${_value.toInt()}'),
              Slider(
                value: _value,
                min: -20,
                max: 20,
                onChanged: (value) {
                  setState(() {
                    _value = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _firstButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        print('hello');
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.grey,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFBEBEBE),
                offset: Offset(_value, _value),
                blurRadius: 20,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-_value, -_value),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ]),
        child: Center(
          child: Text(
            'hello',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _secondButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        print('hello 2');
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              colors: [
                Colors.grey,
                Colors.white,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFBEBEBE),
                offset: Offset(_value, _value),
                blurRadius: 20,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-_value, -_value),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ]),
        child: Center(
          child: Text(
            'hello',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _thirdButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        print('hello 2');
      },
      child: Container(
        height: 100,
        width: 100,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(24), boxShadow: [
          BoxShadow(
            color: Color(0xFFBEBEBE),
            offset: Offset(_value, _value),
            blurRadius: 10,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-_value, -_value),
            blurRadius: 10,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Color(0xFFBEBEBE),
            offset: Offset(0, 0),
            blurRadius: 0,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.white,
            blurRadius: 10,
            spreadRadius: -10,
          ),
        ]),
        child: Center(
          child: Text(
            'hello',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
