import 'dart:convert';

import 'package:amazon_ft/domain/model/four_images_offer.dart';
import 'package:amazon_ft/domain/model/product.dart';
import 'package:flutter/material.dart';

import '../../domain/model/order.dart';
import '../../domain/model/rating.dart';
import '../../domain/model/sales.dart';
import '../../domain/model/single_image_offer.dart';
import '../../domain/model/user.dart';

class Constants {
// COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color(0xff84D8E3),
      Color(0xffA6E6CE),
    ],
    // stops: [0.5, 1.0],
  );
  static const addressBarGradient = LinearGradient(
    colors: [
      Color(0xffB6E8EF),
      Color(0xffCBF1E2),
    ],
    stops: [0.5, 1.0],
  );

  static const goldenGradient = LinearGradient(
      colors: [Color(0xffFFEDBB), Color(0xffFEDC71)], stops: [0.25, 1]);

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const yellowColor = Color(0xffFED813);
  static const backgroundColor = Colors.white;
  static const greenColor = Color(0xff057205);
  static const redColor = Color(0xffB22603);
  static const Color greyBackgroundColor = Color(0xffF6F6F6);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;

  static User mockUser = const User(
      id: 'user01',
      name: 'User',
      email: 'user@email.com',
      password: '123456',
      address: 'Lê Văn Lương, Phước Kiển, Nhà Bè, TPHCM',
      type: 'user',
      token: 'token_user',
      cart: [],
      saveForLater: [],
      keepShoppingFor: mockKeepShoppingForList,
      wishList: mockWishList);

  static User mockAdmin = const User(
      id: 'admin01',
      name: 'Admin',
      email: 'admin@email.com',
      password: '123456',
      address: 'Lê Văn Lương, Phước Kiển, Nhà Bè, TPHCM',
      type: 'admin',
      token: 'token_admin',
      cart: [],
      saveForLater: [],
      keepShoppingFor: [],
      wishList: []);

  // categories
  static List<String> productCategories = [
    'Category',
    'Mobiles',
    'Fashion',
    'Electronics',
    'Home',
    'Beauty',
    'Appliances',
    'Grocery',
    'Books',
    'Essentials',
  ];

  static OutlineInputBorder inputBorderStyle = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black38),
    borderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
  );

  // category images
  static const List<Map<String, String>> categoryImages = [
    {'title': 'Mobiles', 'image': 'assets/images/category_images/mobiles.jpeg'},
    {'title': 'Fashion', 'image': 'assets/images/category_images/fashion.jpeg'},
    {
      'title': 'Electronics',
      'image': 'assets/images/category_images/electronics.jpeg'
    },
    {'title': 'Home', 'image': 'assets/images/category_images/home.jpeg'},
    {'title': 'Beauty', 'image': 'assets/images/category_images/beauty.jpeg'},
    {
      'title': 'Appliances',
      'image': 'assets/images/category_images/appliances.jpeg'
    },
    {'title': 'Grocery', 'image': 'assets/images/category_images/grocery.jpeg'},
    {'title': 'Books', 'image': 'assets/images/category_images/books.jpeg'},
    {
      'title': 'Essentials',
      'image': 'assets/images/category_images/essentials.jpeg'
    },
  ];

  // Carousel images
  static const List<Map<String, String>> carouselImages = [
    {
      'category': 'Mobiles',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699265366/carousel_images/bg4c71tkghkwtnxkfx8r.jpg',
    },
    {
      'category': 'Fashion',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699265359/carousel_images/lynhzhgccpfb8pbdknyh.jpg',
    },
    {
      'category': 'Beauty',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699265354/carousel_images/ysdubrrkwbi5rqqcupg5.jpg',
    },
    {
      'category': 'Appliances',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699265359/carousel_images/lh9urah5mtrd8uolos2m.jpg',
    },
    {
      'category': 'Mobiles',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699265358/carousel_images/mvrwbxras7uig7woc5gj.jpg',
    },
    {
      'category': 'Mobiles',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699265355/carousel_images/josedcgjkzst3iqnpqgf.jpg',
    },
    {
      'category': 'Electronics',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699265357/carousel_images/nx2nmaq4pbqlebiexqup.jpg',
    },
    {
      'category': 'Electronics',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699265358/carousel_images/gvgwvhmodau81bwddsrh.jpg',
    },
    {
      'category': 'Mobiles',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699265354/carousel_images/tb0uzkote4twcczih8xj.jpg',
    },
  ];

  static List<Map<String, String>> shuffledCarouselImages(
      List<Map<String, String>> carouselImages) {
    carouselImages.shuffle();

    return carouselImages;
  }

  //Bottom offers amazon pay
  static const List<Map<String, String>> bottomOffersAmazonPay = [
    {
      'title': 'Amazon Pay',
      'image': 'assets/images/bottom_offers/amazon_pay.png'
    },
    {
      'title': 'Recharge',
      'image': 'assets/images/bottom_offers/amazon_recharge.png'
    },
    {
      'title': 'Rewards',
      'image': 'assets/images/bottom_offers/amazon_rewards.png'
    },
    {
      'title': 'Pay Bills',
      'image': 'assets/images/bottom_offers/amazon_bills.png'
    },
  ];

  //Bottom offer under price
  static const List<Map<String, String>> bottomOffersUnderPrice = [
    {
      'title': 'Budget Buys',
      'image': 'assets/images/bottom_offers/budgetBuys.png'
    },
    {'title': 'Best Buys', 'image': 'assets/images/bottom_offers/bestBuys.png'},
    {
      'title': 'Super Buys',
      'image': 'assets/images/bottom_offers/superBuys.png'
    },
    {'title': 'Top Picks', 'image': 'assets/images/bottom_offers/topPicks.png'},
  ];

  // Bottom offers images
  static const List<Map<String, String>> bottomOfferImages = [
    {
      'category': 'AmazonPay',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699472117/bottom_offers/quvjt4q774dqkkqe0tb4.png',
    },
    {
      'category': 'Mobiles',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699264799/bottom_offers/kxymbalj4pmgeor4u6ug.jpg',
    },
    {
      'category': 'Mobiles',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699264799/bottom_offers/uthsphrtzpcfubvq9dwn.png',
    },
    {
      'category': 'Beauty',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699264800/bottom_offers/v3nc5x9boosqlkbz2nrj.png',
    },
    {
      'category': 'Mobiles',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699264798/bottom_offers/qctd1ju8kieb9oyuyfc2.jpg',
    },
    {
      'category': 'Essentials',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699264798/bottom_offers/e4omcec49lsdjedjvzl9.jpg',
    },
    {
      'category': 'Grocery',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699264799/bottom_offers/sjjbdzyowmgcznugrqsv.jpg',
    },
    {
      'category': 'Essentials',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699264798/bottom_offers/xohbxfozk55euqsprjmp.jpg',
    },
    {
      'category': 'Home',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699264798/bottom_offers/jerrpfgphdk76isd5c8s.jpg',
    },
    {
      'category': 'Fashion',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699264798/bottom_offers/iu5u3qvtxrriyb13eh5g.jpg',
    },
    {
      'category': 'Home',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699264799/bottom_offers/qlpctc3ljlkka4wqy6dr.jpg',
    },
    {
      'category': 'Fashion',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699264799/bottom_offers/emqsyqzli078fguthilp.jpg',
    },
  ];

  // Multiimage offers
  // mulit image offer 1
  static const List<Map<String, String>> multiImageOffer1 = [
    {
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699616716/multi_image_offers/multi_image_offer1/ixunkzn9ihxmq7sz5kbu.jpg',
      'offerTitle': 'Health & household'
    },
    {
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699616716/multi_image_offers/multi_image_offer1/qoluocxlfvfsm06aft7m.jpg',
      'offerTitle': 'Grocery essentials'
    },
    {
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699616716/multi_image_offers/multi_image_offer1/opop30gr9ko1rh31elnp.jpg',
      'offerTitle': 'Beauty products'
    },
    {
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699616716/multi_image_offers/multi_image_offer1/drlfqq5spc08gtpwoehi.jpg',
      'offerTitle': 'Visit store'
    },
  ];

  // Multi image offers 2
  static const List<Map<String, String>> multiImageOffer2 = [
    {
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699616730/multi_image_offers/multi_image_offer2/fy7cga8bnkhbwdczeojg.jpg',
      'offerTitle': 'Under ₹299 | Kitchen accessories'
    },
    {
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699616730/multi_image_offers/multi_image_offer2/vpvy0tubzfu5xb7rdowo.jpg',
      'offerTitle': 'Under ₹499 | Kitchen jars, containers & more'
    },
    {
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699616730/multi_image_offers/multi_image_offer2/ozc0y0aprcduz1k6mzbn.jpg',
      'offerTitle': '₹499 - ₹999 | Cookware sets'
    },
    {
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699616730/multi_image_offers/multi_image_offer2/f9zsqeaq2shwflttwfcu.jpg',
      'offerTitle': 'Min. 60% Off | Dinnerware'
    },
  ];

  // multi image offer 3
  static const List<Map<String, String>> multiImageOffer3 = [
    {
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699616731/multi_image_offers/multi_image_offer3/cxywqfuwdqdlmxfwhznh.jpg',
      'offerTitle': 'Redmi (32) 4K TV | Lowest ever prices'
    },
    {
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699616731/multi_image_offers/multi_image_offer3/jypnmwrxog1zhmgkn0mq.jpg',
      'offerTitle': 'OnePlus (50) 4K TV | Flat 43% off'
    },
    {
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699616731/multi_image_offers/multi_image_offer3/by0atjdadl3vdxvkwcxe.jpg',
      'offerTitle': 'Samsung (65) iSmart TV | Bestseller'
    },
    {
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699616732/multi_image_offers/multi_image_offer3/kdbran924rp1dcfxkc37.jpg',
      'offerTitle': 'Sony (55) 4K TV | Get 3 years warranty'
    },
  ];

  //muli image offer 4
  static const List<Map<String, String>> multiImageOffer4 = [
    {
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699616739/multi_image_offers/multi_image_offer4/sg6xeof7e8c6i8tdtn3a.png',
      'offerTitle': 'Starting ₹79 | Cycles, helmets & more'
    },
    {
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699616735/multi_image_offers/multi_image_offer4/gwknudygu8xkgbqwjhyh.png',
      'offerTitle': 'Starting ₹99 | Cricket'
    },
    {
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699616737/multi_image_offers/multi_image_offer4/ye374adnpqqw0g9rpdrh.png',
      'offerTitle': 'Starting ₹99 | Badminton'
    },
    {
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699616735/multi_image_offers/multi_image_offer4/j6qu404fobsayouau9et.png',
      'offerTitle': 'Starting ₹49 | Fitness accessories & more'
    },
  ];

  static const List<Map<String, String>> multiImageOffer5 = [
    {
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699616735/multi_image_offers/multi_image_offer5/jmowr6zekxwqa1eb9byb.png',
      'offerTitle': 'Cooking ingredients'
    },
    {
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699616736/multi_image_offers/multi_image_offer5/jl5sruf184umnwrhic3s.png',
      'offerTitle': 'Sweets'
    },
    {
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699616737/multi_image_offers/multi_image_offer5/jqdwbsu2f9zbribwyybs.png',
      'offerTitle': 'Cleaning supplies'
    },
    {
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699616740/multi_image_offers/multi_image_offer5/frqjrpvryuwsmga2ohay.png',
      'offerTitle': 'View all offers'
    },
  ];

  static const List<Map<String, String>> productQualityDetails = [
    {
      'iconName': 'replacement.png',
      'title': '7 days Service Centre Replacement'
    },
    {'iconName': 'free_delivery.png', 'title': 'Free Delivery'},
    {'iconName': 'warranty.png', 'title': '1 Year Warranty'},
    {'iconName': 'pay_on_delivery.png', 'title': 'Pay on Delivery'},
    {'iconName': 'top_brand.png', 'title': 'Top Brand'},
    {'iconName': 'delivered.png', 'title': 'Amazon Delivered'},
  ];

  static const List<Map<String, String>> menuScreenImages = [
    {
      'title': 'Mobiles, Smartphones',
      'category': 'Mobiles',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699008683/menu_screen_images/hpaduzg6ws3gttr1fvqc.png',
    },
    {
      'title': 'Fashion, Clothing',
      'category': 'Fashion',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699008683/menu_screen_images/kf3f4gsxfrc05iewamt3.png'
    },
    {
      'title': 'Electronics & Audio',
      'category': 'Electronics',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699008678/menu_screen_images/kurapdxq9i2n2m6vvdyz.png'
    },
    {
      'title': 'Home, Kitchen & Decor',
      'category': 'Home',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699008675/menu_screen_images/jyp9jwyudc0jh6gao2uc.png'
    },
    {
      'title': 'Beauty, Skincare',
      'category': 'Beauty',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699008678/menu_screen_images/b5zl9qkm3cx20eklrfjm.png'
    },
    {
      'title': 'Appliances',
      'category': 'Appliances',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699008672/menu_screen_images/i8u2o2lknnqhjaybewbr.png'
    },
    {
      'title': 'Grocery, Food & Beverages',
      'category': 'Grocery',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699008681/menu_screen_images/wlad5ab74zzn49iqhkbk.png'
    },
    {
      'title': 'Books, Novels',
      'category': 'Books',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699008671/menu_screen_images/javbsvmojbp3725oysoo.jpg'
    },
    {
      'title': 'Essentials, Kitchen',
      'category': 'Essentials',
      'image':
          'https://res.cloudinary.com/dthljz11q/image/upload/v1699008683/menu_screen_images/u7lk7kkv4vlra4dhjdnj.png'
    },
  ];

  static List<Order> mockOrderList = [
    Order(
        id: 'order01',
        products: [
          Product(
              name: 'iPhone 16 Pro Max 256GB | Chính hãng VN/A',
              description: 'iPhone 16 Pro Max 256GB | Chính hãng VN/A',
              quantity: 10,
              images: [
                'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-16-pro.png'
              ],
              category: 'Mobiles',
              price: 10,
              id: 'id01',
            rating: [
              Rating(userId: 'userId01', rating: 1.1),
            ]
          )
        ],
        quantity: [1],
        address: 'address01',
        userId: 'userId01',
        orderedAt: 1,
        status: 1,
        totalPrice: 100),
    Order(
        id: 'order02',
        products: [
          Product(
              name: 'MacBook Pro 14 M4 Pro 12CPU 16GPU 24GB 512GB | Chính hãng Apple Việt Nam',
              description: 'MacBook Pro 14 M4 Pro 12CPU 16GPU 24GB 512GB | Chính hãng Apple Việt Nam',
              quantity: 30,
              images: [
                'https://cdn.tgdd.vn/Products/Images/44/231244/grey-1-750x500.jpg'
              ],
              category: 'Mobiles',
              price: 30,
              id: 'id01',
              rating: [
                Rating(userId: 'userId01', rating: 1.1),
              ]
          )
        ],
        quantity: [2],
        address: 'address02',
        userId: 'userId01',
        orderedAt: 2,
        status: 1,
        totalPrice: 200),
    Order(
        id: 'order03',
        products: mockProductList,
        quantity: [10, 20, 30, 40],
        address: 'address03',
        userId: 'userId01',
        orderedAt: 3,
        status: 1,
        totalPrice: 300),
  ];

  static const mockProduct = Product(
      name: 'iPhone 16 Pro Max 256GB | Chính hãng VN/A',
      description: 'description01',
      quantity: 10,
      images: [
        'https://shop.switch.com.my/cdn/shop/files/iPhone_16_Pro_Natural_Titanium_PDP_Image_Position_1b_Natural_Titanium_Colour__MY-EN.jpg?v=1725947613&width=823'
      ],
      category: 'Mobiles',
      price: 10);

  static List<Product> mockProductList = [
    Product(
        name: 'iPhone 16 Pro Max 256GB | Chính hãng VN/A',
        description: 'description01',
        quantity: 10,
        images: [
          'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-16-pro.png'
        ],
        category: 'Mobiles',
        price: 10,
        id: 'id01',
        rating: [
          Rating(userId: 'userId01', rating: 1.1),
        ]
    ),
    Product(
        name: 'Apple MacBook Air M1 256GB 2020 I Chính hãng Apple Việt Nam',
        description: 'description02',
        quantity: 20,
        images: [
          'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-16-pro.png'
        ],
        category: 'Fashion',
        price: 20,
        id: 'id02',
        rating: [
          Rating(userId: 'userId01', rating: 2.2),
        ]
    ),
    Product(
        name: 'Samsung Galaxy S23 Ultra 12GB 512GB',
        description: 'Samsung Galaxy S23 Ultra 12GB 512GB',
        quantity: 30,
        images: [
          'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/2/s23-ultra-xanh_2.png'
        ],
        category: 'Home',
        price: 30,
        id: 'id03',
        rating: [
          Rating(userId: 'userId01', rating: 3.3),
        ]
    ),
    Product(
        name: 'Xiaomi 14T (12GB 512GB)',
        description: 'Xiaomi 14T (12GB 512GB)',
        quantity: 40,
        images: [
          'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi_14t_2_.png'
        ],
        category: 'Mobiles',
        price: 40,
        id: 'id04',
        rating: [
          Rating(userId: 'userId01', rating: 4.4),
        ]
    ),
  ];

  static const List<Product> mockKeepShoppingForList = [
    Product(
        name: 'iPhone 16 Pro Max 256GB | Chính hãng VN/A',
        description: 'description01',
        quantity: 10,
        images: [
          'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-16-pro.png'
        ],
        category: 'Mobiles',
        price: 10),
    Product(
        name: 'Apple MacBook Air M1 256GB 2020 I Chính hãng Apple Việt Nam',
        description: 'description02',
        quantity: 20,
        images: [
          'https://cdn.tgdd.vn/Products/Images/44/231244/grey-1-750x500.jpg'
        ],
        category: 'Fashion',
        price: 20),
    Product(
        name: 'Áo phôn phong cách thời trang',
        description: 'Áo phôn phong cách thời trang',
        quantity: 30,
        images: [
          'https://t3.ftcdn.net/jpg/09/81/79/50/360_F_981795080_AT9LZMxnYMOR8a7ig8myHUqdy2wpVHtD.jpg'
        ],
        category: 'Home',
        price: 30),
    Product(
        name: 'Samsung Galaxy S24 Ultra 12GB 256GB',
        description: 'Samsung Galaxy S24 Ultra 12GB 256GB',
        quantity: 40,
        images: [
          'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-grey-thumbnew-600x600.jpg'
        ],
        category: 'Mobiles',
        price: 40),
  ];

  static const List<Product> mockWishList = [
    Product(
      name: 'iPhone 16 Pro Max 256GB | Chính hãng VN/A',
      description: 'description01',
      quantity: 10,
      images: [
        'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-16-pro.png'
      ],
      category: 'Mobiles',
      price: 10,
      id: 'id01',
    ),
    Product(
      name: 'iPhone 16 Pro Max 256GB | Chính hãng VN/A',
      description: 'description02',
      quantity: 20,
      images: [
        'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-16-pro.png'
      ],
      category: 'Fashion',
      price: 20,
      id: 'id01',
    ),
    Product(
      name: 'Samsung Galaxy S23 Ultra 12GB 512GB',
      description: 'Samsung Galaxy S23 Ultra 12GB 512GB',
      quantity: 30,
      images: [
        'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/2/s23-ultra-xanh_2.png'
      ],
      category: 'Home',
      price: 30,
      id: 'id01',
    ),
    Product(
      name: 'Xiaomi 14T (12GB 512GB)',
      description: 'Xiaomi 14T (12GB 512GB)',
      quantity: 40,
      images: [
        'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi_14t_2_.png'
      ],
      category: 'Mobiles',
      price: 40,
      id: 'id01',
    ),
  ];

  static Product mockProductDealOfDay = Product(
      name: 'Cell Phone IP14pro 2GB +16GB/SD128 GB',
      description: 'description01',
      quantity: 10,
      images: const [
        'https://images-na.ssl-images-amazon.com/images/I/61Fo5cwt0uL.jpg',
        'https://images-na.ssl-images-amazon.com/images/I/71mUk2mVV8L.jpg',
        'https://images-na.ssl-images-amazon.com/images/I/617afqYyrML.jpg',
        'https://images-na.ssl-images-amazon.com/images/I/61Jdsfw2I9L.jpg',
      ],
      category: 'Mobiles',
      price: 10,
      id: 'id01',
      rating: [
        Rating(userId: 'userId01', rating: 1.1),
      ]);

  static const mockFourImagesOffer = [
    FourImagesOffer(
      id: 'id01',
      title: 'Limited period offers on best-selling TVs | Starting ₹8,999',
      images: [
        'https://res.cloudinary.com/dthljz11q/image/upload/v1699881799/single_image_offers/ulrpitq6hf4rocgo0m8w.jpg',
        'https://images-na.ssl-images-amazon.com/images/I/61oepG5Y2FL.jpg',
        'https://images-na.ssl-images-amazon.com/images/I/61B8Lq5NXmL.jpg',
        'https://images-na.ssl-images-amazon.com/images/I/71RTruFctrL.jpg',
      ],
      labels: [
        'SAMSUNG 34" ViewFinity S50GC Series Ultrawide QHD Monitor, 100Hz, 5ms, HDR10, AMD FreeSync, Eye Care, Borderless Design, PIP, PBP, LS34C50DGANXZA, 2023, Black',
        'Sceptre 20" 1600x900 75Hz Ultra Thin LED Monitor 2x HDMI VGA Built-in Speakers, Machine Black Wide Viewing Angle 170° (Horizontal) / 160° (Vertical)',
        'Samsung 27" T35F Series FHD 1080p Computer Monitor, 75Hz, IPS Panel, HDMI, VGA (D-Sub), AMD FreeSync, Wall Mountable, Game Mode, 3-Sided Border-Less, Eye Care, LF27T350FHNXZA',
        'PHILIPS 22 inch Class Thin Full HD (1920 x 1080) Monitor, 100Hz Refresh Rate, VESA, HDMI x1, VGA x1, LowBlue Mode, Adaptive Sync, 4 Year Advance Replacement Warranty, 221V8LB',
      ],
      category: 'Electronics',
    ),
    FourImagesOffer(
      id: 'id02',
      title: 'Điện thoại chính hãng từ Mỹ',
      images: [
        'https://images-na.ssl-images-amazon.com/images/I/610qFsdenLL.jpg',
        'https://images-na.ssl-images-amazon.com/images/I/71qeTVe5d1L.jpg',
        'https://images-na.ssl-images-amazon.com/images/I/61xk4XNRktL.jpg',
        'https://images-na.ssl-images-amazon.com/images/I/61Jjxzg7Q1L.jpg',
      ],
      labels: [
        'OnePlus Nord N30 5G | Unlocked Dual-SIM Android Smart Phone | 6.7" LCD Display | 8 +128GB | 5000 mAh Battery | 50W Fast Charging | 108MP Camera | Chromatic Gray',
        'Samsung Galaxy S24 Ultra Cell Phone, 256GB AI Smartphone, Unlocked Android, 200MP, 100x Zoom Cameras, Fast Processor, Long Battery Life, Edge-to-Edge Display, S Pen, US Version, 2024, Titanium Violet',
        'Moto G Play | 2024 | Unlocked | Made for US 4/64GB | 50MP Camera | Sapphire Blue',
        'SAMSUNG Galaxy Z Fold 6 AI Cell Phone, 512GB Unlocked Android Smartphone, Circle to Search, Handsfree Live Interpreter, AI Photo Edits, Large Screen, 2024,US 1 Yr Manufacturer Warranty, Silver Shadow',
      ],
      category: 'Mobiles',
    ),
    FourImagesOffer(
      id: 'id03',
      title: 'Buy 2 Get 10% off, freebies & more offers',
      images: [
        'https://res.cloudinary.com/dthljz11q/image/upload/v1699881798/single_image_offers/u0ozqtcnhnl1eqoht85j.jpg',
        'https://images-na.ssl-images-amazon.com/images/I/71ojt5LDKhL.jpg',
        'https://images-na.ssl-images-amazon.com/images/I/71pu3P-qDmL.jpg',
        'https://images-na.ssl-images-amazon.com/images/I/919aLPXSUyL.jpg',
      ],
      labels: [
        'Fossil Women\'s Rachel Satchel Purse Handbag',
        'Tease Eau de Parfum, Women\'s Perfume, Notes of White Gardenia, Anjou Pear, Black Vanilla, Tease Collection (3.4 oz)',
        'New Mom Gifts & Baby Girl Gifts, Baby Shower Gifts for Mom to Be, Pregnancy Gifts for Expecting Mom, First Time Mothers Day Gift for New Mom, Pregnancy Gifts for Women and Baby',
        'OUKITEL G1 Rugged Smartphone Unlocked - 24+256GB/1TB Android 14 Rugged Cellphones, 6.52” HD Display IP68/IP69K 10600mAh Battery 48MP Rear Camera Waterproof Phone, Fingerprint/Dual Sim/NFC 2024',
      ],
      category: 'Home',
    ),
    FourImagesOffer(
      id: 'id04',
      title: 'Price crash | Amazon Brands & more',
      images: [
        'https://res.cloudinary.com/dthljz11q/image/upload/v1699881800/single_image_offers/kwfypkjyfqjsipniefav.png',
        'https://images-na.ssl-images-amazon.com/images/I/813NFB0AOJL.jpg',
        'https://images-na.ssl-images-amazon.com/images/I/710U89BdbCL.jpg',
        'https://images-na.ssl-images-amazon.com/images/I/718sQIBDZoL.jpg',
        'https://images-na.ssl-images-amazon.com/images/I/61gwIjTdeFL.jpg',
      ],
      labels: [
        'Under ₹499 | T-shirts & shirts',
        'COOFANDY Mens Hoodies Pullover Casaul Long Sleeve Drawstring Waffle Knit Hooded Sweatshirt with Kanga Pocket',
        'Men\'s Afterburn M. Fit',
        'GOLDEN HOUR Mens Watch Fashion Sleek Minimalist Quartz Analog Mesh Stainless Steel Waterproof Chronograph Watches for Men with Auto Date',
        'Mens Sunglasses Fashion Rimless Rectangle Sunglasses Square Frameless Sunglasses for Men',
      ],
      category: 'Fashion',
    ),
  ];

  static const mockCategoryProducts = [
    Product(
      name: 'Điện thoại OPPO Reno11 Pro 5G 12GB/512GB',
      description: 'Điện thoại OPPO Reno11 Pro 5G 12GB/512GB',
      quantity: 1,
      images: [
        'https://cdn.tgdd.vn/Products/Images/42/314210/oppo-reno-11-pro-trang-thumb-600x600.jpg'
      ],
      category: 'Mobiles',
      price: 40,
      id: 'id01',
    ),
    Product(
      name: 'Điện thoại Xiaomi 14 5G 12GB/512GB',
      description: 'Điện thoại Xiaomi 14 5G 12GB/512GB',
      quantity: 1,
      images: [
        'https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-green-thumbnew-600x600.jpg'
      ],
      category: 'Mobiles',
      price: 40,
      id: 'id02',
    ),
    Product(
      name: 'Điện thoại Samsung Galaxy S24 Ultra 5G 12GB/256GB',
      description: 'Điện thoại Samsung Galaxy S24 Ultra 5G 12GB/256GB',
      quantity: 1,
      images: [
        'https://cdn.tgdd.vn/Products/Images/42/307174/samsung-galaxy-s24-ultra-grey-thumbnew-600x600.jpg'
      ],
      category: 'Mobiles',
      price: 40,
      id: 'id03',
    ),
    Product(
      name: 'Điện thoại Samsung Galaxy S23 Ultra 5G 8GB/256GB',
      description: 'Điện thoại Samsung Galaxy S23 Ultra 5G 8GB/256GB',
      quantity: 1,
      images: [
        'https://cdn.tgdd.vn/Products/Images/42/249948/samsung-galaxy-s23-ultra-thumb-den-600x600.jpg'
      ],
      category: 'Mobiles',
      price: 40,
      id: 'id04',
    ),
    Product(
      name: 'Điện thoại Xiaomi 14 Ultra 5G 16GB/512GB',
      description: 'Điện thoại Xiaomi 14 Ultra 5G 16GB/512GB',
      quantity: 1,
      images: [
        'https://cdn.tgdd.vn/Products/Images/42/313889/xiaomi-14-ultra-white-thumbnew-600x600.jpg'
      ],
      category: 'Mobiles',
      price: 40,
      id: 'id05',
    ),
    Product(
      name: 'Váy trong bộ Vest-Váy, 23AVJE030X',
      description: 'Váy trong bộ Vest-Váy, 23AVJE030X',
      quantity: 1,
      images: [
        'https://product.hstatic.net/200000000133/product/23avae030x_-_23ssme012t_-_23avje030x_3_889144b23ead4dc1b57ba49326279fa8_master.jpg'
      ],
      category: 'Fashion',
      price: 40,
      id: 'id06',
    ),
    Product(
      name: 'Đầm trễ vai, 24ADKE122O',
      description: 'Đầm trễ vai, 24ADKE122O',
      quantity: 1,
      images: [
        'https://product.hstatic.net/200000000133/product/24adke122o.3_7dca8c85077141ca8c6a0ae94afb51d1_master.jpg'
      ],
      category: 'Fashion',
      price: 40,
      id: 'id07',
    ),
    Product(
      name: 'Đầm tay dài, Dáng ôm 24ADKE184D',
      description: 'Đầm tay dài, Dáng ôm 24ADKE184D',
      quantity: 1,
      images: [
        'https://product.hstatic.net/200000000133/product/24adke184d.3_7b0ab59624ce4898b62fc97d4966135f_master.jpg'
      ],
      category: 'Fashion',
      price: 40,
      id: 'id08',
    ),
    Product(
      name: 'Màn hình Gaming Asus VY279HGR 27 inch FHD/IPS/120Hz/1ms',
      description: 'Màn hình Gaming Asus VY279HGR 27 inch FHD/IPS/120Hz/1ms',
      quantity: 1,
      images: [
        'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/5697/332008/asus-vy279hgr-27-inch-fhd-ips-120hz-1ms-den-1-638670213596872244-700x467.jpg'
      ],
      category: 'Electronics',
      price: 40,
      id: 'id09',
    ),
    Product(
      name: 'Màn hình Dell P2425H 23.8 inch FHD/IPS/100Hz/5ms',
      description: 'Màn hình Dell P2425H 23.8 inch FHD/IPS/100Hz/5ms',
      quantity: 1,
      images: [
        'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/5697/331654/dell-p2725h-23-8-inch-fhd-ips-100hz-5ms-1-638660735808252222-750x500.jpg'
      ],
      category: 'Electronics',
      price: 40,
      id: 'id09',
    ),
    Product(
      name: 'Màn hình Dell P2425H 23.8 inch FHD/IPS/100Hz/5ms',
      description: 'Màn hình Dell P2425H 23.8 inch FHD/IPS/100Hz/5ms',
      quantity: 1,
      images: [
        'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/5697/331654/dell-p2725h-23-8-inch-fhd-ips-100hz-5ms-1-638660735808252222-750x500.jpg'
      ],
      category: 'Home',
      price: 40,
      id: 'id09',
    ),
    Product(
      name: 'Màn hình Dell P2425H 23.8 inch FHD/IPS/100Hz/5ms',
      description: 'Màn hình Dell P2425H 23.8 inch FHD/IPS/100Hz/5ms',
      quantity: 1,
      images: [
        'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/5697/331654/dell-p2725h-23-8-inch-fhd-ips-100hz-5ms-1-638660735808252222-750x500.jpg'
      ],
      category: 'Beauty',
      price: 40,
      id: 'id09',
    ),
    Product(
      name: 'Màn hình Dell P2425H 23.8 inch FHD/IPS/100Hz/5ms',
      description: 'Màn hình Dell P2425H 23.8 inch FHD/IPS/100Hz/5ms',
      quantity: 1,
      images: [
        'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/5697/331654/dell-p2725h-23-8-inch-fhd-ips-100hz-5ms-1-638660735808252222-750x500.jpg'
      ],
      category: 'Appliances',
      price: 40,
      id: 'id09',
    ),
    Product(
      name: 'Màn hình Dell P2425H 23.8 inch FHD/IPS/100Hz/5ms',
      description: 'Màn hình Dell P2425H 23.8 inch FHD/IPS/100Hz/5ms',
      quantity: 1,
      images: [
        'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/5697/331654/dell-p2725h-23-8-inch-fhd-ips-100hz-5ms-1-638660735808252222-750x500.jpg'
      ],
      category: 'Grocery',
      price: 40,
      id: 'id09',
    ),
    Product(
      name: 'Đắc Nhân Tâm',
      description: 'Đắc Nhân Tâm',
      quantity: 1,
      images: [
        'https://salabookz.com/wp-content/uploads/2022/03/dac-nhan-tam-510x510.jpg'
      ],
      category: 'Books',
      price: 40,
      id: 'id09',
    ),
    Product(
      name: 'Đắc Nhân Tâm',
      description: 'Đắc Nhân Tâm',
      quantity: 1,
      images: [
        'https://salabookz.com/wp-content/uploads/2022/03/dac-nhan-tam-510x510.jpg'
      ],
      category: 'Essentials',
      price: 40,
      id: 'id09',
    ),
    Product(
      name: 'Đắc Nhân Tâm',
      description: 'Đắc Nhân Tâm',
      quantity: 1,
      images: [
        'https://salabookz.com/wp-content/uploads/2022/03/dac-nhan-tam-510x510.jpg'
      ],
      category: 'Category',
      price: 40,
      id: 'id09',
    ),
  ];

  static Order mockOrder = const Order(
      id: 'id01',
      products: [
        Product(
          name: 'Màn hình Dell P2425H 23.8 inch FHD/IPS/100Hz/5ms',
          description: 'Màn hình Dell P2425H 23.8 inch FHD/IPS/100Hz/5ms',
          quantity: 1,
          images: [
            'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/5697/331654/dell-p2725h-23-8-inch-fhd-ips-100hz-5ms-1-638660735808252222-750x500.jpg'
          ],
          category: 'Grocery',
          price: 40,
          id: 'id09',
        ),
      ],
      quantity: [2],
      address: 'address order 1',
      userId: 'userId01',
      orderedAt: 1,
      status: 1,
      totalPrice: 40);

  static const mockSearchOrders = [
    Order(
        id: 'id01',
        products: [
          Product(
            name: 'Màn hình Dell P2425H 23.8 inch FHD/IPS/100Hz/5ms',
            description: 'Màn hình Dell P2425H 23.8 inch FHD/IPS/100Hz/5ms',
            quantity: 1,
            images: [
              'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/5697/331654/dell-p2725h-23-8-inch-fhd-ips-100hz-5ms-1-638660735808252222-750x500.jpg'
            ],
            category: 'Grocery',
            price: 40,
            id: 'id09',
          ),
        ],
        quantity: [2],
        address: 'address order 1',
        userId: 'userId01',
        orderedAt: 1,
        status: 1,
        totalPrice: 40
    ),
    Order(
        id: 'id02',
        products: [
          Product(
            name: 'Điện thoại Xiaomi 14 5G 12GB/512GB',
            description: 'Điện thoại Xiaomi 14 5G 12GB/512GB',
            quantity: 1,
            images: [
              'https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-green-thumbnew-600x600.jpg'
            ],
            category: 'Mobiles',
            price: 40,
            id: 'id02',
          ),
        ],
        quantity: [2],
        address: 'address order 1',
        userId: 'userId01',
        orderedAt: 1,
        status: 1,
        totalPrice: 40
    ),
  ];

  static const mockAnalytics = [
    Sales('Mobiles', 10),
    Sales('Fashion', 20),
    Sales('Electronics', 30),
    Sales('Home', 5),
    Sales('Beauty', 1),
    Sales('Appliances', 0),
    Sales('Grocery', 10),
    Sales('Books', 3),
    Sales('Essentials', 20),
  ];
}

