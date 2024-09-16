import 'package:erp_copy/controllers/item_groups_controller.dart/create_item_groups_controller.dart';
import 'package:flutter/material.dart';

Future<void> showCreateItemGroupDialog(BuildContext context) async {
  TextEditingController itemGroupController = TextEditingController();
  TextEditingController prefixController = TextEditingController();
  TextEditingController suffixController = TextEditingController();
  String? itemType = 'Goods';
  final CreateItemGroupsController cigc = CreateItemGroupsController();

  final _formKey = GlobalKey<FormState>();

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap button to dismiss
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text('Create Item Group'),
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: ListBody(
                  children: <Widget>[
                    TextFormField(
                      controller: itemGroupController,
                      decoration: InputDecoration(
                        labelText: 'Item Group',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter item group';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: prefixController,
                      decoration: InputDecoration(
                        labelText: 'Prefix',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter prefix';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: suffixController,
                      decoration: InputDecoration(
                        labelText: 'Suffix',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter suffix';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text('Item Type'),
                    ListTile(
                      title: const Text('Goods'),
                      leading: Radio<String>(
                        value: 'Goods',
                        groupValue: itemType,
                        onChanged: (String? value) {
                          setState(() {
                            itemType = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Services'),
                      leading: Radio<String>(
                        value: 'Services',
                        groupValue: itemType,
                        onChanged: (String? value) {
                          setState(() {
                            itemType = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Add'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await cigc.createItemGroups(
                      itemGroupController.text,
                      itemType,
                      prefixController.text,
                      suffixController.text,
                    );
                    // Add your item group creation logic here
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        },
      );
    },
  );
}
