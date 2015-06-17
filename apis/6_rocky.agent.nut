#require "rocky.class.nut:1.1.1"

const API_KEY = "cat";

states <- {
    "off": [0,0,0],
    "on": [50,50,50]
};

state <- states["off"];


app <- Rocky();

app.get("/", function(context) {
    context.send(state);
});


app.get("/set", function(context) {
    local req = context.req;

    if (!("state" in req.query && req.query["state"] in states)) {
        context.send({ "message": "You must include ?state=1 or ?state=0" });
        return;
    }

    state = states[req.query.state];
    device.send("color", state);
    context.send(state);
}).authorize(function(context) {
    return ("x-api-key" in context.req.headers && context.req.headers["x-api-key"] == API_KEY);
});
