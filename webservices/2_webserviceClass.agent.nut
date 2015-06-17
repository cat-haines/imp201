class IFTTT {
    static TRIGGER_URL = "https://maker.ifttt.com/trigger/%s/with/key/%s";

    _key = null;

    constructor(key) {
        this._key = key;
    }

    function trigger(eventName, data = {}, cb = null) {
        local url = format(TRIGGER_URL, eventName, _key);
        local headers = {
            "content-type": "application/json"
        };
        local body = http.jsonencode(data);

        http.post(url, headers, body).sendasync(function(resp) {
            if(200 > resp.statuscode || resp.statuscode >= 300) {
                if (cb != null || typeof cb == "function") {
                    imp.wakeup(0, function() { cb(resp.body, resp); });
                }
                return;
            }
            if (cb != null || typeof cb == "function") {
                imp.wakeup(0, function() { cb(null, resp); });
            }
        }.bindenv(this));
    }
}

ifttt <- IFTTT("<-- YOUR-KEY -->");

ifttt.trigger("ping", null, function(err, resp) {
    if(err != null) {
        server.error(err);
        return;
    }

    server.log("Success!!");
});
