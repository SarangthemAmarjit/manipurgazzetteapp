
import 'package:atompaymentdemo/constant/constant.dart';
import 'package:atompaymentdemo/controller/tapcontroller.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

@RoutePage()
class BillingPage extends StatelessWidget {
  BillingPage({super.key});

//POSTAL ADRRESS
  TextEditingController postalnamecontroller = TextEditingController();
  TextEditingController postaladdresscontroller = TextEditingController();
  TextEditingController postalpincodecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GetxTapController controller = Get.put(GetxTapController(context: context));
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding:  const EdgeInsets.only(left: 10, top: 10, bottom: 5),
          child: Image.asset(
            'assets/images/kanglasa.png',
          ),
        ),
        backgroundColor: Colors.white,
        title:  const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Manipur e-Gazette',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )
          ],
        ),
      ),
      body: GetBuilder<GetxTapController>(builder: (_) {
        return Obx(
           () => controller.isDataLoading.value
              ?  const Center(child: CircularProgressIndicator())
              :SingleChildScrollView(
            physics:  const BouncingScrollPhysics(),
            child: SafeArea(
                child: Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                   const SizedBox(
                    height: 30,
                  ),
                   const Center(
                    child: Text(
                      'Billing Details',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          letterSpacing: 3,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                   const SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:  const Color.fromARGB(255, 190, 213, 231)
                          .withOpacity(0.7),
                    ),
                    child:  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Text(
                        'ESTIMATED PRICE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          letterSpacing: 3,
                        ),
                      ),
                    ),
                  ),
                   const SizedBox(
                    height: 5,
                  ),
                   const Text('for Gazette'),
                   const SizedBox(
                    height: 5,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style:  const TextStyle(fontFamily: 'KulimPark'),
                      children: [
                        // First letter with blue color
                         const TextSpan(
                          text: ' " ',
                          style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
          
                        // Main text with default color
                        TextSpan(
                          text:
                              controller.gazettedetails.title,
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.blue[800]),
                        ),
          
                        // Last letter with blue color
                         const TextSpan(
                          text: ' "',
                          style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
          
                  RichText(
                    textHeightBehavior:  const TextHeightBehavior(
                      applyHeightToLastDescent: true,
                    ),
                    textAlign: TextAlign.center,
                    text:  TextSpan(
                      style: const TextStyle(fontFamily: 'KulimPark'),
                      children: [
                        // First letter with blue color
                        const TextSpan(
                          text: 'Date of Notification: ',
                          style: TextStyle(color: Colors.black, height: 3),
                        ),
                        TextSpan(
                          text: '${controller.gazettedetails.notificationdate.day}-${month[controller.gazettedetails.notificationdate.month]}-${controller.gazettedetails.notificationdate.year}    ',
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                        ),
          
                        // Main text with default color
                        const TextSpan(
                          text: 'Date of publication: ',
                          style: TextStyle(color: Colors.black),
                        ),
                         TextSpan(
                          text: '${controller.gazettedetails.publicationdate.day}-${month[controller.gazettedetails.publicationdate.month]}-${controller.gazettedetails.publicationdate.year}    ',
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                        ),
          
                        // Last letter with blue color
                        const TextSpan(
                          text: 'Gazette Type: ',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                         TextSpan(
                          text: controller.gazettedetails.gazettetype,
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                   const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style:  const TextStyle(fontFamily: 'KulimPark'),
                      children: [
                        // First letter with blue color
                         const TextSpan(
                          text: '₹ ',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
          
                        // Main text with default color
                        TextSpan(
                          text: '${controller.gazettedetails.price}',
                          style: TextStyle(color: Colors.blue[800]),
                        ),
          
                        // Last letter with blue color
                         const TextSpan(
                          text: ' /-',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                   const SizedBox(
                    height: 20,
                  ),
          
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         const Text(
                          'Postal Address',
                          style: TextStyle(fontSize: 18),
                        ),
                         const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                             const Expanded(
                                flex: 2,
                                child: Text(
                                  'Full Name',
                                  style: TextStyle(fontSize: 16),
                                )),
                            Expanded(
                              flex: 8,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                                elevation: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:  const Color.fromARGB(
                                          255, 253, 253, 252),
                                      borderRadius: BorderRadius.circular(3)),
                                  height: 43,
                                  child: TextFormField(
                                    controller: postalnamecontroller,
                                    keyboardType: TextInputType.name,
                                    onChanged: ((value) {}),
                                    decoration: InputDecoration(
                                        contentPadding:  const EdgeInsets.only(
                                            top: 7, left: 17),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        hintText: '',
                                        hintStyle:
                                             const TextStyle(color: Colors.grey)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                             const Expanded(
                                flex: 2,
                                child: Text(
                                  'Postal Address',
                                  style: TextStyle(fontSize: 16),
                                )),
                            Expanded(
                              flex: 8,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                                elevation: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:  const Color.fromARGB(
                                          255, 253, 253, 252),
                                      borderRadius: BorderRadius.circular(3)),
                                  height: 43,
                                  child: TextFormField(
                                    controller: postaladdresscontroller,
                                    keyboardType: TextInputType.streetAddress,
                                    onChanged: ((value) {}),
                                    decoration: InputDecoration(
                                        contentPadding:  const EdgeInsets.only(
                                            top: 7, left: 17),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        hintText: '',
                                        hintStyle:
                                             const TextStyle(color: Colors.grey)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                             const Expanded(
                                flex: 2,
                                child: Text(
                                  'District',
                                  style: TextStyle(fontSize: 16),
                                )),
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding:
                                     const EdgeInsets.symmetric(horizontal: 4),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding:
                                       const EdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(color: Colors.grey)),
                                  child: DropdownSearch<String>(
                                    onChanged: (value) {
                                      controller.getpostaldropdownvalue(
                                          value: value!);
                                    },
                                    popupProps: PopupProps.menu(
                                      searchFieldProps:  const TextFieldProps(
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              constraints:
                                                  BoxConstraints(maxHeight: 30))),
                                      constraints: BoxConstraints.tight(Size(
                                          MediaQuery.of(context).size.width,
                                          160)),
                                      showSearchBox: true,
                                      showSelectedItems: true,
                                    ),
                                    items: districts,
                                    dropdownDecoratorProps:
                                         const DropDownDecoratorProps(
                                      textAlign: TextAlign.left,
                                      textAlignVertical: TextAlignVertical.top,
                                      dropdownSearchDecoration: InputDecoration(
                                        constraints:
                                            BoxConstraints(maxHeight: 43),
          
                                        // labelText:
                                        //     "Gazette Type :",
                                        hintText: "--Select District--",
                                      ),
                                    ),
                                    // onChanged: (String? newValue) {
                                    //   setState(() {
                                    //     dropdownvalue1 = newValue as String;
                                    //   });
                                    //   int ind = all_des.indexOf(dropdownvalue1!);
                                    //   dropdownvalue11 = all_desid[ind];
                                    // },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                             const Expanded(
                                flex: 2,
                                child: Text(
                                  'Pin Code',
                                  style: TextStyle(fontSize: 16),
                                )),
                            Expanded(
                              flex: 8,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                                elevation: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:  const Color.fromARGB(
                                          255, 253, 253, 252),
                                      borderRadius: BorderRadius.circular(3)),
                                  height: 43,
                                  child: TextFormField(
                                    controller: postalpincodecontroller,
                                    keyboardType: TextInputType.number,
                                    onChanged: ((value) {}),
                                    decoration: InputDecoration(
                                        contentPadding:  const EdgeInsets.only(
                                            top: 7, left: 17),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        hintText: '',
                                        hintStyle:
                                             const TextStyle(color: Colors.grey)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                         const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                              child: Checkbox(
                                value: controller.ischecked,
                                onChanged: (bool? value) {
                                  controller.setcheckbox(
                                      value: value!,
                                      name: postalnamecontroller.text,
                                      address: postaladdresscontroller.text,
                                      pincode: postalpincodecontroller.text);
                                },
                              ),
                            ),
                             const SizedBox(
                              width: 15,
                            ),
                             const Text(
                              'Same as Billing Address',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                   const SizedBox(
                    height: 10,
                  ),
          
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         const Text(
                          'Billing Address',
                          style: TextStyle(fontSize: 18),
                        ),
                         const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                             const Expanded(
                                flex: 2,
                                child: Text(
                                  'Full Name',
                                  style: TextStyle(fontSize: 16),
                                )),
                            Expanded(
                              flex: 8,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                                elevation: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:  const Color.fromARGB(
                                          255, 253, 253, 252),
                                      borderRadius: BorderRadius.circular(3)),
                                  height: 43,
                                  child: TextFormField(
                                    controller: controller.billingnamecontroller,
                                    onChanged: ((value) {}),
                                    decoration: InputDecoration(
                                        contentPadding:  const EdgeInsets.only(
                                            top: 7, left: 17),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        hintText: '',
                                        hintStyle:
                                             const TextStyle(color: Colors.grey)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                             const Expanded(
                                flex: 2,
                                child: Text(
                                  'Postal Address',
                                  style: TextStyle(fontSize: 16),
                                )),
                            Expanded(
                              flex: 8,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                                elevation: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:  const Color.fromARGB(
                                          255, 253, 253, 252),
                                      borderRadius: BorderRadius.circular(3)),
                                  height: 43,
                                  child: TextFormField(
                                    controller:
                                        controller.billingaddresscontroller,
                                    onChanged: ((value) {}),
                                    decoration: InputDecoration(
                                        contentPadding:  const EdgeInsets.only(
                                            top: 7, left: 17),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        hintText: '',
                                        hintStyle:
                                             const TextStyle(color: Colors.grey)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                             const Expanded(
                                flex: 2,
                                child: Text(
                                  'District',
                                  style: TextStyle(fontSize: 16),
                                )),
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding:
                                     const EdgeInsets.symmetric(horizontal: 4),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding:
                                       const EdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(color: Colors.grey)),
                                  child: DropdownSearch<String>(
                                    selectedItem: controller.billingdropdownvalue.isEmpty? null:controller.billingdropdownvalue,
                                    popupProps: PopupProps.menu(
                                      searchFieldProps:  const TextFieldProps(
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              constraints:
                                                  BoxConstraints(maxHeight: 30))),
                                      constraints: BoxConstraints.tight(Size(
                                          MediaQuery.of(context).size.width,
                                          160)),
                                      showSearchBox: true,
                                      showSelectedItems: true,
                                    ),
                                    items: districts,
                                    dropdownDecoratorProps:
                                         const DropDownDecoratorProps(
                                      textAlign: TextAlign.left,
                                      textAlignVertical: TextAlignVertical.top,
                                      dropdownSearchDecoration: InputDecoration(
                                        constraints:
                                            BoxConstraints(maxHeight: 43),
          
                                        // labelText:
                                        //     "Gazette Type :",
                                        hintText: "--Select District--",
                                      ),
                                    ),
                                    // onChanged: (String? newValue) {
                                    //   setState(() {
                                    //     dropdownvalue1 = newValue as String;
                                    //   });
                                    //   int ind = all_des.indexOf(dropdownvalue1!);
                                    //   dropdownvalue11 = all_desid[ind];
                                    // },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                             const Expanded(
                                flex: 2,
                                child: Text(
                                  'Pin Code',
                                  style: TextStyle(fontSize: 16),
                                )),
                            Expanded(
                              flex: 8,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                                elevation: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:  const Color.fromARGB(
                                          255, 253, 253, 252),
                                      borderRadius: BorderRadius.circular(3)),
                                  height: 43,
                                  child: TextFormField(
                                    controller:
                                        controller.billingpincodecontroller,
                                    onChanged: ((value) {}),
                                    decoration: InputDecoration(
                                        contentPadding:  const EdgeInsets.only(
                                            top: 7, left: 17),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        hintText: '',
                                        hintStyle:
                                             const TextStyle(color: Colors.grey)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                   const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      // context.router.push( SearchPage());
                    },
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        elevation: 10,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5)),
                          height: 50,
                          child:  const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Proceed To Payment',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        )
          
                        // ElevatedButton(
                        //     onPressed: () {},
                        //     child:  Padding(
                        //       padding: EdgeInsets.symmetric(vertical: 10),
                        //       child: Text('Search Gazette'),
                        //     )),
                        ),
                  ),
                   const SizedBox(
                    height: 30,
                  ),
          
                  //  Center(child: Text('  " No. ARREV-103/1/2021-REV-REVENUE-As applicable to whole of Manipur, Governor of Manipur makes following rules to amend existing Manipur (Payment of Duty by means of e-stamping) Rules 2021 "  ',textAlign: TextAlign.center,style: TextStyle(color: Colors.blue,fontStyle: FontStyle.italic)))
                ],
              ),
            )),
          ),
        );
      }),
    );
  }
}
