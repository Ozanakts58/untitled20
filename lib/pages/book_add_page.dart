import 'package:flutter/material.dart';
import 'package:untitled18/services/global_methods.dart';
import 'package:untitled18/services/global_veriables.dart';
import 'package:uuid/uuid.dart';
import 'package:untitled18/persistent/persistent.dart';
import 'package:untitled18/widgets/bottom_nav_bar2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class BookAddPage extends StatefulWidget {
  const BookAddPage({Key? key}) : super(key: key);

  @override
  State<BookAddPage> createState() => _BookAddPageState();
}

class _BookAddPageState extends State<BookAddPage> {
  final TextEditingController _bookCategoryController =
      TextEditingController(text: 'Kitap Kategorisi Seç');

  final TextEditingController _bookTitleController = TextEditingController();

  final TextEditingController _bookDescriptionController =
      TextEditingController();

  final TextEditingController _bookAuthorController = TextEditingController();
  final TextEditingController _bookPageNumberController =
      TextEditingController();
  final TextEditingController _isbnNumberController = TextEditingController();

  final TextEditingController _bookDeadlineDateController =
      TextEditingController(text: 'Kitap Ödünç Verme Süresi');

  final _formKey = GlobalKey<FormState>();
  File? imageFile;
  DateTime? picked;
  Timestamp? bookDeadlineDateTimesStamp;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _bookCategoryController.dispose();
    _bookTitleController.dispose();
    _bookDescriptionController.dispose();
    _bookAuthorController.dispose();
    _bookPageNumberController.dispose();
    _isbnNumberController.dispose();
    _bookDeadlineDateController.dispose();
  }

  Widget _textTitles({required String label}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showImageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Please choose an option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  //create getFrontCamera
                  _getFromCamera();
                },
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.camera,
                        color: Colors.purple,
                      ),
                    ),
                    Text(
                      'Camera',
                      style: TextStyle(
                        color: Colors.purple,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  //create getFrontGallery
                  _getFromGallery();
                },
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.image,
                        color: Colors.purple,
                      ),
                    ),
                    Text(
                      'Gallery',
                      style: TextStyle(
                        color: Colors.purple,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _getFromCamera() async {
    XFile? pickedFile =
    await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromGallery() async {
    XFile? pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  Widget _textFormFields(
      {required String valueKey,
      required TextEditingController controller,
      required bool enabled,
      required Function fct,
      required int maxLength}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      //ınkWell dokunulduğunda ne yapsın anlamına gelir
      child: InkWell(
        onTap: () {
          fct();
        },
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Form alanı boş';
            }
            return null;
          },
          controller: controller,
          enabled: enabled,
          key: ValueKey(valueKey),
          style: const TextStyle(
            color: Colors.white,
          ),

          ///Description text alanını daha büyük yaptı.
          maxLines: valueKey == 'BookDescription' ? 3 : 1,

          maxLength: maxLength,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.black54,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showTaskCategoriesDialog({required Size size}) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          title: const Text(
            'Kitap Kategorisi',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          content: Container(
            width: size.width * 0.9,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: Persistent.bookCategoryList.length,
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _bookCategoryController.text =
                          Persistent.bookCategoryList[index];
                    });
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_right_alt_outlined,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          Persistent.bookCategoryList[index],
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
              child: const Text(
                'Vazgeç',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _pickDateDialog() async {
    picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        const Duration(days: 0),
      ),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _bookDeadlineDateController.text =
            '${picked!.year} - ${picked!.month} - ${picked!.day}';
        bookDeadlineDateTimesStamp = Timestamp.fromMicrosecondsSinceEpoch(
            picked!.microsecondsSinceEpoch);
      });
    }
  }

  void _uploadTask() async {
    final bookId = const Uuid().v4();
    User? user = FirebaseAuth.instance.currentUser;
    final _uid = user!.uid;
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      if (_bookCategoryController.text == 'Lütfen Kitap Kategorisi Seçin' ||
          _bookDeadlineDateController.text == 'Kitap Ödünç Verme Süresi') {
        GlobalMethod.showErrorDialog(
          error: 'Lütfen Bütün Alanları Seçin',
          ctx: context,
        );
        return;
      }
      setState(() {
        _isLoading = true;
      });
      try {
        await FirebaseFirestore.instance.collection('books').doc(bookId).set({
          'bookId': bookId,
          'uploadedBy': _uid,
          'email.': user.email,
          'bookTitle': _bookTitleController.text,
          'bookDescription': _bookDescriptionController.text,
          'bookAuthor': _bookAuthorController.text,
          'pageNumber': _bookPageNumberController.hashCode,
          'isbn': _isbnNumberController.text,
          'bookDeadlineDate': _bookDeadlineDateController.text,
          'bookDeadlineDateTimeStamp': bookDeadlineDateTimesStamp,
          'bookCategory': _bookCategoryController.text,
          'bookComments': [],
          'recruitment': true,
          'createdAt': Timestamp.now(),
          'name': name,
          'bookImage': bookImage,
          'location': location,
          'applicants': 0,
        });
        await Fluttertoast.showToast(
          msg: 'Form yüklendi',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.grey,
          fontSize: 18.0,
        );
        _bookTitleController.clear();
        _bookDescriptionController.clear();
        _bookAuthorController.clear();
        _bookPageNumberController.clear();
        _isbnNumberController.clear();

        setState(() {
          _bookCategoryController.text = 'Kitap Kategorisini Seç';
          _bookDeadlineDateController.text = 'Ödünç Verme Süresini Seç';
        });
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        GlobalMethod.showErrorDialog(error: error.toString(), ctx: context);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      print('Geçerli değil');
    }
  }

  void getMyData() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      name = userDoc.get('name');
      bookImage = userDoc.get('bookImage');
      location = userDoc.get('location');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Colors.red,
          ],
        ),
      ),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBarForApp(
          indexNum: 2,
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            /*padding: const EdgeInsets.only(
                left: 7.0, top: 22.0, right: 7.0, bottom: 7.0),*/

            padding: const EdgeInsets.all(7.0),

            ///Card
            child: Card(
              color: Colors.white10,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Lütfen Hepsini doldurun',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            //fontFamily: 'Signatra',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    ///bölücü
                    const Divider(thickness: 1),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Lütfen Kitabın Fotoğrafını Ekleyin',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            //fontFamily: 'Signatra',
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      /*child: Text(
                        "Kitap Fotoğrafı yükle",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),*/
                      onTap: () {
                        _showImageDialog();
                      },

                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: size.width * 0.24,
                            height: size.width * 0.24,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.cyanAccent,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: imageFile == null
                                    ? const Icon(
                                  Icons.camera_enhance_sharp,
                                  color: Colors.cyan,
                                  size: 30,
                                )
                                    : Image.file(
                                  imageFile!,
                                  fit: BoxFit.fill,
                                )),
                          ),
                        ),
                      ),
                    ),
                    const Divider(thickness: 1),
                    Padding(
                      padding: const EdgeInsets.all(8.0),

                      ///Form  Erea
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _textTitles(label: 'Kitap Kategorisi :'),
                            _textFormFields(
                              valueKey: 'BookCategory',
                              controller: _bookCategoryController,
                              enabled: false,
                              fct: () {
                                _showTaskCategoriesDialog(size: size);
                              },
                              maxLength: 100,
                            ),
                            _textTitles(label: 'Kitap Başlığı :'),
                            _textFormFields(
                              valueKey: 'BookTitle',
                              controller: _bookTitleController,
                              enabled: true,
                              fct: () {},
                              maxLength: 100,
                            ),
                            _textTitles(label: 'Kitap Açıklaması :'),
                            _textFormFields(
                              valueKey: 'BookDescription',
                              controller: _bookDescriptionController,
                              enabled: true,
                              fct: () {},
                              maxLength: 700,
                            ),
                            _textTitles(label: 'Yazar:'),
                            _textFormFields(
                              valueKey: 'BookAuthor',
                              controller: _bookAuthorController,
                              enabled: true,
                              fct: () {},
                              maxLength: 70,
                            ),
                            _textTitles(label: 'Sayfa Sayısı :'),
                            _textFormFields(
                              valueKey: 'BookPageNumber',
                              controller: _bookPageNumberController,
                              enabled: true,
                              fct: () {},
                              maxLength: 30,
                            ),
                            _textTitles(label: 'ISBN Numarası :'),
                            _textFormFields(
                              valueKey: 'BookIsbnNumber',
                              controller: _isbnNumberController,
                              enabled: true,
                              fct: () {},
                              maxLength: 50,
                            ),
                            _textTitles(
                                label: 'Ne Zamana Kadar Ödünç Verilecek:'),
                            _textFormFields(
                              valueKey: 'bookDeadline',
                              controller: _bookDeadlineDateController,
                              enabled: false,
                              fct: () {
                                _pickDateDialog();
                              },
                              maxLength: 100,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : MaterialButton(
                                onPressed: () {
                                  _uploadTask();
                                },
                                color: Colors.black,
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'Kitabı Ekle',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          fontFamily: 'Signatra',
                                        ),
                                      ),
                                      SizedBox(width: 9),
                                      Icon(
                                        Icons.upload_file,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
