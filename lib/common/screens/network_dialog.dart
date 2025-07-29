import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/provider/network_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class NoInternetDialog extends StatelessWidget {
  const NoInternetDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NetworkProvider>(context, listen: false);
    final isloading = provider.isLoaing;

    return PopScope(
      canPop: false, 
      child: Material(
        color: const Color.fromARGB(60, 0, 0, 0),
        child: Center(
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content:isloading
            ?CircularProgressIndicator(color: AppColor.primaryColor,) 
            :Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/lottie/No Connection.json',
                  width: 250,
                  repeat: true,
                ),
                const Text(
                  'No Internet Connection',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
              const Text(
                'Please check your network and try again.',
                textAlign: TextAlign.center,
              ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.refresh, color:  AppColor.greyTextDark,),
                        label: const Text("Retry",style: TextStyle(color:  AppColor.greyTextDark,),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.greyCardBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),),
                        onPressed: () async {
                          await provider.retryConnection();
                        },
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.exit_to_app ,color:  AppColor.greyTextDark,),
                        label: const Text("Exit",style:TextStyle(color:  AppColor.greyTextDark,),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.greyCardBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),),
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
