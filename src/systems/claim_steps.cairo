#[system]
mod claim_steps {
    use array::ArrayTrait;
    use box::BoxTrait;
    use traits::{Into, TryInto};
    use option::OptionTrait;
    use dojo::world::Context;

    use stark_nopoly::components::player::Player;


    fn execute(ctx: Context) {

        // 确保账户存在
        let mut player = get !(ctx.world, ctx.origin, (Player));
        assert(player.joined_time != 0, 'you not join'); 

        let time_init = 1695376800; // 2023-09-22 18:00:00
        let time_now: u64 = starknet::get_block_timestamp();
        //18:00:00 - 21:00:00 can claim
        assert( ((time_now - time_init) % 86400) <= 10800, 'can not claim now');
        player.steps += 20; 
        set !(ctx.world, (player));


        
        return ();
    }

}