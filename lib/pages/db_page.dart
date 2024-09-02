// 3
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sqlite_section2/pages/update_page.dart';

import '../helpers/word_helper.dart';
import '../models/word_model.dart';
import 'insert_page.dart';

class DBPages extends StatefulWidget {
  const DBPages({super.key});

  @override
  State<DBPages> createState() => _DBPagesState();
}

class _DBPagesState extends State<DBPages> {
  final WordHelper _wordHelper = WordHelper();

  bool _isLoading = true;

  List<WordModel> _wordList = [];

  _initWord() async {
    await _wordHelper.openDB();
    _wordList = await _wordHelper.selectAll();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initWord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar,
      body: _buildBody,
    );
  }

  AppBar get _buildAppBar {
    return AppBar(
      backgroundColor: Colors.blue,
      title: const Text(
        'English - Khmer',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () async {
            _isLoading = true;
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const InsertPage(),
              ),
            );
            _wordList = await _wordHelper.selectAll();
            setState(() {
              _isLoading = false;
            });
          },
          icon: const Icon(Icons.add, color: Colors.white),
        ),
      ],
    );
  }

  Widget get _buildBody {
    return Container(
      alignment: Alignment.center,
      color: Colors.grey[200],
      child: _isLoading ? const CircularProgressIndicator() : _buildListView,
    );
  }

  Widget get _buildListView {
    _wordList.sort((a, b) => a.english.compareTo(b.english));
    return ListView.builder(
      itemCount: _wordList.length,
      itemBuilder: (context, index) {
        return _buildItem(_wordList[index]);
      },
    );
  }

  Widget _buildItem(WordModel item) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UpdatePage(
                    item: item,
                  ),
                ),
              );
              _wordList = await _wordHelper.selectAll();
              setState(() {});
            },
            label: 'Edit',
            icon: Icons.edit,
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          SlidableAction(
            onPressed: (context) async {
              await _wordHelper.delete(item.id);
              _wordList = await _wordHelper.selectAll();
              setState(() {});
            },
            label: 'Delete',
            backgroundColor: Colors.red,
            icon: Icons.delete,
          ),
        ],
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListTile(
          leading: const Icon(Icons.text_fields),
          title: Text(item.english),
          subtitle: Text(item.khmer),
          trailing: Text(
            item.id.toString(),
          ),
        ),
      ),
    );
  }
}
