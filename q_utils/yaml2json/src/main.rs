use serde_yaml::Value;
use std::io::Read;

fn yaml_2_json(json: &str) -> Result<String, String> {
    let raw = serde_yaml::from_str::<Value>(json).map_err(|v| v.to_string())?;
    serde_json::to_string(&raw).map_err(|e| e.to_string())
}

fn main() -> Result<(), String> {
    let mut buffer = String::new();
    std::io::stdin().read_to_string(&mut buffer).unwrap();
    println!("{}", yaml_2_json(&buffer)?);
    Ok(())
}
