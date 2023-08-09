import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:map_flutter/Page/ibu_hamil.dart';
import '../shared/theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_fileld.dart';

class NoteIbuHamil extends StatefulWidget {
  const NoteIbuHamil({super.key});

  @override
  State<NoteIbuHamil> createState() => _NoteIbuHamilState();
}

class _NoteIbuHamilState extends State<NoteIbuHamil>
    with SingleTickerProviderStateMixin {
  DateTime date = DateTime.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController periksaController =
      TextEditingController(text: '');
  final TextEditingController tempatController =
      TextEditingController(text: '');
  final TextEditingController catatanController =
      TextEditingController(text: '');

  late AnimationController loadingController;
  File? _file;
  PlatformFile? _platformFile;
  String imageUrl = '';

  selectFile() async {
    final file = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);

    if (file != null) {
      setState(() {
        _file = File(file.files.single.path!);
        _platformFile = file.files.first;
      });
    }

    Reference ref = FirebaseStorage.instance.ref().child(_platformFile!.name);
    await ref.putFile(_file!);
    ref.getDownloadURL().then((value) async {
      imageUrl = value;
    });

    loadingController.forward();
  }

  @override
  void initState() {
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference noteBumil = firestore.collection('notebumil');
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.arrow_left,
                    size: 30,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 10),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/ibuhamil.png'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Note Pemeriksaan',
                      style: blackTextStyleSB.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      title: '* Jenis Pemeriksaan',
                      hintText: '4 minggu..',
                      controller: periksaController,
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: "Please enter Topik"),
                        ],
                      ),
                    ),
                    CustomTextFormField(
                      title: '* Tempat Pemeriksaan',
                      hintText: 'Bidan ...',
                      controller: tempatController,
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: "Please enter Topik"),
                        ],
                      ),
                    ),
                    Text(
                      '* Tanggal Pemeriksaan',
                      style: blackTextStyleSB.copyWith(
                        fontWeight: normal,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 55,
                          width: 150,
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius:
                                  BorderRadius.circular(defauilRadius)),
                          child: Center(
                            child: Text(
                              '${date.day}/${date.month}/${date.year}',
                              style: blackTextStyleSB.copyWith(
                                fontWeight: normal,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        IconButton(
                          onPressed: () async {
                            DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            );
                            //jiki cancel milih null
                            if (newDate == null) return;
                            // jika ok datetime
                            setState(() {
                              date = newDate;
                            });
                          },
                          icon: const Icon(
                            Icons.calendar_month,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      title: '* Catatan',
                      hintText: '',
                      line: 4,
                      controller: catatanController,
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: "Please enter Topik"),
                        ],
                      ),
                    ),
                    Text(
                      '* Lampirkan foto buku KIA',
                      style: blackTextStyleSB.copyWith(
                        fontWeight: normal,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: selectFile,
                      child: Container(
                        height: 40,
                        width: 126,
                        decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(defauilRadius),
                        ),
                        child: Center(
                            child: Text(
                          "Pilih foto",
                          style:
                              whiteTextStyleSB.copyWith(fontWeight: semiBold),
                        )),
                      ),
                    ),
                    _platformFile != null
                        ? Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selected File',
                                  style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade200,
                                            offset: const Offset(0, 1),
                                            blurRadius: 3,
                                            spreadRadius: 2,
                                          )
                                        ]),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.file(
                                              _file!,
                                              width: 70,
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _platformFile!.name,
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                '${(_platformFile!.size / 1024).ceil()} KB',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color:
                                                        Colors.grey.shade500),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                  height: 5,
                                                  clipBehavior: Clip.hardEdge,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.blue.shade50,
                                                  ),
                                                  child:
                                                      LinearProgressIndicator(
                                                    value:
                                                        loadingController.value,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ))
                        : Container(),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      title: 'Simpan',
                      onpressed: () {
                        //upload data to firestore
                        if (_formKey.currentState!.validate()) {
                          User? user = FirebaseAuth.instance.currentUser;
                          noteBumil.add({
                            'pemeriksaan': periksaController.text,
                            'tempat': tempatController.text,
                            'tanggal':
                                DateFormat('EEEE, d MMMM yyyy').format(date),
                            'catatan': catatanController.text,
                            'fotokiabumil': imageUrl,
                            'userid': user!.uid,
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const IbuHamil(),
                            ),
                          );
                        }
                      },
                      fontwidth: double.infinity,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
