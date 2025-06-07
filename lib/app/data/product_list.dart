import 'package:damishop/app/core/images.dart';
import 'package:damishop/app/models/product_model.dart';

final List<ProductModel> sampleProducts = [
  ProductModel(
    category: 'Technology',
    subCategory: 'Smartphones',
    id: '1',
    name: 'Apple iPhone 16 128GB | Teal',
    description:
        'This pre-owned product is not Apple certified, but has been professionally inspected, tested and cleaned by Amazon-qualified suppliers.',
    imagePath: AppImages.iphone,
    price: 700.00,
  ),
  ProductModel(
    category: 'Technology',
    subCategory: 'Laptops',
    id: '2',
    name: 'M4 MacBook Air 13” 256GB | Sky Blue',
    description:
        'Apple M4 chip with 8-core CPU, 10-core GPU, and 16-core Neural Engine.',
    imagePath: AppImages.macBook, // Replace with a real MacBook image
    price: 1000.00,
  ),
  ProductModel(
    category: 'Technology',
    subCategory: 'Smartphones',
    id: '3',
    name: 'Google Pixel 9A 128GB | Iris',
    description: 'The Google Pixel 9A comes with pure Android experience.',
    imagePath: AppImages.googlePixels,
    price: 499.00,
  ),
  ProductModel(
    category: 'Technology',
    subCategory: 'Accessories',
    id: '4',
    name: 'Apple AirPods 4 | Active Noise Cancellation',
    description: 'Latest AirPods with improved ANC and adaptive transparency.',
    imagePath: AppImages.airpods, // Replace with real AirPods image
    price: 129.00,
  ),
];
