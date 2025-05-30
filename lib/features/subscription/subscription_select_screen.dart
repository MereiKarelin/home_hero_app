// lib/ui/screens/subscription_selection_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:homehero/data/models/subscription_model.dart';
import 'package:homehero/utils/app_router.gr.dart';

@RoutePage()
class SubscriptionSelectionScreen extends StatelessWidget {
  const SubscriptionSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выберите подписку'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            PlanCard(
              type: SubscriptionTypeModel.BASIC,
              title: 'Basic',
              eventsPerMonth: 2,
              emergencyAllowed: false,
              onSelected: () {
                AutoRouter.of(context).push(SubscriptionPaymentRoute(type: SubscriptionTypeModel.BASIC));
              },
            ),
            const SizedBox(height: 16),
            PlanCard(
              type: SubscriptionTypeModel.STANDARD,
              title: 'Standard',
              eventsPerMonth: 5,
              emergencyAllowed: false,
              onSelected: () {
                AutoRouter.of(context).push(SubscriptionPaymentRoute(type: SubscriptionTypeModel.STANDARD));
              },
            ),
            const SizedBox(height: 16),
            PlanCard(
              type: SubscriptionTypeModel.PREMIUM,
              title: 'Premium',
              eventsPerMonth: 7,
              emergencyAllowed: true,
              onSelected: () {
                AutoRouter.of(context).push(SubscriptionPaymentRoute(type: SubscriptionTypeModel.PREMIUM));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final SubscriptionTypeModel type;
  final String title;
  final int eventsPerMonth;
  final bool emergencyAllowed;
  final VoidCallback onSelected;

  const PlanCard({
    Key? key,
    required this.type,
    required this.title,
    required this.eventsPerMonth,
    required this.emergencyAllowed,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text('$eventsPerMonth событий в месяц'),
            if (emergencyAllowed) ...[
              const SizedBox(height: 4),
              const Text('Включены экстренные события'),
            ],
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onSelected,
                child: const Text('Выбрать'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
