states <- {
    "off": [0,0,0],
    "on": [50,50,50]
};

state <- states["off"];

function requestHandler(req, resp) {
    // Check for query parameter
    if("state" in req.query && req.query.state in states) {
        state = states[req.query.state];
        device.send("color", state);
        resp.send(200, http.jsonencode(state));
        return;
    }

    resp.send(200, http.jsonencode(state));
}

http.onrequest(requestHandler);
