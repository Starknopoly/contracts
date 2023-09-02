#[system]
mod roll {
    use array::ArrayTrait;
    use box::BoxTrait;
    use traits::{Into, TryInto};
    use option::OptionTrait;
    use dojo::world::Context;

    use stark_nopoly::components::player::Player;
    use stark_nopoly::constants::MAX_MAP;


    fn execute(ctx: Context) {

        let max_map: u64 = MAX_MAP.try_into().unwrap();
        let time_now: u64 = starknet::get_block_timestamp(); 

        //确保账户存在，并获取账户实例
        let mut player = get !(ctx.world, ctx.origin, (Player));
        assert(player.joined_time != 0, 'you not join');
        assert(player.steps > 0, 'steps not enough');

        let rolling: u64 = time_now % 5 + 1;//生成一个1-6的（伪）随机数
        player.steps -= 1;
        player.last_point = rolling;
        player.last_time = time_now;

        //记录玩家投掷后的位置
        if player.position + rolling <= max_map {
                player.position = player.position + rolling;         
            } else {
                player.position = player.position + rolling - max_map;
            }
        set !(ctx.world, (player));
        return ();
    }
}