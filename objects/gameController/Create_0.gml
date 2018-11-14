randomize();

TimePassed = 0.0;
TimeMax = 1000000.0 / 2;

PreviousKeypress = false;

var Item;

Item = instance_create_layer(8 * 11, 8, "Instances", testObj);
Item.image_index += 5;
Item.Inplay = true;

Item = instance_create_layer(8 * 12, 8, "Instances", testObj);
Item.image_index += 5;
Item.Inplay = true;

Item = instance_create_layer(8 * 13, 8, "Instances", testObj);
Item.image_index += 5;
Item.Inplay = true;