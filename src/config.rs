//! PVM binary and label lookup, generated at build time.

pub const PVM_BINARY: &[u8] = include_bytes!(concat!(env!("OUT_DIR"), "/pvm.bin"));
pub const P24P_BINARY: &[u8] = include_bytes!(concat!(env!("OUT_DIR"), "/p24p.bin"));
include!(concat!(env!("OUT_DIR"), "/pvm_labels.rs"));

pub fn label_addr(name: &str) -> u32 {
    PVM_LABELS
        .iter()
        .find(|(n, _)| *n == name)
        .map(|(_, a)| *a)
        .unwrap_or(0)
}
