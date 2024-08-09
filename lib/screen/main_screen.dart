import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/provider/provider.dart';
import 'package:provider/provider.dart';

import '../database/new_database_helper.dart';
import '../widgets/alert_dialouge.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // DatabaseHelper databaseHelper = DatabaseHelper.;

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<Task>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Management"),
        elevation: 2,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // counter.addItem();,
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertClass(
              task:task
            ),
          );
        },

        child: const Icon(Icons.add),
      ),
      body:
      task.taskItem.isEmpty?
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const Text(
                  "add your tirst task",
                  // "This is my first task",
                  style: TextStyle(color: Colors.grey,fontSize: 18),),
             const   SizedBox(height: 15,),
                Card(
                  child: GestureDetector(
                      onTap: (){
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertClass(
                              task:task
                          ),
                        );
                      },
                      child:const Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: Text("Add Task",style: TextStyle(
                          fontSize: 18
                        ),),
                      )),
                )
              ],
            ),
          )
          :

      Consumer<Task>(
          builder: (context, task, child)  {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
            child: ListView.builder(
              itemCount: task.taskItem.length,
                // shrinkWrap: true,
                itemBuilder: (BuildContext context,int index){
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 15, 15),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                      value: task.taskItem[index].isCompleted,

                                      onChanged: (val){
                                    task.updateItem(task.taskItem[index].id!, val!);
                                  }),
                                  Text(
                                    "${task.taskItem[index].title}",
                                    // "This is my first task",
                                    style: TextStyle(fontSize: 16),)
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  children: [
                                    Text(
                                      task.taskItem[index].isCompleted!?
                                      "completed":
                                      "Incomplete",
                                      style:const TextStyle(fontSize: 12),),
                                    const   SizedBox(width: 10,),
                                    SizedBox(
                                      width: 100,
                                      child: LinearProgressIndicator(
                                        backgroundColor: Colors.grey,
                                        borderRadius: BorderRadius.circular(5),
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          task.taskItem[index].isCompleted!?
                                          Colors.green:
                                              Colors.grey

                                        ),
                                        value: 1,
                                      ),
                                    ),
                                  ],

                                ),
                              ),

                            ],
                          ),
                          const  Spacer(),
                          GestureDetector(
                              onTap: (){
                                task.removeItem(index);
                              },
                              child:const Icon(Icons.delete_outline,size: 25,color: Colors.grey,))

                        ],
                      ),
                    ),
                  );
                }

            ),
          );
        }
      ),
    );
  }
}
