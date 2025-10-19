import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roqqu_test/core/theme/app_colors.dart';
import 'package:roqqu_test/features/home/presentation/bloc/coin_list_bloc.dart';
import 'package:roqqu_test/features/home/presentation/bloc/coin_list_event.dart';
import 'package:roqqu_test/features/home/presentation/bloc/coin_list_state.dart';
import 'coin_list_item.dart';

class CoinListSection extends StatefulWidget {
  const CoinListSection({super.key});

  @override
  State<CoinListSection> createState() => _CoinListSectionState();
}

class _CoinListSectionState extends State<CoinListSection> {
  @override
  void initState() {
    super.initState();
    context.read<CoinListBloc>().add(SubscribeToCoinTickers(['BTC', 'ETH', 'BNB', 'XRP']));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Listed Coins', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            TextButton(onPressed: () {}, child: const Text('See all', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.accentBlue),)),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.tertiaryBackground),
            color: AppColors.bottomContainerBackground,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: BlocBuilder<CoinListBloc, CoinListState>(
            builder: (context, state) {
              if (state is CoinListLoading || state is CoinListInitial) {
                return const Center(child: Padding(padding: EdgeInsets.all(32.0), child: CircularProgressIndicator()));
              }
              if (state is CoinListLoaded) {
                final coins = state.coins.values.toList();
                return Container(
                  
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: coins.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CoinListItem(coin: coins[index]);
                    },
                  ),
                );
              }
              if (state is CoinListError) {
                return Center(child: Padding(padding: const EdgeInsets.all(32.0), child: Text('Error: ${state.message}')));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}