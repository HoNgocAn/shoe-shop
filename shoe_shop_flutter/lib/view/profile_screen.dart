import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_shop_flutter/view/login_screen.dart';
import '../components/profile_info.dart';
import '../data/viewModel/auth_view_model.dart';
import '../utils/dialog_logout.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _handleLogout(BuildContext context) async {
    final shouldLogout = await DialogLogout.showLogoutConfirmationDialog(context);
    if (shouldLogout) {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      await authViewModel.logout();
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Selector<AuthViewModel, bool>(
      selector: (context, authProvider) => authProvider.isLoggedIn,
      builder: (context, isLoggedIn, child) {
        if (!isLoggedIn) {
          return const LoginScreen();
        }

        // final authService = AuthService(); // hoặc inject bằng Provider
        // final user = authService.getCurrentUser();
        // final photoUrl = user?.photoURL;
        // final displayName = user?.displayName ?? "User";
        Size size = MediaQuery.of(context).size;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Profile",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        Icon(
                          Icons.notifications_outlined,
                          size: 35,
                        )
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
// `                    // CircleAvatar(
//                     //   radius: 35,
//                     //   backgroundColor: Colors.black54,
//                     //   backgroundImage: photoUrl != null
//                     //       ? NetworkImage(photoUrl)
//                     //       : const AssetImage("asset/images/default_avatar.png") as ImageProvider,
//                     // ),
//                     // SizedBox(width: size.width * 0.06),
//                     // Text.rich(
//                     //   TextSpan(
//                     //     text: "$displayName\n",
//                     //     style:
//                     //     const TextStyle(fontSize: 20, color: Colors.black),
//                     //     children: const [
//                     //       TextSpan(
//                     //         text: "Show profile",
//                     //         style: TextStyle(
//                     //           fontSize: 16,
//                     //           color: Colors.black54,
//                     //         ),
//                     //       ),
//                     //     ],
//                     //   ),
//                     // ),`
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.black12),
                    const SizedBox(height: 10),
                    Card(
                      elevation: 4,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text.rich(
                              TextSpan(
                                text: "Airbnb your place\n",
                                style: TextStyle(
                                  height: 2.5,
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        "It's simple to get set up and \nstart earning.",
                                    style: TextStyle(
                                      height: 1.2,
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Image.network(
                              "https://static.vecteezy.com/system/resources/previews/034/950/530/non_2x/ai-generated-small-house-with-flowers-on-transparent-background-image-png.png",
                              height: 140,
                              width: 135,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.black12),
                    const SizedBox(height: 15),
                    const Text(
                      "Settings",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const ProfileInfo(
                        icon: Icons.person_2_outlined,
                        name: "Personal information"),
                    const ProfileInfo(
                        icon: Icons.security, name: "Login & security"),
                    const ProfileInfo(
                        icon: Icons.payments_outlined,
                        name: "Payments and payouts"),
                    const ProfileInfo(
                        icon: Icons.settings_outlined, name: "Accessibility"),
                    const ProfileInfo(icon: Icons.note_outlined, name: "Taxes"),
                    const ProfileInfo(
                        icon: Icons.translate, name: "Translation"),
                    const ProfileInfo(
                        icon: Icons.notifications_outlined,
                        name: "Notifications"),
                    const ProfileInfo(
                        icon: Icons.lock_outline, name: "Privacy and sharing"),
                    const ProfileInfo(
                        icon: Icons.card_travel, name: "Travel for work"),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () => _handleLogout(context),
                      child: const Text(
                        "Log out",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(
                      color: Colors.black12,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Version 24.34 (28004615)",
                      style: TextStyle(fontSize: 10),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
