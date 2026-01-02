import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key,required this.tab});
  final String tab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Text('This is Home Page'),
          HomePageHeader()
        ],
      ),
    );
  }
}



class HomePageHeader extends StatelessWidget {
  const HomePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,//I use the full space
      padding: EdgeInsets.all(30),
      margin: EdgeInsets.all(15),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors:[
            Colors.blue,
            Colors.lightBlue
          ]
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ]
      ),
     
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/ronan.jpg'),

          ),
          SizedBox(width: 40,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("08 12 2025",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),),
              const SizedBox(width: 14),
              Text("Hello, Welcome!",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),),
            ],
          )

        ],
      ),
    );
  }
}