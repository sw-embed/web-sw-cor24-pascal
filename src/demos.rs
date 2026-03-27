//! Demo registry — Pascal source + pre-compiled p-code assembly pairs.
//!
//! Each demo embeds a .pas file (Pascal source, displayed read-only) and
//! a .spc file (pre-compiled p-code assembly, fed to linker at runtime).
//! The runtime library .spc is also embedded for linking.

/// A demo entry with Pascal source and p-code assembly.
pub struct Demo {
    pub name: &'static str,
    pub description: &'static str,
    pub pas_source: &'static str,
    pub spc_source: &'static str,
}

/// Runtime library .spc source (linked with every demo).
pub const RUNTIME_SPC: &str = include_str!("../../pr24p/src/runtime.spc");

/// Available demo programs.
pub const DEMOS: &[Demo] = &[
    Demo {
        name: "Hello World",
        description: "Print Hello, World! and a newline",
        pas_source: include_str!("../demos/hello.pas"),
        spc_source: include_str!("../demos/hello.spc"),
    },
    Demo {
        name: "Countdown",
        description: "Count down from 5 to 1",
        pas_source: include_str!("../demos/countdown.pas"),
        spc_source: include_str!("../demos/countdown.spc"),
    },
];
