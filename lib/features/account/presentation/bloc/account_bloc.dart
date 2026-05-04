import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/account_info.dart';
import '../../domain/entities/wallet_transaction.dart';
import '../../domain/usecases/get_account_info.dart';
import '../../domain/usecases/get_transactions.dart';
import '../../domain/usecases/recharge_wallet.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetAccountInfo getAccountInfo;
  final GetTransactions getTransactions;
  final RechargeWallet rechargeWallet;

  AccountBloc({
    required this.getAccountInfo,
    required this.getTransactions,
    required this.rechargeWallet,
  }) : super(AccountInitial()) {
    on<GetAccountInfoEvent>(_onGetAccountInfo);
    on<GetTransactionsEvent>(_onGetTransactions);
    on<RechargeWalletEvent>(_onRechargeWallet);
  }

  Future<void> _onGetAccountInfo(
    GetAccountInfoEvent event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    final result = await getAccountInfo();
    
    // Also fetch transactions to have a complete state
    final transResult = await getTransactions();

    result.fold(
      (failure) => emit(AccountError(failure.message)),
      (accountInfo) {
        final transactions = transResult.fold((_) => <WalletTransaction>[], (t) => t);
        emit(AccountLoaded(accountInfo: accountInfo, transactions: transactions));
      },
    );
  }

  Future<void> _onGetTransactions(
    GetTransactionsEvent event,
    Emitter<AccountState> emit,
  ) async {
    // If already loaded, we might just want to refresh transactions
    final currentState = state;
    if (currentState is AccountLoaded) {
      final result = await getTransactions();
      result.fold(
        (failure) => emit(AccountError(failure.message)),
        (transactions) => emit(AccountLoaded(
          accountInfo: currentState.accountInfo,
          transactions: transactions,
        )),
      );
    } else {
      add(GetAccountInfoEvent());
    }
  }

  Future<void> _onRechargeWallet(
    RechargeWalletEvent event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    final result = await rechargeWallet(event.amount, event.method);
    
    result.fold(
      (failure) => emit(AccountError(failure.message)),
      (_) {
        emit(RechargeSuccess());
        add(GetAccountInfoEvent()); // Refresh data after success
      },
    );
  }
}
