#[system]
mod build {
    use array::ArrayTrait;
    use box::BoxTrait;
    use traits::{Into, TryInto};
    use option::OptionTrait;
    use dojo::world::Context;

    use stark_nopoly::components::player::Player;
    use stark_nopoly::components::land::Land;
    use stark_nopoly::components::building::Building;
    use stark_nopoly::constants::MAX_MAP;


    fn execute(ctx: Context, building_type: u64) {

        let max_map: u64 = MAX_MAP.try_into().unwrap();
        let time_now: u64 = starknet::get_block_timestamp(); 

        // 确保账户存在
        let mut player = get !(ctx.world, ctx.origin, (Player));
        assert(player.joined_time != 0, 'you not join'); 
        // 得到玩家所处位置的地块信息
        let mut land = get !(ctx.world, player.position, (Land));
        let mut building = get !(ctx.world, building_type, (Building));
        // 如果要在该地块建造地产，该地块应为无主地块，或自己名下的地块
        assert(land.owner == starknet::contract_address_const::<0x0>() || land.owner == ctx.origin, 'not land owner');
        // 如果该地块为无主地块，则地块的 owner 更新为第一个在此处建造的人
        if land.owner == starknet::contract_address_const::<0x0>() {
            land.owner = ctx.origin;
        }
        assert(building.price != 0, 'illegal building'); //避免传入未初始化的建筑类型编号
        land.building_type = building_type;
        player.gold -=  building.price; // 玩家建筑所花费的金币直接烧掉？或存入国库？
        assert(player.gold >= 0, 'gold not enaugh');
        land.price += building.price; // 地价 == 历次的建设价
        set !(ctx.world, (player,land));
        return ();
    }

}