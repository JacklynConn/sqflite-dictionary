// 4
import 'package:flutter/material.dart';
import 'package:sqlite_section2/helpers/word_helper.dart';
import 'package:sqlite_section2/models/word_model.dart';
import 'package:sqlite_section2/utils/message_util.dart';
import 'package:sqlite_section2/utils/uniquekey_util.dart';

class InsertPage extends StatefulWidget {
  const InsertPage({super.key});

  @override
  State<InsertPage> createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
  final WordHelper _wordHelper = WordHelper();

  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _wordHelper.openDB().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _wordHelper.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildBody,
    );
  }

  AppBar get _buildAppBar {
    return AppBar(
      backgroundColor: Colors.blue,
      title: const Text(
        'Insert New Word',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget get _buildBody {
    return Container(
      alignment: Alignment.center,
      color: Colors.grey[200],
      padding: const EdgeInsets.all(20),
      child: _buildPanel,
    );
  }

  final TextEditingController _englishCtrl = TextEditingController();
  final TextEditingController _khmerCtrl = TextEditingController();

  Widget get _buildPanel {
    return Column(
      children: [
        TextField(
          controller: _englishCtrl,
          decoration: const InputDecoration(
            hintText: "Enter English Word",
          ),
        ),
        TextField(
          controller: _khmerCtrl,
          decoration: const InputDecoration(
            hintText: "Enter Khmer Word",
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () {
            WordModel wordModel = WordModel(
              id: uniquKey(),
              english: _englishCtrl.text.trim(),
              khmer: _khmerCtrl.text.trim(),
            );

            _wordHelper.insert(wordModel).then((value) {
              showSnackBar(context, "Insert Successfully");
            });
          },
          icon: const Icon(Icons.add),
          label: const Text('Insert'),
        ),
      ],
    );
  }
}
