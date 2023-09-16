#[system]
mod supplement {
    use array::ArrayTrait;
    use box::BoxTrait;
    use traits::{Into, TryInto};
    use option::OptionTrait;
    use dojo::world::Context;

    use stark_nopoly::components::player::Player;
    use stark_nopoly::components::land::Land;
    use stark_nopoly::components::townhall::Townhall;


    fn execute(ctx: Context, amounts: u64) {

        // 确保账户存在
        let mut player = get !(ctx.world, ctx.origin, (Player));
        assert(player.joined_time != 0, 'you not join'); 

        // 得到玩家所处位置的地块信息
        let mut land = get !(ctx.world, player.position, (Land));
 		let mut townhall = get !(ctx.world, 1, (Townhall));
        assert(land.building_type == 3, 'is not starkbucks'); 

        player.steps += amounts; 
        player.gold  -= amounts * 100;
        townhall.gold +=  amounts * 100;
        assert(player.gold >= 0, 'gold not enaugh');

        set !(ctx.world, (player,townhall));
        return ();
    }

}