using Bonito, Observables
using Bonito: Button, App, DOM, onjs

app = App() do  
    no1 = Observable(0)
    no2 = Observable(0)
    result = Observable(0)
    input1 = DOM.input(placeholder="Type here...", type="number", value=no1[], 
    onchange=js"""(e) => {
    $(no1).notify(parseInt(e.target.value) || 0)
}""")

    input2 = DOM.input(placeholder="Type here...", type="number", value=no2[], 
    onchange=js"""(e) => {
    $(no2).notify(parseInt(e.target.value) || 0)
}""")
    button = Button("Add", onclick=js"""(e) => {
    $(result).notify(parseInt($(no1).value) + parseInt($(no2).value))
}""")
    return DOM.div(input1, input2, button, DOM.p("Result: ", result))
end  

port = 8080
server = Bonito.Server(app, "0.0.0.0", port)
println("Server running at http://localhost:$port")
wait(server)