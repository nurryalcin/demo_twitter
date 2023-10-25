import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../api_service/user_service.dart';
import '../../../../../model/user.dart';
import '../../../../../utils/class.dart';
import '../../../../../utils/provider.dart';



class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key, required this.onUserSelected});

  final void Function(bool) onUserSelected;


  @override
  State<StatefulWidget> createState() => _SearchWidgetState();
}



class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<User> _searchResults = [];
  String _selectedUsername = "";


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchUsers(String username) async {
    setState(() {
      _searchResults.clear();
    });

    if (username.isEmpty) {
      return;
    }

    List<User>? results = await UserService().getUsername(username);

    if (results != null) {
      setState(() {
        _searchResults = results;
      });
    }
  }

  void _onUserSelected(String username, int userId) {
    setState(() {
      _selectedUsername = username;
      _searchController.clear();
      _searchResults.removeWhere((user) => user.username != username);

      Provider.of<UserProfileProvider>(context, listen: false).setSelectedUserId(userId);

      widget.onUserSelected(true);
      print("Seçilen Kişi ID: $userId");

    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 50, maxWidth: 410),
          child: TextField(
            controller: _searchController,
            onChanged: _searchUsers,
            decoration: InputDecoration(
              hintText: 'Search people',
              hintStyle: const TextStyle(fontSize: 20),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: CardColor.fullScreenTitleColor,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _searchResults.length,
          itemBuilder: (context, index) {
            return  ListTile(
              title: Text(_searchResults[index].username),
              onTap: () => _onUserSelected(
                _searchResults[index].username,
                _searchResults[index].id,
              ),
            );

          },
        ),
        const SizedBox(height: 16),
        _selectedUsername.isNotEmpty
            ? Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey[200],
                child: Text(_selectedUsername),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
