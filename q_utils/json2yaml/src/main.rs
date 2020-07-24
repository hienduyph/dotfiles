use serde_json::Value;
use std::io::Read;

fn json_2_yaml(json: &str) -> String {
    let map: Value = serde_json::from_str(json).unwrap();
    return serde_yaml::to_string(&map).unwrap();
}

fn main() {
    let mut buffer = String::new();
    std::io::stdin().read_to_string(&mut buffer).unwrap();
    println!("{}", json_2_yaml(&buffer));
}
