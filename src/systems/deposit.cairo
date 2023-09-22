use starknet::ContractAddress; 
#[starknet::interface]
trait IERC20<TContractState> {
    fn name(self: @TContractState) -> felt252;
    fn symbol(self: @TContractState) -> felt252;
    fn decimals(self: @TContractState) -> u8;
    fn total_supply(self: @TContractState) -> u256;
    fn balanceOf(self: @TContractState, account: ContractAddress) -> u256;
    fn allowance(self: @TContractState, owner: ContractAddress, spender: ContractAddress) -> u256;
    fn transfer(ref self: TContractState, to: ContractAddress, amount: u256) -> bool;
    fn transferFrom(
        ref self: TContractState, from: ContractAddress, to: ContractAddress, amount: u256
    ) -> bool;
    fn approve(ref self: TContractState, spender: ContractAddress, amount: u256) -> bool;
    fn mint(ref self: TContractState, amount: u256);
}

#[system]
mod deposit {
    use array::ArrayTrait;
    use box::BoxTrait;
    use traits::Into;
    use dojo::world::Context;
    use debug::PrintTrait;
    use starknet::get_contract_address;
    use super::IERC20DispatcherTrait;
    use super::IERC20Dispatcher;
    use stark_nopoly::components::player::Player;
    use stark_nopoly::components::townhall::Townhall;


    fn execute(ctx: Context, amount: u64) {

        // 确保账户存在
        let mut player = get !(ctx.world, ctx.origin, (Player));
        assert(player.joined_time != 0, 'you not join'); 
        let mut townhall = get !(ctx.world, 1, (Townhall));

        //发放金币 金库金币初始价格为0.00001e ，10000000000000
        let eth_address = starknet::contract_address_const::<0x049D36570D4e46f48e99674bd3fcc84644DdD6b96F7C741B1562B82f9e004dC7>();
        let dispatcher = IERC20Dispatcher { contract_address: eth_address };
        dispatcher.transferFrom(ctx.origin, get_contract_address(), 10000000000000 * amount.into() );
        player.gold += amount;
        townhall.gold -= amount;
        player.deposit += 10000000000000 * amount;

        return ();
    }

}

