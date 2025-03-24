using Bonito, Observables
using Bonito: Button, App, DOM, onjs

# Create the app
counter = Observable(0)

# Create the app layout
app = App() do session
    # Button element with JavaScript code for interaction
    button = Button("Click me!", onclick=js"""(e) => {
        // Increment the counter in Julia when the button is clicked
        $(counter).notify($(counter).value + 1)
    }""")

    # Listen for changes in the counter observable using `onjs`
    onjs(session, counter, js"""function (v) {
        console.log("Counter updated to: " + v);
    }""")

    # Display the current counter value
    return DOM.div(
        button, DOM.h1("Counter: ", counter)
    )
end

# Start the server on port 8080
port = 8080
server = Bonito.Server(app, "0.0.0.0", port)
println("Server running at http://localhost:$port")
wait(server)
