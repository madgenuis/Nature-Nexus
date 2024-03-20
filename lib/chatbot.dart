import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class CustomIframeScreen extends StatefulWidget {
  const CustomIframeScreen({Key? key}) : super(key: key);

  @override
  State<CustomIframeScreen> createState() => _CustomIframeScreenState();
}

class _CustomIframeScreenState extends State<CustomIframeScreen> {
  final IFrameElement _iFrameElement = IFrameElement();

  @override
  void initState() {
    super.initState();

    _iFrameElement.style.height = '98%';
    _iFrameElement.style.width = '100%';
    _iFrameElement.src = 'https://console.dialogflow.com/api-client/demo/embedded/ede26041-3e77-4aaa-b93b-aebb815206f8';
    _iFrameElement.style.border = 'none';

    ui.platformViewRegistry.registerViewFactory(
      'customIframeElement',
          (int viewId) => _iFrameElement,
    );
  }

  final Widget _customIframeWidget = HtmlElementView(
    viewType: 'customIframeElement',
    key: UniqueKey(),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: _customIframeWidget,
          ),
        ],
      ),
    );
  }
}
