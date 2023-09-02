// 建筑物
// building_type 为可在Land 上修建的建筑物的种类
// 1 为酒店，2为银行，3为 Starkbucks

#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct Building {
    #[key]
    building_type: u64,// 由admin进行初始化设置。
    price:u64, // // 由admin进行初始化设置。
}