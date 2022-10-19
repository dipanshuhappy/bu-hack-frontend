class StaffCoin {


  final int sigmaCoin;


  StaffCoin({

    required this.sigmaCoin,

  });

  factory StaffCoin.fromMap(Map data){
    return StaffCoin(
        sigmaCoin: data["sigma_coin"],
    );
  }

}