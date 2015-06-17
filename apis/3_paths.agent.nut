const API_KEY = "cat";

states <- {
    "off": [0,0,0],
    "on": [50,50,50]
};

state <- states["off"];

function requestHandler(req, resp) {
    local path = req.path.tolower();
    if(path == "/set" || path == "/set/") {
        // Check for query parameter
        if("state" in req.query && req.query.state in states) {
            state = states[req.query.state];
            device.send("color", state);
            resp.send(200, http.jsonencode(state));
            return;
        } else {
            resp.send(400, http.jsonencode({ "Message": "Required query parameter 'state' must be 'on' or 'off'" }));
            return;
        }
    }

    resp.send(200, http.jsonencode(state));
}

http.onrequest(requestHandler);
