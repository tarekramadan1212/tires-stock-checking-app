import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supreme/business_logic/auth_bloc/auth_events.dart';
import 'package:supreme/core/widgets/custom_text_field.dart';
import '../../business_logic/auth_bloc/auth_bloc.dart';
import '../../business_logic/auth_bloc/auth_states.dart';
import '../../core/utilities/constants/app_colors.dart';
import '../../core/widgets/custom_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Change Password')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 18),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(Icons.lock_reset_rounded,
                      size: 100,
                      color: AppColors.primarySeed,
                    ),
                    Text('Update your password',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 15),
                    Text('Choose a strong password to keep your account secure',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(height: 25),
                    CustomTextField(
                      validator: (value){
                        if(value == null || value.isEmpty)
                          {
                            return 'Please enter The New password';
                          }
                        if(value.length < 6)
                          {
                            return 'Password must be at least 6 characters';
                          }
                        return null;
                      },
                      controller: _passwordController,
                      obscureText: _isPasswordVisible,
                      hintText: 'New Password',
                      prefixIcon: Icon(Icons.lock_outline),
                      maxLines: 1,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.primarySeed,
                          width: 2,
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    CustomTextField(
                      validator: (value){
                        if(value == null || value.isEmpty)
                          {
                            return 'Please Confirm The New password';

                          }
                        if(value != _passwordController.text)
                          {
                            return 'The Confirm Password is not matching';
                          }
                        return null;
                      },
                      controller: _confirmPasswordController,
                      prefixIcon: Icon(Icons.lock_reset_outlined),
                      maxLines: 1,
                      obscureText: _isConfirmPasswordVisible,
                      hintText: 'Confirm Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                          });
                        },
                        icon: Icon(
                          _isConfirmPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.primarySeed,
                          width: 2,
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    BlocConsumer<AuthBloc, AuthStates>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return CustomButton(
                          onPressed: ()
                          {
                            if(_formKey.currentState!.validate())
                              {
                                context.read<AuthBloc>().add(ChangePasswordEvent(password: _confirmPasswordController.text));
                              }
                          },
                          child: state is AuthLoadingState? CircularProgressIndicator() :Text(
                            'Change Password',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        );
                      }
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
