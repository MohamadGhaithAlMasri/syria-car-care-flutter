import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:syria_car_care2/features/account/domain/entities/user_address.dart';
import '../../domain/entities/account_info.dart';
import '../../domain/entities/wallet_transaction.dart';
import '../../domain/usecases/get_account_info.dart';
import '../../domain/usecases/get_transactions.dart';
import '../../domain/usecases/recharge_wallet.dart';
import '../../domain/usecases/upgrade_plan.dart';
import '../../domain/usecases/upload_avatar.dart';
import '../../domain/usecases/get_addresses.dart';
import '../../domain/usecases/save_address.dart';
import '../../../../core/usecases/usecase.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetAccountInfo getAccountInfo;
  final GetTransactions getTransactions;
  final RechargeWallet rechargeWallet;
  final UpgradePlan upgradePlan;
  final UploadAvatar uploadAvatar;
  final GetAddresses getAddresses;
  final SaveAddress saveAddress;
  bool _isFetchingTransactions = false;

  AccountBloc({
    required this.getAccountInfo,
    required this.getTransactions,
    required this.rechargeWallet,
    required this.upgradePlan,
    required this.uploadAvatar,
    required this.getAddresses,
    required this.saveAddress,
  }) : super(AccountInitial()) {
    on<GetAccountInfoEvent>(_onGetAccountInfo);
    on<GetTransactionsEvent>(_onGetTransactions);
    on<RechargeWalletEvent>(_onRechargeWallet);
    on<UpgradePlanEvent>(_onUpgradePlan);
    on<UploadAvatarEvent>(_onUploadAvatar);
    on<GetAddressesEvent>(_onGetAddresses);
    on<SaveAddressEvent>(_onSaveAddress);
  }

  Future<void> _onGetAccountInfo(
    GetAccountInfoEvent event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    final result = await getAccountInfo();

    // Also fetch transactions and addresses to have a complete state
    final transResult = await getTransactions();
    final addrResult = await getAddresses(NoParams());

    result.fold((failure) => emit(AccountError(failure.message)), (
      accountInfo,
    ) {
      final transactions = transResult.fold(
        (_) => <WalletTransaction>[],
        (t) => t,
      );
      final addresses = addrResult.fold((_) => <UserAddress>[], (a) => a);
      emit(
        AccountLoaded(
          accountInfo: accountInfo,
          transactions: transactions,
          addresses: addresses,
        ),
      );
    });
  }

  Future<void> _onGetTransactions(
    GetTransactionsEvent event,
    Emitter<AccountState> emit,
  ) async {
    if (_isFetchingTransactions) return;
    
    final currentState = state;
    if (currentState is AccountLoaded) {
      _isFetchingTransactions = true;
      final result = await getTransactions();
      _isFetchingTransactions = false;
      result.fold(
        (failure) => emit(AccountError(failure.message)),
        (transactions) => emit(
          AccountLoaded(
            accountInfo: currentState.accountInfo,
            transactions: transactions,
            addresses: currentState.addresses,
          ),
        ),
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

    result.fold((failure) => emit(AccountError(failure.message)), (_) {
      emit(RechargeSuccess());
      add(GetAccountInfoEvent()); // Refresh data after success
    });
  }

  Future<void> _onUpgradePlan(
    UpgradePlanEvent event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    final result = await upgradePlan(event.planName, event.price);

    result.fold((failure) => emit(AccountError(failure.message)), (_) {
      emit(UpgradePlanSuccess());
      add(GetAccountInfoEvent()); // Refresh data after success
    });
  }

  Future<void> _onUploadAvatar(
    UploadAvatarEvent event,
    Emitter<AccountState> emit,
  ) async {
    final currentState = state;
    if (currentState is AccountLoaded) {
      final result = await uploadAvatar(event.filePath);
      result.fold(
        (failure) => emit(AccountError(failure.message)),
        (_) => add(GetAccountInfoEvent()), // Refresh info to get new URL
      );
    }
  }

  Future<void> _onGetAddresses(
    GetAddressesEvent event,
    Emitter<AccountState> emit,
  ) async {
    final currentState = state;
    if (currentState is AccountLoaded) {
      final result = await getAddresses(NoParams());
      result.fold(
        (failure) => emit(AccountError(failure.message)),
        (addresses) => emit(
          AccountLoaded(
            accountInfo: currentState.accountInfo,
            transactions: currentState.transactions,
            addresses: addresses,
          ),
        ),
      );
    } else {
      add(GetAccountInfoEvent());
    }
  }

  Future<void> _onSaveAddress(
    SaveAddressEvent event,
    Emitter<AccountState> emit,
  ) async {
    final result = await saveAddress(event.address);
    result.fold(
      (failure) => emit(AccountError(failure.message)),
      (_) => add(GetAccountInfoEvent()), // Refresh info
    );
  }
}
