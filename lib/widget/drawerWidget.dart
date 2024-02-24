
import 'package:atompaymentdemo/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class drawerWidget extends StatelessWidget {
  const drawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      elevation: 0,
      child: Column(
        children: [
          Container(
        
            padding: const EdgeInsets.all(20),
            // color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                children: [
                  Container(
                
                    height: 100,
                    margin: const EdgeInsets.only(top: 30, bottom: 20),
                    decoration: const BoxDecoration(
                      // shape: BoxShape.circle,
                      image: DecorationImage(
                        
                        alignment: Alignment.center,
                          image: AssetImage("assets/images/drawerok.png"),
                         ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.addressCard,),
            title: const Text("About Us"),
            onTap: () {
     context.router.push(AboutServicePage(index: 0));
            },
          ),
          ListTile(
            leading: const Icon(Icons.miscellaneous_services,),
            title: const Text("Services"),
            onTap: () {
                   context.router.push(AboutServicePage(index: 1));
            },
          ),
          ListTile(
            leading: const Icon(Icons.library_books_outlined,),
            title: const Text("Publication"),
            onTap: () {
                   context.router.push(AboutServicePage(index: 2));
            },
          ),
                    ListTile(
            leading: const Icon(Icons.price_change_outlined,),
            title: const Text("Price"),
            onTap: () {
                   context.router.push(AboutServicePage(index: 3));
            },
          ),
                    ListTile(
            leading:  const Icon(FontAwesomeIcons.personCircleQuestion,),
            title: const Text("Who's Who"),
            onTap: () {
                     context.router.push(WhoiswhoPage(index: 4));
            },
          ),
                    ListTile(
            leading: const Icon(Icons.contact_emergency,),
            title: const Text("Contact"),
            onTap: () {
                          context.router.push(ContactPage());
            },
          ),
        ],
      ),
    );
  }
}





//!

