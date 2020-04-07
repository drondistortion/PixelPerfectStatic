/* Code for Processing that generates
 * pixel-perfect color or b/w noise
 *
 * Princple of operation:
 *
 *      Frame is generated pixel by pixel
 *      potato-style with random rgb values.
 *      (be patient). Each frame is then
 *      saved as a png file. When all frames
 *      are generated static starts playing
 *      at full speed.
 *
 *      If all files already generated in the
 *      directory, program starts playing
 *      without generating.
 *
 *      When changing display resolution
 *      delete *.png files in the directory
 */

// total number of frames
// to loop. This is not FPS!
// 15 is enough imo.
static int fnumber = 15;

PImage[] img = new PImage[fnumber];
boolean generated = false;
boolean loaded = false;
String filename = "frame-";
int currentFrame = 0;
int frameNumber = 0;

void setup()
{
        //size(100,100);
        fullScreen();
        background(0);
        noSmooth();
        noCursor();
}

void draw()
{
        if (!generated)
                generate();

        else if (!loaded)
                load();

        else
                show();
}

// generates frames and saves them as png's
void generate()
{
        if (!fileExists(sketchPath(filename + frameNumber + ".png"))) {
                for (int x=0; x < width; x++) {
                        for (int y=0; y < height; y++) {
                                // for b/w replace with stroke(random(255));
                                stroke(random(255), random(255), random(255));
                                point(x,y);
                        }
                }
                saveFrame(filename + frameNumber + ".png");
        }

        frameNumber++;

        if (frameCount == fnumber)
                generated = true;
}

// loads frames from disk
void load()
{
        for (int i = 0; i < fnumber; i++) {

                img[i] = loadImage(filename+i+".png");

        }

        loaded = true;
}

// shows frames on screen
void show()
{
        if (currentFrame == fnumber - 1)
                currentFrame = 0;

        image(img[currentFrame],0,0);

        currentFrame++;
}

// checks if file exists
boolean fileExists(String path)
{
        File file = new File(path);
        return file.exists();
}
