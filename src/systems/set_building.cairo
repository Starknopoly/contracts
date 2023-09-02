#[system]
mod set_building {
    use array::ArrayTrait;
    use box::BoxTrait;
    use traits::{Into, TryInto};
    use option::OptionTrait;
    use dojo::world::Context;

    use stark_nopoly::components::building::Building;

    //初始化建筑物类型及其价格
    fn execute(ctx: Context, building_type: u64, price: u64) {
        set!(
                ctx.world,
                (
                    Building {
                        building_type: building_type,
                        price: price, 
                    },
                )
            );
            return ();
    }

}