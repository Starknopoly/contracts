#[system]
mod explode {
    use array::ArrayTrait;
    use box::BoxTrait;
    use traits::{Into, TryInto};
    use option::OptionTrait;
    use dojo::world::Context;

    use stark_nopoly::components::player::Player;
    use stark_nopoly::components::land::Land;
    use stark_nopoly::components::townhall::Townhall;
    use stark_nopoly::constants::BOMB_PRICE; 


    fn execute(ctx: Context) {

        let time_now: u64 = starknet::get_block_timestamp(); 

        // 确保账户存在
        let mut player = get !(ctx.world, ctx.origin, (Player));
        assert(player.joined_time != 0, 'you not join');
        // 得到玩家所处位置的地块信息
        let mut land = get !(ctx.world, player.position, (Land));
 		let mut townhall = get !(ctx.world, 1, (Townhall));

        let bomb_price: u64 = BOMB_PRICE.try_into().unwrap();
        assert(player.gold > bomb_price, 'gold not enough'); //确保有足够资金购买 炸弹
        player.gold -= bomb_price;
		townhall.gold += bomb_price;
		land.bomb = true;
		land.bomber = ctx.origin;

        set !(ctx.world, (player, townhall, land)); 
        return ();
    }

}