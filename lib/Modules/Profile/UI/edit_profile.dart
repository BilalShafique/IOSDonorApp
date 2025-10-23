import 'package:donor_app/Modules/Dashboard/Model/home_model.dart';
import 'package:donor_app/Modules/Dashboard/Utils/home_helper.dart';
import 'package:donor_app/Modules/Profile/Model/donor_profile_model.dart';
import 'package:donor_app/Modules/Profile/Utils/donor_profileDataHelper.dart';
import 'package:donor_app/Shared/UI/custom_color_scheme.dart';
import 'package:donor_app/Shared/Utils/ddlLists.dart';
import 'package:donor_app/Shared/Utils/general_alert.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  DonorInfo? donorinfo;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController designtionController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  List<Country> listofCountry = [];
  List<GeoRegion> listofGeoRegion = [];
  List<Sector> listofSector = [];
  List<City> listofCity = [];
  List<XFile> image = [];
  List<PlatformFile> selectedfiles = [];
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    fetchCountry().then((response) {
      if (response != null) {
        setState(() {
          listofCountry = response;
        });
      }
    });
    fetchGeoRegion().then((response) {
      if (response != null) {
        setState(() {
          listofGeoRegion = response;
        });
      }
    });
    fetchSector().then((response) {
      if (response != null) {
        setState(() {
          listofSector = response;
        });
      }
    });

    getDonorInfo().then((response) {
      setState(() {
        donorinfo = response!;
        nameController.text = donorinfo!.name;
        emailController.text = donorinfo!.email;
        phoneController.text = donorinfo!.phone;
        designtionController.text = donorinfo!.designation;
        organizationController.text = donorinfo!.organization;
        fetchCity(donorinfo!.donor_country_id).then((response) {
          if (response != null) {
            setState(() {
              listofCity = response!;
            });
          }
        });
      });
    });
  }

  void _uploadImage() async {
    Navigator.pop(context);

    final picker = ImagePicker();

    var pickedImage = await picker.pickMultiImage();

    setState(() {
      if (pickedImage != null) {
        for (int i = 0; i < pickedImage.length; i++) {
          image.add(pickedImage[i]);
        }
      }
    });
  }

  void _takeCameraImage() async {
    Navigator.pop(context);
    final picker = ImagePicker();

    var pickedImage = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedImage != null) {
        image.add(pickedImage);
      }
    });
  }

  void _chooseFile() async {
    Navigator.pop(context);
    FilePickerResult? chooseFile = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );

    setState(() {
      if (chooseFile != null) {
        for (int i = 0; i < chooseFile.files.length; i++) {
          selectedfiles.add(chooseFile.files[i]);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Update Profile",
            style: TextStyle(
              color: Colors.white, // Text color
            ),
          ),
          // Back button (default or manually added)
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white, // Back button color
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/fundAppbar.jpg'), // Your image asset path
                fit: BoxFit.cover, // Make the image cover the entire AppBar
              ),
            ),
          ),
        ),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showAttachemnts(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[200], // Light background color
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey, // Border color
                            width: 1.5,
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.file_upload, // Upload icon
                              color: Colors.green, // Icon color
                            ),
                            SizedBox(width: 8), // Spacing between icon and text
                            Text(
                              "Upload Profile",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black, // Text color
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Name",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        String pattern = r"^[a-zA-Z\s]+$";
                        RegExp regex = RegExp(pattern);

                        /* if (value!.isEmpty) {
                          return 'Name is required';
                        } else if (value.length > 60) {
                          return 'Maximum 35 characters allowed';
                        } else if (!regex.hasMatch(value)) {
                          return 'Invalid name (letters and spaces only)';
                        } */
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          donorinfo?.name = value;
                        });
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true, // Enables the background fill
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        hintText: 'Enter Donor name here..',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 10.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Email ID",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        String pattern =
                            r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                        RegExp regex = RegExp(pattern);

                        if (value!.isEmpty) {
                          return 'Email Address is required';
                        } else if (value.length > 35) {
                          return 'Maximum up 35 characters';
                        } else if (!regex.hasMatch(value)) {
                          return 'Invalid email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          donorinfo?.email = value;
                        });
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true, // Enables the background fill
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        hintText: 'example@nust.com',
                        hintStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Phone No.",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        //String pattern = r"^\+?[0-9]{7,15}$";
                        //RegExp regex = RegExp(pattern);

                        if (value!.isEmpty) {
                          return 'Phone number is required';
                        } /* else if (!regex.hasMatch(value)) {
                          return 'Invalid phone number';
                        } */
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          donorinfo?.phone = value;
                        });
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true, // Enables the background fill
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        hintText: 'Enter phone number',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 10.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Designation",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    TextFormField(
                      controller: designtionController,
                      validator: (value) {
                        String pattern = r"^[a-zA-Z\s]+$";
                        RegExp regex = RegExp(pattern);

                        if (value!.isEmpty) {
                          return 'Designation is required';
                        } else if (value.length > 35) {
                          return 'Maximum 35 characters allowed';
                        } else if (!regex.hasMatch(value)) {
                          return 'Invalid Designation (letters and spaces only)';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          donorinfo?.designation = value;
                        });
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true, // Enables the background fill
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        hintText: 'Enter Designation here..',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 10.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Organization",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    TextFormField(
                      controller: organizationController,
                      validator: (value) {
                        String pattern = r"^[a-zA-Z\s]+$";
                        RegExp regex = RegExp(pattern);

                        if (value!.isEmpty) {
                          return 'Organization is required';
                        } else if (value.length > 35) {
                          return 'Maximum 35 characters allowed';
                        } else if (!regex.hasMatch(value)) {
                          return 'Invalid Organization (letters and spaces only)';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          donorinfo?.organization = value;
                        });
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true, // Enables the background fill
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        hintText: 'Enter Organization here..',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 10.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Country",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    DropdownButtonFormField(
                        isExpanded: true,
                        iconEnabledColor: Theme.of(context).iconTheme.color,
                        hint: const Text("Select One"),
                        /*    value: (donorinfo?.donor_country_id == 0 ||
                                donorinfo?.donor_country_id == null)
                            ? null
                            : donorinfo?.donor_country_id, */
                        initialValue: listofCountry.any((c) =>
                                c.country_id == donorinfo?.donor_country_id)
                            ? donorinfo?.donor_country_id
                            : null,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(17),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(5.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                        items: listofCountry.map((Country item) {
                          return DropdownMenuItem(
                            value: item.country_id,
                            child: Text(
                              item.country_name,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            donorinfo?.donor_country_id = value!;
                          });
                          fetchCity(donorinfo!.donor_country_id)
                              .then((response) {
                            if (response != null) {
                              setState(() {
                                listofCity = response;
                              });
                            }
                          });
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "City",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    DropdownButtonFormField(
                        isExpanded: true,
                        iconEnabledColor: Theme.of(context).iconTheme.color,
                        /*  value: (donorinfo?.donor_city_id == 0 ||
                                donorinfo?.donor_city_id == null)
                            ? null
                            : donorinfo?.donor_city_id, */
                        initialValue: listofCity.any((city) =>
                                city.city_id == donorinfo?.donor_city_id)
                            ? donorinfo?.donor_city_id
                            : null,
                        hint: const Text("Select One"),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(17),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(5.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                        items: listofCity.map((City item) {
                          return DropdownMenuItem(
                            value: item.city_id,
                            child: Text(
                              item.city_name,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            donorinfo?.donor_city_id = value!;
                          });
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Geographical Region",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    DropdownButtonFormField(
                        isExpanded: true,
                        iconEnabledColor: Theme.of(context).iconTheme.color,
                        /*  value: (donorinfo?.donor_geo_area_id == 0 ||
                                donorinfo?.donor_geo_area_id == null)
                            ? null
                            : donorinfo?.donor_geo_area_id, */
                        initialValue: listofGeoRegion.any(
                                (c) => c.geo_id == donorinfo?.donor_geo_area_id)
                            ? donorinfo?.donor_geo_area_id
                            : null,
                        hint: const Text("Select One"),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(17),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(5.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                        items: listofGeoRegion.map((GeoRegion item) {
                          return DropdownMenuItem(
                            value: item.geo_id,
                            child: Text(
                              item.geo_name,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            donorinfo?.donor_geo_area_id = value!;
                          });
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Industry / Sector",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    DropdownButtonFormField(
                        isExpanded: true,
                        iconEnabledColor: Theme.of(context).iconTheme.color,
                        /*     value: (donorinfo?.donor_sector_id == 0 ||
                                donorinfo?.donor_sector_id == null)
                            ? null
                            : donorinfo?.donor_sector_id, */

                        initialValue: listofSector.any((c) =>
                                c.sector_id == donorinfo?.donor_sector_id)
                            ? donorinfo?.donor_sector_id
                            : null,
                        hint: const Text("Select One"),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(17),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(5.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                        items: listofSector.map((Sector item) {
                          return DropdownMenuItem(
                            value: item.sector_id,
                            child: Text(
                              item.sector_name,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            donorinfo?.donor_sector_id = value!;
                          });
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.blueColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        child: const Text(
                          'Update',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            EasyLoading.show(status: 'Requesting...');

                            UpdateDonorProfile(donorinfo, image, context)
                                .then((reponse) {
                              EasyLoading.dismiss();

                              if (reponse == "1") {
                                showInfoAlert(
                                    "Success!",
                                    "Record has been updated successfully.",
                                    "assets/images/alert.json",
                                    context);
                              }
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          )
        ]));
  }

  Future<dynamic> showAttachemnts(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      //barrierColor: Theme.of(context).colorScheme.whiteColor.withOpacity(0.1),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(15),
          // color: Theme.of(context).colorScheme.profileEditColor,
          height: 200,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: _takeCameraImage,
                  child: CircleAvatar(
                    radius: 35,
                    // backgroundColor: Colors.white,
                    child:
                        Image.asset("assets/camera.png", width: 25, height: 25),
                  ),
                ),
                const Text("Camera",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: _uploadImage,
                  child: CircleAvatar(
                    radius: 35,
                    //  backgroundColor: Colors.white,
                    child: Image.asset("assets/collections.png",
                        width: 25, height: 25),
                  ),
                ),
                const Text("Gallery",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16)),
              ],
            ),
          ]),
        );
      },
    );
  }
}
