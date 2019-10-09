sleep(4000);
for (int y = CANVAS_HEIGHT - 1; y >= 0; y--) {
    for (int x = CANVAS_WIDTH - 1; x >= 0; x--) {
        if (canMoveDown(x, y, canvas)) {
            canvas.pixels[y - 1][x] = canvas.pixels[y][x];
            canvas.pixels[y][x] = 0;
        }
        else if (canMoveLeft(x, y, canvas)) {
            canvas.pixels[y][x + 1] = canvas.pixels[y][x];
            canvas.pixels[y][x] = 0;
        }
        else if (canMoveRight(x, y, canvas)) {
            canvas.pixels[y][x - 1] = canvas.pixels[y][x];
            canvas.pixels[y][x] = 0;
        }