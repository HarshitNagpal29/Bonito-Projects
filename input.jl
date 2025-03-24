using Bonito, Observables
using Bonito: Button, App, DOM, onjs


text_input = Observable("")  
app = App() do  
    input = DOM.input(placeholder="Type here...", type="text", value=text_input[], 
        onchange=js"""(e) => {
        $(text_input).notify(e.target.value)
    }""")
    return DOM.div(input, DOM.p("You typed: ", text_input))  
end  

port = 8080
server = Bonito.Server(app, "0.0.0.0", port)
println("Server running at http://localhost:$port")
wait(server)