#[system]
mod spawn {
    use array::ArrayTrait;
    use box::BoxTrait;
    use traits::{Into, TryInto};
    use option::OptionTrait;
    use dojo::world::Context;

    use stark_nopoly::components::player::Player;
    use stark_nopoly::constants::MAX_MAP;
    use stark_nopoly::constants::INIT_GOLD;
    use stark_nopoly::constants::INIT_STEPS;    

    fn execute(ctx: Context, nick_name: felt252 ) {
        let max_map: u64 = MAX_MAP.try_into().unwrap();
        let init_gold: u64 = INIT_GOLD.try_into().unwrap();
        let init_steps: u64 = INIT_STEPS.try_into().unwrap();
        //fn get_block_timestamp() -> u64{get_block_info().unbox().block_timestamp}
        let time_now: u64 = starknet::get_block_timestamp(); 

        let player = get !(ctx.world, ctx.origin, (Player));
        assert(player.joined_time == 0, 'you have joined!');

        let random_position: u64 = time_now % max_map + 1;//生成随机位置(伪随机数)

        set!(
            ctx.world,
            (
                Player {
                    id: ctx.origin, // 玩家钱包地址
                    nick_name: nick_name,
                    joined_time:time_now, 
                    direction: 1_u64, //1:顺时针  2：逆时针
                    gold: init_gold,
                    position: random_position, 
                    steps: init_steps,
                    last_point:0_u64, 
                    last_time:0_u64,
                    total_steps:0_u64,
                    banks: 0_u64,
                },
            )
        );
        return ();
    }
}