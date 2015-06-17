device.on("data", function(data) {
    server.log(http.jsonencode(data));
});
