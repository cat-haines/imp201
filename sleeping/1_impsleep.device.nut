#require "Si702x.class.nut:1.0.0"

const SLEEP_TIME = 5;

i2c <- hardware.i2c89;
i2c.configure(CLOCK_SPEED_400_KHZ);
tempHumid <- Si702x(i2c);

function readAndSend() {
    server.log("Reading temperature and humidity data..");
    local result = tempHumid.read();
    agent.send("data", result);

    imp.sleep(SLEEP_TIME);
    readAndSend();
}

readAndSend();
