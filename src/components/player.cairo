//玩家

use starknet::ContractAddress;

#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct Player {
    #[key]
    id: ContractAddress,    // 玩家钱包地址
    nick_name: felt252,     // 玩家昵称
    joined_time:u64, // 加入时间(区块时间戳)
    direction:u64, //1:顺时针  2：逆时针 (目前均为顺时针)
    gold:u64, // 金币数量
    position: u64,  // 位置（出生时随机）
    steps:u64, // 可用步数(可投掷骰子的次数)
    last_point:u64, // 最近一次掷出的点数
    last_time:u64, // 最近一次掷骰子的时间(区块时间戳)
    total_steps:u64, //玩家当前总共走的步数
    banks: u64,
}