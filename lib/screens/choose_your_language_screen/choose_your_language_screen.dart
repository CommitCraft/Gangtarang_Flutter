import 'package:amazmart/theme/custom_button_style.dart';
import 'package:amazmart/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';

String activeImagePath = 'assets/images/lang_active.svg';
String inactiveImagePath = 'assets/images/lang_inactive.svg';
String viewLanguage = 'English';

class ChooseYourLanguageScreen extends StatefulWidget {
  bool? value;
  ChooseYourLanguageScreen({super.key, this.value});

  @override
  State<ChooseYourLanguageScreen> createState() =>
      _ChooseYourLanguageScreenState();
}

class _ChooseYourLanguageScreenState extends State<ChooseYourLanguageScreen> {
  List<LanguageListItem> filteredLanguages = [];
  final List<LanguageListItem> languages = [
    LanguageListItem(
      language: 'Hindi',
      flagPath: ImageConstant.flag_hindi,
      isActive: false,
    ),
    LanguageListItem(
      language: 'English',
      flagPath: ImageConstant.flag_english,
      isActive: true,
    ),
    LanguageListItem(
      language: 'French',
      flagPath: ImageConstant.flag_French,
      isActive: false,
    ),
    LanguageListItem(
      language: 'Germany',
      flagPath: ImageConstant.flag_germany,
      isActive: false,
    ),
    LanguageListItem(
      language: 'italian',
      flagPath: ImageConstant.flag_italian,
      isActive: false,
    ),
    LanguageListItem(
      language: 'Thai',
      flagPath: ImageConstant.flag_thai,
      isActive: false,
    ),
    LanguageListItem(
      language: 'Polish',
      flagPath: ImageConstant.flag_polish,
      isActive: false,
    ),
    LanguageListItem(
      language: 'Chinese',
      flagPath: ImageConstant.flag_chinese,
      isActive: false,
    ),
    LanguageListItem(
      language: 'Urdu',
      flagPath: ImageConstant.flag_urdu,
      isActive: false,
    ),
    LanguageListItem(
      language: 'Canadian',
      flagPath: ImageConstant.flag_canadian,
      isActive: false,
    ),
    LanguageListItem(
      language: 'Danish',
      flagPath: ImageConstant.flag_danish,
      isActive: false,
    ),
    LanguageListItem(
      language: 'Japanese',
      flagPath: ImageConstant.flag_japanese,
      isActive: false,
    ),
    LanguageListItem(
      language: 'Dutch',
      flagPath: ImageConstant.flag_dutch,
      isActive: false,
    ),
    LanguageListItem(
      language: 'Turkis',
      flagPath: ImageConstant.flag_turkish,
      isActive: false,
    ),

    // Add more languages here as needed
  ];
  int? selectedIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredLanguages = languages; // Initial list
  }

  void _filterLanguages(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredLanguages = languages; // If no query, show all
      } else {
        filteredLanguages = languages
            .where((language) =>
                language.language.toLowerCase().contains(query.toLowerCase()))
            .toList(); // Filter based on query
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Bar
            Container(
              height: kToolbarHeight,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 20),
                        CustomImageView(
                          imagePath: ImageConstant.g_logo,
                          width: 28,
                          height: 24,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'angtarang',
                          style: TextStyle(
                              fontFamily: 'Noto',
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context,
                            widget.value == null
                                ? AppRoutes.OnboardingScreen
                                : AppRoutes.homeScreen);
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: theme.primaryColor,
                          fontSize: 14.fSize,
                          fontFamily: 'Jost',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Color(0xFFDCDCDC)),

            // Search bar
            Container(
              padding: EdgeInsets.only(top: 16),
              child: CustomInputField(
                onChanged: (query) => _filterLanguages(query),
                hintText: 'Find a language',
                endIcon: Container(
                  padding: EdgeInsets.all(15),
                  child: CustomImageView(
                    color: theme.primaryColor,
                    imagePath: ImageConstant.iconSearch,
                    height: 14,
                    width: 14,
                  ),
                ),
              ),
            ),

            // Title Text
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 10, top: 22),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  filteredLanguages.isEmpty
                      ? "The language is not available."
                      : 'Choose Your Language',
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ),

            // Language List
           
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Adjust columns as needed
                  mainAxisSpacing: 10,
                  mainAxisExtent: 50,
                ),
                padding: EdgeInsets.only(left: 11, right: 11),
                itemCount: filteredLanguages.length,
                itemBuilder: (context, index) {
                  final languageItem = filteredLanguages[index];
                  return Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    height: 50.h,
                    width: double.infinity,
                    child: LanguageItem(
                      language: languageItem.language,
                      flagPath: languageItem.flagPath,
                      isActive: languageItem.isActive,
                      onPressed: (selectedLanguage) {
                        setState(() {
                          // Deselect all other items
                          for (var item in languages) {
                            item.isActive = false;
                          }
                          // Select the tapped item
                          languageItem.isActive = true;
                          viewLanguage = languageItem.language;
                        });
                      },
                    ),
                  );
                },
              ),
            ),

          //  Text(
          //       'More Language',
          //       style: TextStyle(
          //         fontFamily: 'Jost',
          //         fontWeight: FontWeight.w400,
          //         fontSize: 16,
          //         color: theme.primaryColor,
          //       ),
          //     ),

            Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(height: 48 ,child: ElevatedButton(
                onPressed: () {
                  Navigator.restorablePushReplacementNamed(
                      context,
                      widget.value == null
                          ? AppRoutes.OnboardingScreen
                          : AppRoutes.homeScreen);
                },
                style: CustomButtonStyles.fillAmber,
                child: Text(
                  'Continue in $viewLanguage',
                  style: TextStyle(
                    fontFamily: 'Jost',
                    fontSize: 16,
                    color: appTheme.black900,
                  ),
                ),
              )),
            ),
            
          ],
        ),
      ),
    );
  }
}

class LanguageItem extends StatelessWidget {
  final String language;
  final String flagPath;
  final bool isActive;
  final Function(String) onPressed; // Changed to Function(String)

  const LanguageItem({
    required this.language,
    required this.flagPath,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(language), // Pass language on tap
      child: SizedBox(
        height: 50.0,
        width: double.infinity, // Set desired height here
        child: Container(
          margin: EdgeInsets.only(right: 0),
          decoration: BoxDecoration(
            color: Color(0xFF190053B5),
            borderRadius: BorderRadius.circular(8),
            // border: Border.all(
            //   color: isActive ? Colors.blue : Colors.grey, // Border for active
            // ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  // Flag Image
                  CustomImageView(
                    imagePath: flagPath,
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(width: 8),
                  // Language Name
                  Text(
                    language,
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  // Active/Inactive Icon
                  CustomImageView(
                    imagePath: isActive
                        ? activeImagePath
                        : inactiveImagePath, // Update paths
                    width: 24,
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LanguageListItem {
  final String flagPath;
  final String language;
  bool isActive;

  LanguageListItem(
      {required this.flagPath, required this.language, this.isActive = false});
}
