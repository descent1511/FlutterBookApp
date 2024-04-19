import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  // Danh sách các cuốn sách (có thể thay thế bằng dữ liệu thực từ API hoặc cơ sở dữ liệu)
  final List<String> books = [
    'Book 1',
    'Book 2',
    'Book 3',
    'Book 4',
    'Book 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome to the home page!',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back to login page
                Navigator.pushReplacementNamed(context, '/signin');
              },
              child: Text('Log out'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(books[index]),
                      // Tùy chỉnh xử lý khi người dùng nhấn vào mỗi sách ở đây
                      onTap: () {
                        // Thực hiện hành động tương ứng khi người dùng chọn một cuốn sách
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
