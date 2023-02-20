import 'package:flutter/material.dart';
import 'package:kappu/components/AppColors.dart';
import 'package:kappu/provider/provider_provider.dart';
import 'package:kappu/screens/privacy_policy/privacy_policy.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../helperfunctions/screen_nav.dart';
import '../../edit_profile/edit_profile.dart';
import '../myoffers/myoffers.dart';

class SettingsPageProvider extends StatefulWidget {
  const SettingsPageProvider({Key? key}) : super(key: key);

  @override
  _SettingsPageProviderState createState() => _SettingsPageProviderState();
}

class _SettingsPageProviderState extends State<SettingsPageProvider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: const SizedBox(),
        backgroundColor: Colors.transparent,
        title: const Text(
          'Settings',
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<ProviderProvider>(
              builder: (context, loggedinprovider, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: AppColors.app_color,
                    child: ListTile(
                      onTap: () {
                        changeScreen(
                            context: context,
                            screen: const EditProfile(
                              isuser: false,
                            ));
                      },
                      title: Text(
                        loggedinprovider.provider.firstname +
                            " " +
                            loggedinprovider.provider.lastname,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                                'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
                      ),
                      trailing: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(
                            Icons.lock_outline,
                            color: AppColors.app_color,
                          ),
                          title: const Text("Change Password"),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //open change password
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: const Icon(
                            Icons.local_offer,
                            color: AppColors.app_color,
                          ),
                          title: const Text("My Offers"),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //open change language

                            pushDynamicScreen(context,
                                screen: Myoffers(), withNavBar: false);
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: const Icon(
                            Icons.privacy_tip,
                            color: AppColors.app_color,
                          ),
                          title: const Text("Privacy Policy"),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //open change language
                            changeScreen(
                                context: context,
                                screen: const PrivacyPolicy());
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: const Icon(
                            Icons.logout,
                            color: AppColors.app_color,
                          ),
                          title: const Text("Logout"),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //open change location
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "Notification Settings",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.app_color,
                    ),
                  ),
                  SwitchListTile(
                    activeColor: AppColors.app_color,
                    contentPadding: const EdgeInsets.all(0),
                    value: true,
                    title: const Text("Received notification"),
                    onChanged: (val) {},
                  ),
                  const SwitchListTile(
                    activeColor: AppColors.app_color,
                    contentPadding: EdgeInsets.all(0),
                    value: false,
                    title: Text("Received newsletter"),
                    onChanged: null,
                  ),
                  SwitchListTile(
                    activeColor: AppColors.app_color,
                    contentPadding: const EdgeInsets.all(0),
                    value: true,
                    title: const Text("Received Offer Notification"),
                    onChanged: (val) {},
                  ),
                  const SwitchListTile(
                    activeColor: AppColors.app_color,
                    contentPadding: EdgeInsets.all(0),
                    value: true,
                    title: Text("Received App Updates"),
                    onChanged: null,
                  ),
                  const SizedBox(height: 60.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}
