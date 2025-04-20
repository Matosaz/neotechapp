import 'package:flutter/material.dart';
import 'package:neotechapp/widgets/bottom_navbar.dart';
import 'package:get/get.dart';




class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Container(
          margin: const EdgeInsets.only(left: 5, top:20),
          child: const Text("Meu perfil",
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.w600)),
        ),

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const UserHeader(),
            const SizedBox(height: 30),
            ProfileMenu(
              text: "Editar perfil",
              icon: Icons.person,
              press: () {
                  Get.toNamed('/editperfil');

              },
            ),
           
            ProfileMenu(
              text: "Configurações",
              icon: Icons.settings,
              press: () {},
            ),
            ProfileMenu(
              text: "Ajuda",
              icon: Icons.help_outline,
              press: () {},
            ),
            ProfileMenu(
              text: "Sair",
              icon: Icons.logout,
              press: () {},
            ),
          ],
        ),
      ),
bottomNavigationBar: BottomNavBar(
  selectedIndex: 3,
  onTabChange: (index) {
    if (index != 3) {
      Get.offNamed('/home', arguments: index);
    }
    if(index == 2){
            Get.toNamed('/historico');
          }
  },
),

    );
  }
}

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage:
                NetworkImage("https://i.postimg.cc/0jqKB6mS/Profile-Image.png"),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const SizedBox(width: 15),
          const Text(
            "Olá, João!",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 87, 87, 87),
            ),
          ),

           const SizedBox(height:4),
           Row(
              children: const[
            
              Text("usuario@gmail.com",
              style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF757575),) 
            ),
                Padding(padding: EdgeInsets.only(left: 5),
                 child: Icon(Icons.email, size: 16, color: Color(0xFF757575)),
                ),
            ],
        
          ),
            ],
          )
        
        ],
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.text,
    required this.icon,
    this.press,
  });

  final String text;
  final IconData icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
   
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF81B89A),
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF81B89A),
              size: 26,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF757575),
                  fontSize: 14
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF757575),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}



const cameraIcon =
    '''<svg width="20" height="16" viewBox="0 0 20 16" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M10 12.0152C8.49151 12.0152 7.26415 10.8137 7.26415 9.33902C7.26415 7.86342 8.49151 6.6619 10 6.6619C11.5085 6.6619 12.7358 7.86342 12.7358 9.33902C12.7358 10.8137 11.5085 12.0152 10 12.0152ZM10 5.55543C7.86698 5.55543 6.13208 7.25251 6.13208 9.33902C6.13208 11.4246 7.86698 13.1217 10 13.1217C12.133 13.1217 13.8679 11.4246 13.8679 9.33902C13.8679 7.25251 12.133 5.55543 10 5.55543ZM18.8679 13.3967C18.8679 14.2226 18.1811 14.8935 17.3368 14.8935H2.66321C1.81887 14.8935 1.13208 14.2226 1.13208 13.3967V5.42346C1.13208 4.59845 1.81887 3.92664 2.66321 3.92664H4.75C5.42453 3.92664 6.03396 3.50952 6.26604 2.88753L6.81321 1.41746C6.88113 1.23198 7.06415 1.10739 7.26604 1.10739H12.734C12.9358 1.10739 13.1189 1.23198 13.1877 1.41839L13.734 2.88845C13.966 3.50952 14.5755 3.92664 15.25 3.92664H17.3368C18.1811 3.92664 18.8679 4.59845 18.8679 5.42346V13.3967ZM17.3368 2.82016H15.25C15.0491 2.82016 14.867 2.69466 14.7972 2.50917L14.2519 1.04003C14.0217 0.418041 13.4113 0 12.734 0H7.26604C6.58868 0 5.9783 0.418041 5.74906 1.0391L5.20283 2.50825C5.13302 2.69466 4.95094 2.82016 4.75 2.82016H2.66321C1.19434 2.82016 0 3.98846 0 5.42346V13.3967C0 14.8326 1.19434 16 2.66321 16H17.3368C18.8057 16 20 14.8326 20 13.3967V5.42346C20 3.98846 18.8057 2.82016 17.3368 2.82016Z" fill="#757575"/>
</svg>
''';
