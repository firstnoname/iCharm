import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class QuestionAndAnswer extends StatelessWidget {
  const QuestionAndAnswer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<String> preparePdf() async {
      const String _documentPath = 'test_pdf.pdf';
      final ByteData bytes =
          await DefaultAssetBundle.of(context).load(_documentPath);
      final Uint8List list = bytes.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final tempDocumentPath = '${tempDir.path}/$_documentPath';

      final file = await File(tempDocumentPath).create(recursive: true);
      file.writeAsBytesSync(list);
      return tempDocumentPath;
    }

    return Scaffold(
      // body: PDFView(
      //   filePath: ,
      // ),
      appBar: AppBar(
        title: const Text('Q & A'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/q_and_a/q_a_icharm-A4-01.jpg'),
            Image.asset('assets/images/q_and_a/q_a_icharm-A4-02.jpg'),
          ],
        ),
      ),
    );
  }
}
