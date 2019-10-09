**Name:** Conor Wallace

# Idea
I wanted to make something visually interesting for displaying on the AdShel screens, so movement was a primary focus. When considering what to make I thought having to design something for a static screen was far to limiting so I have ignored that format.

When I was younger I used to play a lot of web based falling sand toy box games [Google Search](https://www.google.com/search?q=falling+sand+2&source=lnms&tbm=isch&sa=X&ved=0ahUKEwjWysfJwI3lAhURwlkKHTX_BlkQ_AUIFygA&biw=1920&bih=946)

These were physics based toy boxs where you could play with different elements and see how they interact with each. And I always thought they were visually very interesting!

So I wanted to make something similar (and obviously a lot more basic).

# Configuration
At the top of the `pde` file there is a number of configuration options you can tweak and play with.
I have tried to comment the variables as fully as I can, so hopefully everything is explained!

Have fun with it!

# Limiations

## Performance
Since the simulation is iterating over every visible pixel, this means the bigger you make the window the slower it will take to render each frame. At full resolution the simtulation can be incredibly slow (multiple seconds per frame) depending on the power of the machine you are running on.

## Frame Rate
Since the simulation is tied to the frame rate of the app. The slower you make the frame rate, the slower the simulation will run.

If you make the frame rate low (i.e 25), consider upping the `SIMULATIONS_PER_FRAME` variable to run multiple iterations per frame.

# Video
See the `video` folder.

Video was produced with these settings:
```
FRAME_RATE = 30
START_DELAY = FRAME_RATE * 3
SIMULATIONS_PRE_FRAME = 2

size(442, 750); // 1/8 Size
```
`ffmpeg -r 30 -f image2 -s 442x750 -i frame-%06d.png -vcodec libx264 -crf 18 -pix_fmt yuv420p video1.mp4`

# Screenshots
![Screenshot 1](/screenshots/screenshot-1.png)


![Screenshot 2](/screenshots/screenshot-2.png)


![Screenshot 3](/screenshots/screenshot-3.png)


![Screenshot 4](/screenshots/screenshot-4.png)


![Screenshot 5](/screenshots/screenshot-5.png)


