class StudentCoin {

   final int alphaCoin;
   final int sigmaCoin;
   final int xp;
   final int level;

    StudentCoin({
      required this.alphaCoin,
      required this.sigmaCoin,
      required this.xp,
      required this.level
    });

    factory StudentCoin.fromMap(Map data){
      return StudentCoin(
        alphaCoin: data["alpha_coin"],
        sigmaCoin: data["sigma_coin"],
        xp: data["xp"],
        level: data["level"]
      );
    }

}