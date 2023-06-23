import 'package:flutter/material.dart';
import '../model/todo_model.dart';

class HomeView extends StatefulWidget {
  final VoidCallback switchTheme;
  final bool isLight;

  const HomeView(this.switchTheme, this.isLight, {super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController titleTEController = TextEditingController();
  TextEditingController descriptionTEController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  List<Todo> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My To-Do',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: widget.switchTheme,
            icon: Visibility(
              visible: widget.isLight,
              replacement: const Icon(Icons.dark_mode),
              child: const Icon(Icons.sunny),
            )
          )
        ],
      ),
      body: todoList.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 100,
                    color: Theme.of(context).iconTheme.color!.withOpacity(0.5),
                  ),
                  const Text(
                    "No To-Do available\n Tap '+' to add new.",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 5,
                  child: ClipPath(
                    clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                                color: todoList[index].isDone
                                    ? Theme.of(context).listTileTheme.tileColor!
                                    : Theme.of(context)
                                        .listTileTheme
                                        .selectedTileColor!,
                                width: 10)),
                      ),
                      alignment: Alignment.centerLeft,
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        onTap: () => todoDetailsShowDialog(index),
                        onLongPress: () {
                          todoList[index].toggleDone();
                          setState(() {});
                        },
                        tileColor: todoList[index].isDone
                            ? Theme.of(context)
                                .listTileTheme
                                .tileColor
                                ?.withOpacity(0.33)
                            : Theme.of(context)
                                .listTileTheme
                                .selectedTileColor
                                ?.withOpacity(0.33),
                        title: Text(
                          todoList[index].title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          todoList[index].description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        leading: IconButton(
                          onPressed: () {
                            editTodoModalBottomSheet(index);
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            todoDeleteShowDialog(index);
                          },
                          icon: Icon(
                            Icons.delete_forever,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addTodoModalBottomSheet(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void todoDeleteShowDialog(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: const Text('Are you sure?'),
            content: Text("Deleting '${todoList[index].title}' todo!"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    todoList.removeAt(index);
                    Navigator.pop(context);
                    setState(() {});
                  },
                  style: Theme.of(context).textButtonTheme.style,
                  child: const Text('Okay'))
            ],
          );
        });
  }

  void todoDetailsShowDialog(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                    width: 3,
                    color: todoList[index].isDone
                        ? Theme.of(context).listTileTheme.tileColor!
                        : Theme.of(context).listTileTheme.selectedTileColor!)),
            title: Text(todoList[index].title),
            content: SingleChildScrollView(
                child: Text(
              todoList[index].description,
            )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Okay')),
            ],
          );
        });
  }

  void addTodoModalBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 18,
                right: 18,
                left: 18,
                top: 18),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Add new To-Do',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  customTextFormField(
                      textEditingController: titleTEController,
                      title: 'Title',
                      description: 'Title of Todo',
                      maxLines: 1,
                      maxLength: 50),
                  customTextFormField(
                      textEditingController: descriptionTEController,
                      title: 'Description',
                      description: 'Brief description',
                      minLines: 2,
                      maxLines: 5,
                      maxLength: 250),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          final isValidForm = formKey.currentState!.validate();

                          if (isValidForm) {
                            todoList.add(Todo(titleTEController.text.trim(),
                                descriptionTEController.text.trim(), false));
                            titleTEController.clear();
                            descriptionTEController.clear();
                            Navigator.pop(context);
                          }
                        });
                      },
                      style: Theme.of(context).elevatedButtonTheme.style,
                      child: const Text('Add todo'))
                ],
              ),
            ),
          );
        });
  }

  void editTodoModalBottomSheet(int index) {
    titleTEController.text = todoList[index].title;
    descriptionTEController.text = todoList[index].description;

    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 18,
                right: 18,
                left: 18,
                top: 18),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Edit To-Do',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  customTextFormField(
                      textEditingController: titleTEController,
                      title: 'Title',
                      description: 'Title of Todo',
                      maxLines: 1,
                      maxLength: 50),
                  customTextFormField(
                      textEditingController: descriptionTEController,
                      title: 'Description',
                      description: 'Brief description',
                      minLines: 2,
                      maxLines: 5,
                      maxLength: 250),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          final isValidForm = formKey.currentState!.validate();

                          if (isValidForm) {
                            todoList[index].title = titleTEController.text;
                            todoList[index].description =
                                descriptionTEController.text;
                            titleTEController.clear();
                            descriptionTEController.clear();
                            Navigator.pop(context);
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Done'))
                ],
              ),
            ),
          );
        });
  }

  Padding customTextFormField({
    required TextEditingController textEditingController,
    int? minLines,
    int? maxLines,
    int? maxLength,
    String title = 'default',
    String description = 'default',
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: textEditingController,
        minLines: minLines,
        maxLines: maxLines,
        maxLength: maxLength,
        decoration: textFieldInputDecoration(title, description),
        validator: validateTFField,
      ),
    );
  }

  InputDecoration textFieldInputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
  }

  String? validateTFField(value) {
    if (value!.trim().isEmpty) {
      return 'Field cannot be empty!';
    } else {
      return null;
    }
  }
}
