import 'package:amazmart/api/WooCommerceApi.dart';
import 'package:amazmart/api/categories_items.dart';
import 'package:amazmart/api/mySql/cart_item.dart';
import 'package:amazmart/screens/category_page/widgets/category_list_widget.dart';
import 'package:amazmart/screens/home_screen/home_initial_page.dart';
import 'package:amazmart/screens/products_list_screen/products_list_screen.dart';
import 'package:amazmart/screens/search_screen/search_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../../core/app_export.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late WooCommerceApi _wooCommerceApi;
  late List<CategoriesItems> categoriesList = [];
  late List<List<CategoriesItems>> tempList = [];
  late bool isLoading = true;
  late bool isTempLoad = false;

  @override
  void initState() {
    super.initState();
    _wooCommerceApi = WooCommerceApi(WooCommerceApi.createDio());
// list creata for loop run one by one all cate groy add temp var more

    // Initialize tempList with empty sub-lists
    for (int i = 0; i < catList.length; i++) {
      tempList.add([]); // Add an empty sub-list for each category
    }

    for (int i = 0; i < catList.length; i++) {
      var item = catList[i];
      fetchCategories(item.catId, i);
    }
    isTempLoad = true;
  }

  Future fetchCategories(int id, int index) async {
    print('Categories $id $index');
    try {
      var categories = await _wooCommerceApi.getCategories(id); // id
      setState(() {
        tempList[index].addAll(categories);
        isLoading = false;

        categoriesList = categories;
      });
      print("Categories Respons${tempList.length}");
    } on DioException catch (e) {
      print('Categories Error ${e.response}');
    }
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
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                children: slidList.map(
                  (e) {
                    return _buildLeftSidebarItem(
                      title: e.Name,
                      iconPath: e.Image,
                      Selected: e.Selected,
                      onTap: () {
                        setState(() {
                          for (var el in slidList) {
                            el.Selected = false;
                          }
                          e.Selected = true;
                        });
                      },
                    );
                  },
                ).toList(),
                // children: [
                //   _buildLeftSidebarItem(
                //     title: "View All",
                //     iconPath: ImageConstant.img1,
                //   ),
                //   _buildLeftSidebarItem(
                //     title: "Personal Care",
                //     iconPath: ImageConstant.img1,
                //   ),
                //   _buildLeftSidebarItem(
                //     title: "Home",
                //     iconPath: ImageConstant.img1,
                //   ),
                //   _buildLeftSidebarItem(
                //     title: "Toy & Baby",
                //     iconPath: ImageConstant.img1,
                //   ),
                // ],
              ),
            ),
            // Main Content
            Expanded(
              child: !isTempLoad
                  ? Text('data')
                  : SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: !isLoading
                            ? List.generate(
                                catList.length,
                                (index) {
                                  var e = catList[index];
                                  // fetchCategories(e.catId, index);
                                  return _buildSection(
                                    title: e.catName,
                                    child: _buildCatItemList(
                                        context, tempList[index]),
                                  );
                                },
                              )
                            : [
                                Center(
                                  child: CircularProgressIndicator(),
                                )
                              ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftSidebarItem(
      {required String title,
      required String iconPath,
      required VoidCallback onTap,
      required bool Selected}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Selected ? appTheme.whiteA700 : Colors.transparent,
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
            const SizedBox(
              height: 3,
            ),
            const Divider(color: Colors.white54),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
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
          const SizedBox(
            height: 8,
          ),
          child,
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildCatItemList(BuildContext context, List<CategoriesItems> items) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(left: 8),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Wrap(
            spacing: 8.0, // Adjust spacing between items as needed
            runSpacing: 8.0, // Adjust spacing between rows as needed
            children: List.generate(
              items.length,
              (index) => CategorieslistItemWidget(
                imagePath: items[index].image != null
                    ? items[index].image!.src!
                    : ImageConstant.imageNotFound,
                label: items[index].name,
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
        color: appTheme.whiteA700, // Light blue
        // Light green
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

// add category is blow list in show in app main category id for show sub categroy
List<Cat> catList = [
  Cat(catName: 'Televisions', catImage: '', catId: 15),
  Cat(catName: 'Camera', catImage: '', catId: 31),
  Cat(catName: 'Computer Accessories', catImage: '', catId: 35),
  Cat(catName: 'Brand', catImage: '', catId: 39),
];

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

List<SlideCatModal> slidList = [
  SlideCatModal(
      Name: 'Shivling',
      Image: ImageConstant.shivaling,
      Selected: true),
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

