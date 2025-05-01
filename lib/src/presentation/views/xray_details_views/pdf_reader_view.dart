import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../widgets/default_app_text.dart';

class PDFReaderView extends StatelessWidget {
  const PDFReaderView({super.key, required this.file});

  final PlatformFile file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40, bottom: 10),
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: DefaultAppText(
                    text: file.name,
                    textAlign: TextAlign.center,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: file.path?.contains("http") == true
                ? SfPdfViewer.network(
                    "${file.path}",
                  )
                : SfPdfViewer.file(
                    File(
                      "${file.path}",
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
