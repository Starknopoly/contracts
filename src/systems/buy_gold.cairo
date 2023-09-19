#[system]
mod buy_gold {
    use array::ArrayTrait;
    use box::BoxTrait;
    use traits::{Into, TryInto};
    use option::OptionTrait;
    use dojo::world::Context;

    use stark_nopoly::components::player::Player;
    use stark_nopoly::components::eth::ETH;
    use stark_nopoly::components::townhall::Townhall;
    use stark_nopoly::constants::MAX_BUY_GOLD_ETH;

    fn execute(ctx: Context, amount: u128) {
        assert(amount <= 10000, 'exceed max');

        //确保账户存在
        let mut player = get!(ctx.world, ctx.origin, (Player));
        assert(player.joined_time != 0, 'you not join');

        let mut townhall = get!(ctx.world, 1, (Townhall));

        // x * y = k
        // 10 eth => 100000 gold
        let k: u128 = 10 * 10 ^ 18 * 100000;
        let gold_left: u64 = townhall.gold;
        let eth_left: u128 = k / gold_left.into();
        let price: u128 = eth_left / gold_left.into();

        let gold_left_new: u128 = gold_left.into() - amount;
        let eth_left_new: u128 = k / gold_left_new;
        let eth_need:u128 = eth_left_new - eth_left;

        let mut eth = get!(ctx.world, ctx.origin, (ETH));
        assert(eth.balance >= eth_need, 'ETH is not enough');
        assert(player.total_used_eth + eth_need < MAX_BUY_GOLD_ETH, 'exceed max buy amount');

        eth.balance -= eth_need;
        player.total_used_eth += eth_need;

        let amount_u64: u64 = amount.try_into().unwrap();
        player.gold += amount_u64;
        townhall.gold -= amount_u64;

        set!(ctx.world, (player, eth, townhall));

        return ();
    }
}
