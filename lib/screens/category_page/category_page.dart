import 'package:amazmart/api/WooCommerceApi.dart';
import 'package:amazmart/api/categories_items.dart';
import 'package:amazmart/screens/category_page/widgets/category_list_widget.dart';
import 'package:amazmart/screens/products_list_screen/products_list_screen.dart';
import 'package:amazmart/screens/search_screen/search_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';

/// Data model for main categories.
class Cat {
  final int catId;
  final String catName;
  final String catImage;
  bool catSelected;

  Cat({
    required this.catName,
    required this.catId,
    required this.catImage,
    this.catSelected = false,
  });
}

/// List of main categories to be displayed.
List<Cat> catList = [
  Cat(catName: 'Shivlings', catImage: '', catId: 38),
  Cat(catName: 'Shankh', catImage: '', catId: 36),
  Cat(catName: 'Ganga Water', catImage: '', catId: 32),
  Cat(catName: 'MALA', catImage: '', catId: 39),
  Cat(catName: 'Pendant', catImage: '', catId: 33),
  Cat(catName: 'Ring', catImage: '', catId: 32),
];

/// Data model for sidebar items.
class SlideCatModal {
  final String Name;
  final String Image;
  bool Selected;

  SlideCatModal({
    required this.Name,
    required this.Image,
    this.Selected = false,
  });
}

/// List of items for the sidebar navigation.
List<SlideCatModal> slidList = [
  SlideCatModal(Name: 'View All', Image: ImageConstant.iconHome, Selected: true),
  SlideCatModal(Name: 'Shivling', Image: ImageConstant.shivaling),
  SlideCatModal(
    Name: 'Shankh',
    Image: ImageConstant.Shankh,
  ),
  SlideCatModal(
    Name: 'Ganga Water',
    Image: ImageConstant.water,
  ),
  SlideCatModal(
    Name: 'MALA',
    Image: ImageConstant.mala,
  ),
  SlideCatModal(
    Name: 'Pendant',
    Image: ImageConstant.pendant,
  ),
  SlideCatModal(
    Name: 'Ring',
    Image: ImageConstant.ring,
  ),
];

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late WooCommerceApi _wooCommerceApi;
  late List<List<CategoriesItems>> subcategoriesByMainCategory = [];
  bool isLoading = true;
  int _currentSidebarIndex = 0; // 0 for "View All"
  String _currentSidebarTitle = 'View All';

  @override
  void initState() {
    super.initState();
    _wooCommerceApi = WooCommerceApi(WooCommerceApi.createDio());

    for (int i = 0; i < catList.length + 1; i++) {
      subcategoriesByMainCategory.add([]);
    }

    _fetchAllCategories();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchAllCategories() async {
    setState(() {
      isLoading = true;
    });
    try {
      for (int i = 0; i < catList.length; i++) {
        var item = catList[i];
        await _fetchSubcategories(item.catId, i + 1); // +1 because index 0 is "View All"
      }
      _populateViewAllSubcategories();

    } on DioException catch (e) {
      print('Categories Fetch Error: ${e.response?.data ?? e.message}');
      // TODO: Display user-friendly error message
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchSubcategories(int id, int index) async {
    try {
      var categories = await _wooCommerceApi.getCategories(id);
      if (mounted) {
        setState(() {
          subcategoriesByMainCategory[index].addAll(categories);
        });
      }
    } on DioException catch (e) {
      print('Subcategories Error for ID $id: ${e.response?.data ?? e.message}');
      // TODO: Handle individual subcategory fetch errors if necessary
    }
  }

  void _populateViewAllSubcategories() {
    final List<CategoriesItems> allSubcategories = [];
    for (int i = 1; i < subcategoriesByMainCategory.length; i++) {
      allSubcategories.addAll(subcategoriesByMainCategory[i]);
    }
    setState(() {
      subcategoriesByMainCategory[0] = allSubcategories;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: _buildAppBar(context),
          leadingWidth: double.maxFinite,
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Sidebar
            Container(
              width: 100, // Sidebar width
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [appTheme.cyan50, appTheme.cyan200],
                ),
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemCount: slidList.length,
                  itemBuilder: (context, index) {
                    final e = slidList[index];
                    return _buildLeftSidebarItem(
                      title: e.Name,
                      iconPath: e.Image,
                      isSelected: _currentSidebarIndex == index,
                      onTap: () {
                        setState(() {
                          _currentSidebarIndex = index;
                          _currentSidebarTitle = e.Name;
                        });
                      },
                    );
                  },
                ),
              ),
            ),
            // Main Content
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (_currentSidebarIndex == 0) // "View All" selected
                      ...List.generate(
                        catList.length,
                            (index) {
                          var e = catList[index];
                          return _buildCategorySection(
                            title: e.catName,
                            items: subcategoriesByMainCategory[index + 1], // +1 for "View All"
                          );
                        },
                      )
                    else // A specific category selected
                      _buildCategorySection(
                        title: _currentSidebarTitle,
                        items: subcategoriesByMainCategory[_currentSidebarIndex],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftSidebarItem({
    required String title,
    required String iconPath,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: isSelected ? appTheme.whiteA700 : Colors.transparent,
        child: Column(
          children: [
            IconButton(
              icon: CustomImageView(imagePath: iconPath, height: 24, width: 24),
              onPressed: onTap,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: CustomTextStyles.bodyMediumOnPrimary_1,
            ),
            const SizedBox(height: 3),
            const Divider(color: Colors.white54),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection({
    required String title,
    required List<CategoriesItems> items,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Text(
              title,
              style: CustomTextStyles.titleSmallErrorContainer_1,
            ),
          ),
          const Divider(),
          const SizedBox(height: 8),
          _buildSubcategoryGrid(items),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildSubcategoryGrid(List<CategoriesItems> items) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(left: 8),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(
              items.length,
                  (index) => CategorieslistItemWidget(
                imagePath: items[index].image?.src ?? ImageConstant.imageNotFound,
                label: items[index].name ?? 'N/A',
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ProductsListScreen(
                          items: items[index],
                        ),
                  ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: appTheme.gray100,
              borderRadius: BorderRadius.circular(5.h),
            ),
            margin: EdgeInsets.only(left: 12.h, top: 5.h, bottom: 5.h),
            child: IconButton(
              color: appTheme.black900,
              icon: CustomImageView(
                imagePath: ImageConstant.backIcon,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 5),
                Text(
                  'All Categories',
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: appTheme.gray100,
              borderRadius: BorderRadius.circular(5.h),
            ),
            margin: EdgeInsets.only(right: 12.h, top: 5.h, bottom: 5.h),
            child: Stack(
              children: [
                IconButton(
                  color: appTheme.black900,
                  icon: CustomImageView(
                    imagePath: ImageConstant.iconSearch,
                    height: 20,
                    width: 20,
                    color: appTheme.black900,
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          SearchScreen(),
                    ));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}