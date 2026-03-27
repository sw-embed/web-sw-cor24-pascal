pub mod demos;

use demos::DEMOS;
use web_sys::HtmlSelectElement;
use yew::prelude::*;

#[function_component(App)]
pub fn app() -> Html {
    let selected = use_state(|| 0_usize);

    let on_select = {
        let selected = selected.clone();
        Callback::from(move |e: Event| {
            let target: HtmlSelectElement = e.target_unchecked_into();
            if let Ok(idx) = target.value().parse::<usize>() {
                selected.set(idx);
            }
        })
    };

    let demo = &DEMOS[*selected];

    html! {
        <div id="app-root">
            <h1>{"Pascal Demos"}</h1>
            <div class="toolbar">
                <select onchange={on_select}>
                    { for DEMOS.iter().enumerate().map(|(i, d)| html! {
                        <option value={i.to_string()} selected={i == *selected}>
                            { d.name }
                        </option>
                    })}
                </select>
            </div>
            <div class="panels">
                <div class="panel">
                    <h2>{"Pascal Source"}</h2>
                    <pre>{ demo.pas_source }</pre>
                </div>
                <div class="panel">
                    <h2>{"P-Code Assembly (.spc)"}</h2>
                    <pre>{ demo.spc_source }</pre>
                </div>
            </div>
        </div>
    }
}
