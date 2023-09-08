#[system]
mod roll {
    use array::ArrayTrait;
    use box::BoxTrait;
    use traits::{Into, TryInto};
    use option::OptionTrait;
    use dojo::world::Context;

    use stark_nopoly::components::player::Player;
    use stark_nopoly::components::land::Land;
    use stark_nopoly::components::townhall::Townhall;
    use stark_nopoly::constants::MAX_MAP;


    fn execute(ctx: Context) {

        let max_map: u64 = MAX_MAP.try_into().unwrap();
        let time_now: u64 = starknet::get_block_timestamp(); 

        //确保账户存在
        let mut player = get !(ctx.world, ctx.origin, (Player));
        assert(player.joined_time != 0, 'you not join');
        assert(player.steps > 0, 'steps not enough');   
        assert(player.gold > 0, 'gold not enough');

        let rolling: u64 = time_now % 5 + 1;//生成一个1-6的（伪）随机数
        player.steps -= 1;
        player.last_point = rolling;
        player.last_time = time_now;

        //本轮结算

        // 1.更新玩家投掷后的位置
        let mut new_positon: u64 = 0;
        if player.position + rolling <= max_map {
                new_positon = player.position + rolling;         
            } else {
                new_positon = player.position + rolling - max_map;
            }

        player.position = new_positon;
        let mut land = get !(ctx.world, new_positon, (Land));
        let mut land_owner = get !(ctx.world, land.owner, (Player));
        let mut townhall = get !(ctx.world, 1, (Townhall));

        // 判断是否有地雷
        if land.bomb {
           let mut bomber = get !(ctx.world, land.bomber, (Player));
           if player.gold >= land.bomb_price * 2 {
                player.gold -= land.bomb_price * 2;
                bomber.gold += land.bomb_price * 2;
           } else{   
                bomber.gold += player.gold;
                player.gold = 0;
           }

           land.bomb = false;
           set !(ctx.world, (bomber,land));

        }

        // 2.结算酒店费用。住宿费是酒店总价的10%，9%给酒店所有者，1%放入金库池


        if land.building_type == 1 {
            assert(player.gold > land.price * 10 / 100, 'you lose');
            player.gold -= land.price * 10 / 100 ;
            land_owner.gold += land.price * 9 / 100 ;
            townhall.gold += land.price * 1 / 100 ;
        }

        set !(ctx.world, (player, land_owner, townhall));
        return ();
    }
}