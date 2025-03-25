using Bonito, Observables
using Bonito: Button, App, DOM

# Create an Observable array to store todos
todo_list = Observable(String[])  # Initialize as empty string array

app = App() do
    new_todo = Observable("")  # Store the current input value
    
    input = DOM.input(
        placeholder="Type here....", 
        type="text", 
        value=new_todo,
        onchange=js"""(e) => {
            $(new_todo).notify(e.target.value);
        }"""
    )
    
    button = Button("Add", onclick=js"""(e) => {
        // Only add non-empty todos
        if($(new_todo).value.trim() !== "") {
            $(todo_list).notify([...$(todo_list).value, $(new_todo).value]);
            // Clear the input
            document.querySelector('input').value = "";
            $(new_todo).notify("");
        }
    }""")
    
    return DOM.div(
        DOM.div(input, button),
        DOM.ul(
            map(todo_list) do todos
            [DOM.li(
                DOM.span(todo),
                Button("❌", onclick=js"""(e) => {
                    const updated = $(todo_list).value.filter(t => t !== $(todo));
                    $(todo_list).notify(updated);
                }""")
            ) for todo in todos]
            end
        )
    )
end

port = 8080
server = Bonito.Server(app, "0.0.0.0", port)
println("Server running at http://localhost:$port")
wait(server)
