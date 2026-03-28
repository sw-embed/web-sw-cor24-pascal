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
    Demo {
        name: "Fibonacci",
        description: "First 10 Fibonacci numbers",
        pas_source: include_str!("../demos/fibonacci.pas"),
        spc_source: include_str!("../demos/fibonacci.spc"),
    },
    Demo {
        name: "Primes",
        description: "Prime numbers up to 20",
        pas_source: include_str!("../demos/primes.pas"),
        spc_source: include_str!("../demos/primes.spc"),
    },
    Demo {
        name: "Collatz",
        description: "Collatz sequence from 27 (111 steps)",
        pas_source: include_str!("../demos/collatz.pas"),
        spc_source: include_str!("../demos/collatz.spc"),
    },
    Demo {
        name: "For Loop",
        description: "Sum 1..10, then count down 5 to 1",
        pas_source: include_str!("../demos/forloop.pas"),
        spc_source: include_str!("../demos/forloop.spc"),
    },
    Demo {
        name: "Factorial",
        description: "Compute 10! = 3628800",
        pas_source: include_str!("../demos/factorial.pas"),
        spc_source: include_str!("../demos/factorial.spc"),
    },
    Demo {
        name: "Even/Odd",
        description: "Print 1..10 with sign by parity",
        pas_source: include_str!("../demos/evenodd.pas"),
        spc_source: include_str!("../demos/evenodd.spc"),
    },
    Demo {
        name: "Powers of 2",
        description: "2^1 through 2^12",
        pas_source: include_str!("../demos/powers.pas"),
        spc_source: include_str!("../demos/powers.spc"),
    },
    Demo {
        name: "Write",
        description: "write() without newline, for loop",
        pas_source: include_str!("../demos/write.pas"),
        spc_source: include_str!("../demos/write.spc"),
    },
    Demo {
        name: "Std Library",
        description: "Abs, Sqr, Succ, Pred, Odd",
        pas_source: include_str!("../demos/stdlib.pas"),
        spc_source: include_str!("../demos/stdlib.spc"),
    },
];
