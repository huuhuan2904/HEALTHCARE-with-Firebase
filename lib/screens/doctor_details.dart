import 'package:flutter/material.dart';

class DoctorDetails extends StatefulWidget {
  final String avatar;
  final String name;
  final int phoneNumber;
  final String address;
  final String specialty;
  final List experiences;
  DoctorDetails(this.avatar, this.name, this.phoneNumber, this.address,
      this.specialty, this.experiences);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

Widget _buildExpDoctor(String title, IconData icon) {
  return ListTile(
    leading: Icon(
      icon,
      color: Colors.purple,
    ),
    title: Text(title),
  );
}

class _DoctorDetailsState extends State<DoctorDetails> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(widget.avatar),
            ),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.purple)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(widget.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25)),
                      ),
                      Text(widget.specialty,
                          style: const TextStyle(fontSize: 17)),
                      const Padding(
                        padding: EdgeInsets.only(left: 17, right: 17, top: 7),
                        child: Text(
                          'Bác sĩ Nguyễn Văn A có hơn 40 năm kinh nghiệm hoạt động trong lĩnh vực thăm khám và điều trị các bệnh lý tim mạch. Ngoài việc khám – chữa bệnh thì bác sĩ còn tham gia nghiên cứu khoa học với hơn 265 đề tài, tất cả đã được công bố trên tạp chí khoa học trong và ngoài nước.',
                          style: TextStyle(fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(13),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 100,
                      child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Liên hệ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(widget.phoneNumber.toString())
                              ],
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 100,
                      child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Địa chỉ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Wrap(
                                  children: [
                                    Text(widget.address),
                                  ],
                                )
                              ],
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
            // SizedBox(
            //   height: 400,
            //   child: Padding(
            //     padding: const EdgeInsets.all(10),
            //     child: Card(
            //       elevation: 10,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20)),
            //       child: Column(
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.only(top: 13, left: 13),
            //             child: Row(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: const [
            //                 Icon(
            //                   Icons.work,
            //                   color: Colors.purple,
            //                 ),
            //                 Text(
            //                   '  Kinh nghiệm',
            //                   style:
            //                       TextStyle(fontSize: 20, color: Colors.purple),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           const Divider(
            //             color: Colors.grey,
            //           ),
            //           _buildExpDoctor(
            //               'Giảng viên chính - Trưởng Bộ môn Xương khớp - Đại học Y Dược Huế',
            //               Icons.work_outline),
            //           const Divider(
            //             color: Colors.grey,
            //           ),
            //           _buildExpDoctor(
            //               'Bác sĩ điều trị - Trưởng phòng khám Sức khỏe tim mạch - Bệnh viện trường đại học Y Dược Huế',
            //               Icons.work_outline),
            //           const Divider(
            //             color: Colors.grey,
            //           ),
            //           _buildExpDoctor(
            //               'Bác sĩ điều trị - Phó trưởng phòng khám Sức khỏe tim mạch - Bệnh viện Trung Ương Huế',
            //               Icons.work_outline),
            //           const Divider(
            //             color: Colors.grey,
            //           ),
            //           _buildExpDoctor(
            //               '2005: Chứng chỉ đào tạo chuyên môn Xương khớp tại Sydney, Australia',
            //               Icons.work_outline),
            //           const Divider(
            //             color: Colors.grey,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 13, left: 13),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.work,
                            color: Colors.purple,
                          ),
                          Expanded(
                            child: Text(
                              '  Kinh nghiệm',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.purple),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: widget.experiences.length,
                      separatorBuilder: (_, __) => const Divider(
                        color: Colors.grey,
                      ),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(
                            Icons.work_outline,
                            color: Colors.purple,
                          ),
                          title: Text(widget.experiences[index]),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 13, left: 13),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Icon(
                              Icons.cast_for_education,
                              color: Colors.purple,
                            ),
                            Text(
                              '  Học vấn',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.purple),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      _buildExpDoctor(
                          'Giảng viên chính - Trưởng Bộ môn Xương khớp - Đại học Y Dược Huế',
                          Icons.cast_for_education),
                      const Divider(
                        color: Colors.grey,
                      ),
                      _buildExpDoctor(
                          'Bác sĩ điều trị - Trưởng phòng khám Sức khỏe tim mạch - Bệnh viện trường đại học Y Dược Huế',
                          Icons.cast_for_education),
                      const Divider(
                        color: Colors.grey,
                      ),
                      _buildExpDoctor(
                          'Bác sĩ điều trị - Phó trưởng phòng khám Sức khỏe tim mạch - Bệnh viện Trung Ương Huế',
                          Icons.cast_for_education),
                      const Divider(
                        color: Colors.grey,
                      ),
                      _buildExpDoctor(
                          '2005: Chứng chỉ đào tạo chuyên môn Xương khớp tại Sydney, Australia',
                          Icons.cast_for_education),
                      const Divider(
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
