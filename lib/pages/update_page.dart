// 7
import 'package:flutter/material.dart';
import 'package:sqlite_section2/models/word_model.dart';

import '../helpers/word_helper.dart';
import '../utils/message_util.dart';

class UpdatePage extends StatefulWidget {
  final WordModel item;
  const UpdatePage({super.key, required this.item});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
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

  late final TextEditingController _englishCtrl =
      TextEditingController(text: widget.item.english);
  late final TextEditingController _khmerCtrl = TextEditingController(
    text: widget.item.khmer,
  );

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
              id: widget.item.id,
              english: _englishCtrl.text.trim(),
              khmer: _khmerCtrl.text.trim(),
            );

            _wordHelper.update(wordModel).then((value) {
              showSnackBar(context, "Update Successfully");
            });
          },
          icon: const Icon(Icons.save_alt),
          label: const Text('Update'),
        ),
      ],
    );
  }
}
