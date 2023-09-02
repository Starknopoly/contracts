#[system]
mod supplement {
    use array::ArrayTrait;
    use box::BoxTrait;
    use traits::{Into, TryInto};
    use option::OptionTrait;
    use dojo::world::Context;

    use stark_nopoly::components::player::Player;
    use stark_nopoly::components::townhall::Townhall;


    fn execute(ctx: Context, amounts: u64) {

        // 确保账户存在
        let mut player = get !(ctx.world, ctx.origin, (Player));
        assert(player.joined_time != 0, 'you not join'); 
        let mut townhall = get !(ctx.world, 1, (Townhall));

        player.steps += amounts; 
        player.gold  -= amounts * 10;
        townhall.gold +=  amounts * 10; 
        assert(player.gold >= 0, 'gold not enaugh');

        set !(ctx.world, (player,townhall));
        return ();
    }

}