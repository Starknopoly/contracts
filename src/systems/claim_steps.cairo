#[system]
mod claim_steps {
    use array::ArrayTrait;
    use box::BoxTrait;
    use traits::{Into, TryInto};
    use option::OptionTrait;
    use dojo::world::Context;

    use stark_nopoly::components::player::Player;

    fn execute(ctx: Context) {

        let time_now: u64 = starknet::get_block_timestamp(); 

        //确保账户存在
        let mut player = get !(ctx.world, ctx.origin, (Player));
        assert(player.joined_time != 0, 'you not join');
        assert(player.gold > 0, 'gold not enough');

        let last_claim_hour:u64= player.last_claim_time / 3600;     
        let cur_hour: u64 = time_now / 3600;

        // 如果当前小时数大于上次领取小时数，那么用户可以领取一次体力
        assert(last_claim_hour == 0_u64 || last_claim_hour < cur_hour, 'you have claimed this hour');
        
        player.steps += 10_u64;
        player.last_claim_time = time_now;
        set !(ctx.world, (player));

        return ();
    }
}

#[system]
mod view_next_claim_time {
    use dojo::world::Context;
    use starknet::ContractAddress;
    use stark_nopoly::components::player::Player;

    fn execute(ctx: Context, player_id: ContractAddress) -> Player {
         let player = get !(ctx.world, player_id, (Player));
         return player;
    }
}

// #[cfg(test)]
// mod tests {
//     use debug::PrintTrait;
//     use super::{Position, PositionTrait};

//     #[test]
//     #[available_gas(100000)]
//     fn test_player() {
       
//     }
// }