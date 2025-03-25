using Bonito, Observables
using Bonito: Button, App, DOM

logged_in = Observable(false)
app = App() do session
    username = Observable("")
    password = Observable("")

    login_form = DOM.div(
        DOM.input(placeholder="Username", type="text", onchange=js"""(e) => {
            $(username).notify(e.target.value);
        }"""),
        DOM.input(placeholder="Password", type="password", onchange=js"""(e) => {
            $(password).notify(e.target.value);
        }"""),
        Button("Login", onclick=js"""(e) => {
            if($(username).value != "" && $(password).value != "") {
                console.log("Logged in as: " + $(username).value);
                $(logged_in).notify(true);
            }
        }""")
    )
    
    # Use map to create a reactive DOM element based on login state
    content = map(logged_in) do t
        t ? DOM.div("You are logged in!") : login_form
    end
    
    return DOM.div(content)
end

port = 8080
server = Bonito.Server(app, "0.0.0.0", port)
println("Server running at http://localhost:$port")
wait(server)