List<SingleImageOffer> mockSingleImageOffers = const [
  SingleImageOffer(
    title: 'Limited period offers on best-selling TVs | Starting ₹8,999',
    subTitle: 'Up to 18 months No Cost EMI',
    image:
        'https://res.cloudinary.com/dthljz11q/image/upload/v1699881799/single_image_offers/ulrpitq6hf4rocgo0m8w.jpg',
    category: 'Electronics',
  ),
  SingleImageOffer(
    title: 'Top deals on headsets',
    subTitle: 'Up to 80% off',
    image:
        'https://res.cloudinary.com/dthljz11q/image/upload/v1699881798/single_image_offers/x5gqgg5ynbjkslyvefpk.jpg',
    category: 'Mobiles',
  ),
  SingleImageOffer(
    title: 'Buy 2 Get 10% off, freebies & more offers',
    subTitle: 'See all offers',
    image:
        'https://res.cloudinary.com/dthljz11q/image/upload/v1699881798/single_image_offers/u0ozqtcnhnl1eqoht85j.jpg',
    category: 'Home',
  ),
  SingleImageOffer(
    title: 'Price crash | Amazon Brands & more',
    subTitle: 'Under ₹499 | T-shirts & shirts',
    image:
        'https://res.cloudinary.com/dthljz11q/image/upload/v1699881800/single_image_offers/kwfypkjyfqjsipniefav.png',
    category: 'Fashion',
  ),
  SingleImageOffer(
    title: 'Amazon coupons | Smartphones & accessories',
    subTitle: 'Extra up to ₹2000 off with coupons',
    image:
        'https://res.cloudinary.com/dthljz11q/image/upload/v1699881799/single_image_offers/rmtbk89pmenhd3mulcus.jpg',
    category: 'Mobiles',
  ),
];
