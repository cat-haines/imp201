#require "Si702x.class.nut:1.0.0"

const SLEEP_TIME = 5;

// Check if nv exists, and create it if not
if (!("nv" in getroottable() && "data" in nv)) {
    nv <- { "data": [] };
}

i2c <- hardware.i2c89;
i2c.configure(CLOCK_SPEED_400_KHZ);
tempHumid <- Si702x(i2c);

function readAndSend() {

    local result = tempHumid.read();
    result["ts"] <- time();
    nv.data.push(result);

    if (nv.data.len() >= 3) {
        agent.send("data", nv.data);
        server.flush(30); // make sure we send the data before clearing it
        nv.data.clear();
    }
}

readAndSend();
imp.onidle(function() { imp.deepsleepfor(SLEEP_TIME); });
