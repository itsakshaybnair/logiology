import 'package:flutter/material.dart';
import 'package:logiology/core/theme/app_colors.dart';

class EditUserInfoDialog extends StatefulWidget {
  final Function(String) onSubmit;
  final String initialValue;
  final bool isNameChanged;

  const EditUserInfoDialog(
      {super.key,
      required this.onSubmit,
      this.isNameChanged = true,
      required this.initialValue});

  @override
  State<StatefulWidget> createState() {
    return _EditUserInfoDialogState();
  }
}

class _EditUserInfoDialogState extends State<EditUserInfoDialog> {
  
  //final TextEditingController _controller = TextEditingController(text: a);
  late final TextEditingController _controller = TextEditingController(text: widget.initialValue);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: const BorderSide(color: Colors.white),
      ),
      elevation: 16,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.isNameChanged ? "Change Name:" : "Change Password",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: widget.isNameChanged ? "Edit name" : "Edit password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  final text = _controller.text.trim();
                  if (text.isNotEmpty) {
                    widget.onSubmit(text);
                  //   widget.isNameChanged
                  //       ? await UserPreferences.setUserName(name: text)
                  //       : await UserPreferences.setUserPassword(password: text);
                  //   widget.isNameChanged
                  //       ? UserInfo.name = text
                  //       : UserInfo.paswword = text;
                  //   refreshUserInfoNotifier.value =
                  //       !refreshUserInfoNotifier.value;
                  //   //  refreshUserInfoNotifier.notifyListeners();
                  //   if (context.mounted) {
                  //     Navigator.of(context).pop();
                  //   } // Close dialog
                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
