#[system]
mod claim_energy {
    use array::ArrayTrait;
    use box::BoxTrait;
    use traits::{Into, TryInto};
    use option::OptionTrait;
    use dojo::world::Context;

    use stark_nopoly::components::player::Player;
    use stark_nopoly::components::energy_recover::EnergyRecover;

    fn execute(ctx: Context) {
        // 确保账户存在
        let mut player = get!(ctx.world, ctx.origin, (Player));
        let mut energy_recover: EnergyRecover = get!(ctx.world, ctx.origin, (EnergyRecover));
        assert(player.joined_time != 0, 'you not join');

        // let time_init =1695441600; // 2023-09-23 12:00:00
        // let time_init = 1695448800; // 2023-09-23 14:00:00
        let time_init = 1695466800; // 2023-09-23 19:00:00

        let time_now: u64 = starknet::get_block_timestamp();
        assert(time_now > time_init, 'not start');
        if (energy_recover.last_recover_time != 0) {
            assert(
                time_now - energy_recover.last_recover_time > 3600 * 21, 'can recover once per day.'
            );
        }
        //18:00:00 - 21:00:00 can claim
        assert(((time_now - time_init) % 86400) < 3600 * 3, 'can not claim now');
        player.steps += 30;
        energy_recover.last_recover_time = time_now;
        set!(ctx.world, (player, energy_recover));

        return ();
    }
}
