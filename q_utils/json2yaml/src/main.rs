use serde_json::Value;
use std::io::Read;

fn json_2_yaml(json: &str) -> Result<String, String> {
    let raw = serde_json::from_str::<Value>(json).map_err(|v| v.to_string())?;
    serde_yaml::to_string(&raw).map_err(|e| e.to_string())
}

fn main() -> Result<(), String> {
    let mut buffer = String::new();
    std::io::stdin().read_to_string(&mut buffer).unwrap();
    println!("{}", json_2_yaml(&buffer)?);
    Ok(())
}
