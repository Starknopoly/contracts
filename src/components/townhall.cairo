//国库
#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct Townhall {
    #[key]
    id: u64,
    gold: u64,// 由admin进行初始化设置。
}