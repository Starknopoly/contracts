use traits::{Into, TryInto};
use array::ArrayTrait;


fn random(seed: u64) -> u64  {
    let seed_felt: felt252 = seed.into();
    let mut rolling_seed_arr: Array<felt252> = ArrayTrait::new();
    rolling_seed_arr.append(seed_felt);
    rolling_seed_arr.append(seed_felt * 7);
    rolling_seed_arr.append(seed_felt * 29);

    let rolling_hash: u256 = poseidon::poseidon_hash_span(rolling_seed_arr.span()).into();
    let x: u64 = (rolling_hash.low & 0x0000000000000000ffffffffffffffff).try_into().unwrap();
    x
}



#[test]
#[available_gas(30000000)]
use debug::PrintTrait;
fn test_random() {

    let mut seed  = starknet::get_block_timestamp();   
    let result = random(seed);
}