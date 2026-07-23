import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // 👤 Profile Image
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-CZZQw8h4uNL2glA5SsNemwe_b0B4Qmj1jTZh2UahkLS9LiTDk066Xic&s=10",
              ),
            ),

            const SizedBox(height: 10),

            // 👤 Name
            const Text(
              "Akshay",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Role
            const Text(
              "Salon Owner",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            // 📋 Details Section
            _buildTile(Icons.phone, "Phone", "+91 9876543210"),
            _buildTile(Icons.store, "Salon Name", "Stylish salon"),
            _buildTile(Icons.location_on, "Location", "Kannur, Kerala"),
            

            const SizedBox(height: 20),

            // ⚙️ Actions
            _buildButton("Edit Profile", Icons.edit, () {}),
            _buildButton("Change Password", Icons.lock, () {}),
            _buildButton("Logout", Icons.logout, () {}),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // 🔹 Reusable Detail Tile
  static Widget _buildTile(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Card(
        elevation: 2,
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          subtitle: Text(value),
        ),
      ),
    );
  }

  // 🔹 Reusable Button
  static Widget _buildButton(
      String text, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onTap,
          icon: Icon(icon),
          label: Text(text),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}