#[system]
mod buy {
    use array::ArrayTrait;
    use box::BoxTrait;
    use traits::{Into, TryInto};
    use option::OptionTrait;
    use dojo::world::Context;

    use stark_nopoly::components::player::Player;
    use stark_nopoly::components::land::Land;
    use stark_nopoly::components::townhall::Townhall;


    fn execute(ctx: Context) {

        let time_now: u64 = starknet::get_block_timestamp(); 

        // 确保账户存在
        let mut player = get !(ctx.world, ctx.origin, (Player));
        assert(player.joined_time != 0, 'you not join');
        // 得到玩家所处位置的地块信息
        let mut land = get !(ctx.world, player.position, (Land));
        // 确保所在地块不是自己的地块，也不是无主地块
        assert(land.owner != starknet::contract_address_const::<0x0>() && land.owner != ctx.origin, 'your land or null');
		
        //确保土地性质为商业用地
         let build_permit: bool = build_permit(player.position);
         assert(build_permit, 'can not build here');

        let mut player2 = get !(ctx.world, land.owner, (Player));
 		let mut townhall = get !(ctx.world, 1, (Townhall));

        assert(player.gold >= (land.price * 13)/10, 'gold not enough'); //确保有足够资金，以130%价格强制收购对方地块
        player.gold -= (land.price * 13)/10;
		player2.gold += (land.price * 12)/10;
		townhall.gold += (land.price * 1)/10;//国库收税
		land.owner = ctx.origin; // 地权转移
		land.price = (land.price * 13)/10; //地价更新

        // 如果是银行
        if land.building_type == 2{
            player.banks  += 1;
            player2.banks -= 1;
        }

        set !(ctx.world, (player,player2,townhall,land)); 
        return ();
    }


    fn build_permit(land_id: u64) -> bool {

        let land_id_felt:felt252 = land_id.into();
        let mut building_seed_arr:Array<felt252> = ArrayTrait::new();
        building_seed_arr.append(land_id_felt);
        building_seed_arr.append(2023);
        building_seed_arr.append(1024);

        let build_permit_hash = poseidon::poseidon_hash_span(building_seed_arr.span());
        let x: u256 = build_permit_hash.into();
        let permit = x % 4 ;
        if permit != 0 {
            false
        }else{
            true
        }
    }

}