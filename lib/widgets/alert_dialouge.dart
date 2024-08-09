

import 'package:flutter/material.dart';
import 'package:project/provider/provider.dart';

class AlertClass extends StatefulWidget {
  final Task task;
  const AlertClass({super.key, required this.task});

  @override
  State<AlertClass> createState() => _AlertClassState();
}

class _AlertClassState extends State<AlertClass> {
  final TextEditingController _controller=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Text('Add  Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
        validator: (value) =>
        value!.isEmpty ? 'Title cannot be blank' : null,
              controller: _controller,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                focusedBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ) ,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:const BorderSide(color: Colors.red)
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.red)
                ),

                // border: InputBorder.none,
                hintText: "Enter title",
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final FormState? form = _formKey.currentState;
            if (form!.validate()) {
                widget.task.addItem(DateTime.now().toString(),_controller.text,false);
                Navigator.pop(context);
            }

          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
