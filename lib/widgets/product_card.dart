import 'package:projetagro/models/product.dart';
import 'package:projetagro/pages/product_details_page.dart';
import 'package:flutter/material.dart';
class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsPage(product: product),
        ));
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 15,
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10),),
            side: BorderSide(
              width: 0.2,
              color: Colors.grey.shade900,
            )


        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 130,
              alignment: Alignment.topRight,
              padding: const EdgeInsets.all(9),
              width: double.infinity,
              decoration:  BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    product.image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: SizedBox(
                width: 30,
                height: 30,
                child: IconButton.filledTonal(
                  padding: EdgeInsets.zero,
                  onPressed: (){},
                  iconSize: 18,
                  icon: const Icon(Icons.favorite),
                ),
              ),

            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child:  Text(
                      product.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "\ ${(product.price)} Ar ",
                                style: Theme.of(context).textTheme.bodyLarge
                            ),
                            TextSpan(
                                text: "/${(product.unit)}",
                                style: Theme.of(context).textTheme.bodySmall
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: 30,
                        height: 30,
                        child: IconButton.filled(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
