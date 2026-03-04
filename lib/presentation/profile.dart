import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supreme/business_logic/auth_bloc/auth_bloc.dart';
import 'package:supreme/business_logic/auth_bloc/auth_events.dart';
import 'package:supreme/core/app_cubit/app_cubit.dart';
import 'package:supreme/core/app_cubit/app_states.dart';
import 'package:supreme/core/utilities/constants/app_colors.dart';

import 'auth/change_password.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing user directly from Supabase session
    final user = Supabase.instance.client.auth.currentUser;
    final metadata = user?.userMetadata ?? {};

    final String branchName = metadata['branch_name'] ?? 'Not Assigned';
    final String email = user?.email ?? 'Unknown User';
    final bool isVerified = user?.emailConfirmedAt != null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // --- HEADER SECTION ---
          CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.primarySeed.withValues(alpha: 0.1),
            child: Text(
              email.isNotEmpty ? email[0].toUpperCase() : 'U',
              style: const TextStyle(fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primarySeed),
            ),
          ),
          const SizedBox(height: 16),
          // --- email
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(email, style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge),
              if (isVerified)
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.verified, color: Colors.blue, size: 20),
                ),
            ],
          ),
          const SizedBox(height: 32),

          // --- WORK CONTEXT CARD ---
          InfoCard(
            title: "Branch Assignment",
            content: branchName,
            icon: Icons.business_outlined,
            subtitle: "Branch ID: ${user?.id.substring(
                0, 8)}...", // Shortened ID for UI
          ),

          const SizedBox(height: 24),

          // --- STATS ROW (Placeholders) ---
          Row(
            children: [
              StatusCard(value: "Customers",label:  "24",icon:  Icons.people),
              const SizedBox(width: 16),
              StatusCard(value: "Avg. Wait",label:  "12m",icon:  Icons.timer),
            ],
          ),

          const SizedBox(height: 32),
          const Divider(),

          // --- SETTINGS LIST ---
          _buildSectionTitle("App Settings"),
          // -- Dark Mode
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: const Text("Dark Mode"),
            trailing: BlocBuilder<AppCubit, AppStates>(
              builder: (context, state) {
                return Switch(

                  value: context.read<AppCubit>().isDark,
                   onChanged: (val) {
                    context.read<AppCubit>().toggleTheme(val);
                  },
                );
              }
            ),
          ),
          // -- Change Password
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text("Change Password"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ChangePasswordScreen()));
            },
          ),

          const SizedBox(height: 32),

          // --- LOGOUT BUTTON ---
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _showLogoutDialog(context),
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text(
                  "Logout Account", style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );

  }




  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text("Logout"),
            content: const Text("Are you sure you want to exit your session?"),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel")),
              TextButton(
                onPressed: () async{
                  Navigator.pop(context); // Close dialog, Listener in main will handle navigation
                  context.read<AuthBloc>().add(SignedOutEvent());
                  context.read<AppCubit>().changeBottomNavItem(0);
                },
                child: const Text(
                    "Logout", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }
}


class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.title, required this.content, required this.icon, this.subtitle});
  final String title;
  final String content;
  final IconData icon;
  final String? subtitle;


  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primarySeed.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primarySeed.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primarySeed, size: 30),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(content, style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold)),
              if (subtitle != null) Text(subtitle!,
                  style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}

class StatusCard extends StatelessWidget {
  const StatusCard({super.key, required this.value, required this.label, required this.icon});
  final String value;
  final String label;
  final IconData icon;


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.grey),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold)),
            Text(label,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

