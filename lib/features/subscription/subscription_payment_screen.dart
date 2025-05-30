// lib/ui/screens/subscription_payment_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homehero/features/core/d_color.dart';
import 'package:homehero/features/core/d_text_style.dart';
import 'package:homehero/features/core/d_alerts.dart';
import 'package:homehero/utils/injectable/configurator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:homehero/data/models/subscription_model.dart';
import 'package:homehero/features/subscription/bloc/subscription_bloc.dart';

@RoutePage()
class SubscriptionPaymentScreen extends StatelessWidget {
  final SubscriptionTypeModel type;

  const SubscriptionPaymentScreen({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SubscriptionBloc>(
      create: (_) => getIt<SubscriptionBloc>(),
      child: _SubscriptionPaymentView(type: type),
    );
  }
}

class _SubscriptionPaymentView extends StatefulWidget {
  final SubscriptionTypeModel type;
  const _SubscriptionPaymentView({required this.type});

  @override
  State<_SubscriptionPaymentView> createState() => _SubscriptionPaymentViewState();
}

class _SubscriptionPaymentViewState extends State<_SubscriptionPaymentView> {
  final _formKey = GlobalKey<FormState>();
  final _cardCtrl = TextEditingController();
  final _expiryCtrl = TextEditingController();
  final _cvvCtrl = TextEditingController();

  final _cardMask = MaskTextInputFormatter(mask: '#### #### #### ####', filter: {'#': RegExp(r'\d')});
  final _expiryMask = MaskTextInputFormatter(mask: '##/##', filter: {'#': RegExp(r'\d')});
  final _cvvMask = MaskTextInputFormatter(mask: '###', filter: {'#': RegExp(r'\d')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Оплатить ${widget.type.name}'),
        backgroundColor: DColor.whiteColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: BlocListener<SubscriptionBloc, SubscriptionState>(
          listener: (context, state) {
            if (state is SubscriptionSuccess) {
              DAlerts.showDefaultAlert(
                'Подписка оформлена!',
                () => AutoRouter.of(context).maybePop(),
                context,
              );
            } else if (state is SubscriptionFailure) {
              DAlerts.showErrorAlert(state.error, context);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Введите данные карты', style: DTextStyle.boldBlackText),
              const SizedBox(height: 24),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: _cardCtrl,
                          label: 'Номер карты',
                          hint: '0000 0000 0000 0000',
                          keyboardType: TextInputType.number,
                          inputFormatters: [_cardMask],
                          validator: (v) => v != null && v.replaceAll(' ', '').length == 16 ? null : 'Введите 16 цифр',
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: _expiryCtrl,
                                label: 'MM/YY',
                                hint: '12/34',
                                inputFormatters: [_expiryMask],
                                validator: (v) => v != null && v.length == 5 ? null : 'MM/YY',
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildTextField(
                                controller: _cvvCtrl,
                                label: 'CVV',
                                hint: '123',
                                keyboardType: TextInputType.number,
                                obscureText: true,
                                inputFormatters: [_cvvMask],
                                validator: (v) => v != null && v.length == 3 ? null : '3 цифры',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        BlocBuilder<SubscriptionBloc, SubscriptionState>(
                          builder: (context, state) {
                            return state is SubscriptionLoading
                                ? const CircularProgressIndicator()
                                : SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          final userId = sharedDb.getInt('id')!;
                                          context.read<SubscriptionBloc>().add(
                                                SubmitSubscription(
                                                  userId: userId,
                                                  type: widget.type,
                                                  cardNumber: _cardCtrl.text.replaceAll(' ', ''),
                                                  expiry: _expiryCtrl.text,
                                                  cvv: _cvvCtrl.text,
                                                ),
                                              );
                                        }
                                      },
                                      child: const Text('Оплатить', style: DTextStyle.primaryText),
                                    ),
                                  );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: DColor.greenSecondColor),
        ),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      validator: validator,
    );
  }
}
