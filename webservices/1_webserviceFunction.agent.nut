function trigger(key, eventName, data = {}) {
    local url = "https://maker.ifttt.com/trigger/" + eventName + "/with/key/" + key;
    local headers = {
        "content-type": "application/json"
    };
    local body = http.jsonencode(data);

    http.post(url, headers, body).sendasync(function(resp) {
        if(200 > resp.statuscode || resp.statuscode >= 300) {
            server.error(resp.body)
            return;
        }
        server.log("Success!");
    });
}

trigger("<-- YOUR-KEY -->", "ping");
