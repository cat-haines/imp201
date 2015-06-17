#require "WS2812.class.nut:2.0.0"

spi <- hardware.spi257;
spi.configure(MSB_FIRST, 7500);
display <- WS2812(spi, 5);

agent.on("color", function(color) {
    display.fill(color);
    display.draw();
});
