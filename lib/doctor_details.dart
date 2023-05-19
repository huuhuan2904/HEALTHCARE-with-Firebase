import 'package:flutter/material.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key});

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
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                  'https://cdn.cpdonline.co.uk/wp-content/uploads/2021/07/28125941/Doctors-CPD-couses.png'),
            ),
            Container(
              height: 200,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.purple)),
                  child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text('Bs Nguyễn Văn A',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25)),
                      ),
                      Text('Tim mạch, Xương khớp',
                          style: TextStyle(fontSize: 17)),
                      Padding(
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
                              children: const [
                                Text(
                                  'Liên hệ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('0987654321')
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
                                  children: const [
                                    Text('Số 1 Tôn Thất Tùng, Đống Đa, Hà Nội'),
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
            Container(
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
                              Icons.work,
                              color: Colors.purple,
                            ),
                            Text(
                              '  Kinh nghiệm',
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
                          Icons.work_outline),
                      const Divider(
                        color: Colors.grey,
                      ),
                      _buildExpDoctor(
                          'Bác sĩ điều trị - Trưởng phòng khám Sức khỏe tim mạch - Bệnh viện trường đại học Y Dược Huế',
                          Icons.work_outline),
                      const Divider(
                        color: Colors.grey,
                      ),
                      _buildExpDoctor(
                          'Bác sĩ điều trị - Phó trưởng phòng khám Sức khỏe tim mạch - Bệnh viện Trung Ương Huế',
                          Icons.work_outline),
                      const Divider(
                        color: Colors.grey,
                      ),
                      _buildExpDoctor(
                          '2005: Chứng chỉ đào tạo chuyên môn Xương khớp tại Sydney, Australia',
                          Icons.work_outline),
                      const Divider(
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
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
