use starknet::ContractAddress;

#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct EnergyRecover {
    #[key]
    id: ContractAddress,
    last_recover_time: u64,
}
