import 'package:flutter/material.dart';

class EnterNamePage extends StatelessWidget {
  const EnterNamePage({super.key});

  void onSubmit(){
    return;
  }

  @override
  Widget build(BuildContext context) {
    
      return Scaffold(
        appBar: AppBar(
          title: Text('HealMe Dairy', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Title(
                color: Colors.white,
                child: Text('How should I call you?',style:TextStyle(fontSize: 24) ,),
              ),
              SizedBox(height: 30,),
              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter your name',
                  border: OutlineInputBorder(),
                ),
              ),),
              SizedBox(height: 10),
              Padding(padding:EdgeInsets.all(10)),
              ElevatedButton(onPressed: onSubmit ,style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              ), child:Text('Enter',style: TextStyle(color: Colors.white,fontSize: 20),), )
            ],
          ),
        ),
      );

  }
}
