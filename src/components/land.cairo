// 土地
// 对应地图里100个格子的地块, 初始owner = 0x00
// 由第一个对该地块进行开发（建造建筑物）的玩家进行初始化
use starknet::ContractAddress;

#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct Land {
    #[key]
    position: u64,    // 由 building（）进行初始化
    owner:ContractAddress, // 地块主人
    building_type: u64, // 地面建筑物类型
    price: u64, // 该地块的综合价格(历次建筑的价格总和)
    bomb: bool,
    bomber: ContractAddress,
    bomb_price: u64,
}