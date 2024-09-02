// 1
import 'package:flutter/material.dart';
import 'package:sqlite_section2/helpers/file_helper.dart';

class FilePages extends StatefulWidget {
  const FilePages({super.key});

  @override
  State<FilePages> createState() => _FilePagesState();
}

class _FilePagesState extends State<FilePages> {
  int _counter = 0;

  FileHelper _fileHelper = FileHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fileHelper.readCounter().then((value) {
      setState(() {
        _counter = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar,
      body: _buildBody,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter++;
          });
          _fileHelper.writeCounter(_counter);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  AppBar get _buildAppBar {
    return AppBar(
      backgroundColor: Colors.blue,
      title: const Text(
        'File',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    );
  }

  Widget get _buildBody {
    return Container(
      alignment: Alignment.center,
      color: Colors.grey[200],
      child: Text('Counter: $_counter'),
    );
  }
}
