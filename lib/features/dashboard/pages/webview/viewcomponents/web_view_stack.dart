part of '../paymentwebview.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({super.key, required this.controller});

  final WebViewController controller;


  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorTween;

  var loadingPercentage = 0;



  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this, // Providing TickerProviderStateMixin
    )..repeat(reverse: true);

    _colorTween = _controller.drive(
      ColorTween(begin: AppColors.defaultAppRed, end: AppColors.defaultAppPurple),
    );
    widget.controller..setNavigationDelegate(
        NavigationDelegate(
            onPageStarted: (url) {
              setState(() {
                loadingPercentage = 0;
              });
            },
            onProgress: (progress) {
              setState(() {
                loadingPercentage = progress;
              });
            },
            onPageFinished: (url) {
              setState(() {
                loadingPercentage = 100;
              });
            },
            onNavigationRequest: (navigation) async {
              final host = Uri.parse(navigation.url).host;
              if(host.contains('wencetechnologies.com')){
                await Future.delayed(Duration(seconds: 2));
                context.pop();
                //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successful Purchase")));
                //AnimatedOverlaySnackbar.show(context, "Successfull Purchase",color:Colors.green);
                rootScaffoldMessengerKey.currentState!.showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.greenColor,
                    content: Text(
                      "Payment Successful",
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  ),
                );
                return NavigationDecision.prevent;

              }
              return NavigationDecision.navigate;
            }
        ))..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('SnackBar', onMessageReceived: (message){
        AnimatedOverlaySnackbar.show(context, "Error: No item has been added to cart",color: AppColors.defaultAppRed);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message.message)));
      })
    ;
  }
@override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(
          controller: widget.controller,
        ),
        if (loadingPercentage < 100)
          LinearProgressIndicator(
            value: loadingPercentage / 100.0,
            valueColor: _colorTween,
          ),
      ],
    );
  }
}
