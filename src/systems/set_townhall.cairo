#[system]
mod set_townhall {
    use array::ArrayTrait;
    use box::BoxTrait;
    use traits::{Into, TryInto};
    use option::OptionTrait;
    use dojo::world::Context;

    use stark_nopoly::components::townhall::Townhall;

    //初始化国库及资金
    fn execute(ctx: Context) {
        set!(ctx.world, (Townhall { id: 1, gold: 100000, },));
        return ();
    }
}
