#[system]
mod build {
    use array::ArrayTrait;
    use box::BoxTrait;
    use traits::{Into, TryInto};
    use option::OptionTrait;
    use dojo::world::Context;

    use stark_nopoly::components::player::Player;
    use stark_nopoly::components::land::Land;
    use stark_nopoly::constants::MAX_MAP;

    #[derive(Serde, Drop)]
    enum Building {
        Nothing: (),
        Hotel: (),
        Bank: (),
        Starkbucks: (),
    }

    impl BuildingIntoU64 of Into<Building, u64> {
        fn into(self: Building) -> u64 {
            match self {
                Building::Nothing(()) => 0,
                Building::Hotel(()) => 100,
                Building::Bank(()) => 500,
                Building::Starkbucks(()) => 1000,
            }
        }
    }


    fn execute(ctx: Context, building: Building) {

        let max_map: u64 = MAX_MAP.try_into().unwrap();
        let time_now: u64 = starknet::get_block_timestamp(); 

        // 确保账户存在
        let mut player = get !(ctx.world, ctx.origin, (Player));
        assert(player.joined_time != 0, 'you not join'); 
        // 得到玩家所处位置的地块信息
        let mut land = get !(ctx.world, player.position, (Land));
        // 如果要在该地块建造地产，该地块应为无主地块
        assert(land.owner == starknet::contract_address_const::<0x0>(), 'has been developed');
        land.owner = ctx.origin;
    
        let (building_type, building_price) = get_building_object(building);
        assert(building_type > 0, 'illegal building_type');
        land.building_type = building_type;
        land.price += building_price; // 地价 == 建设价
        player.gold -= building_price; // 玩家建筑所花费的金币直接烧掉？或存入国库？
        assert(player.gold >= 0, 'gold not enaugh');
        set !(ctx.world, (player,land));
        return ();
    }

    fn get_building_object(building: Building) -> (u64,u64) {
        match building {
            Building::Nothing(()) => (0,0),
            Building::Hotel(()) => (1,100),
            Building::Bank(()) => (2,500),
            Building::Starkbucks(()) => (3,1000),
        }
    }
}