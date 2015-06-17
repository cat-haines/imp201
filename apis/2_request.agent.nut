http.onrequest(function(request, resp) {
    resp.send(200, http.jsonencode(request));
});
