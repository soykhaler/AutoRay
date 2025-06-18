#include "raylib.h"
typedef struct Ball {
    float s;
    float f;
    float dx;
    float dy;
    float acc;
    float boost;
    bool cj;}Ball;
int main(void){
    const int screenWidth = 1280;
    const int screenHeight = 720;
    float g = -0.5f;
    int gsp = 15;
    Color gridColor = LIGHTGRAY;
    InitWindow(screenWidth, screenHeight, "ball input core");
    Ball ball = {
        .s = 8.0f,
        .f = 0.9f,
        .dx = 0.0f,
        .dy = 0.0f,
        .acc = 1.5f,
        .boost = 24.0f,
        .cj = false};
    Vector2 ballPosition = { (float)screenWidth / 2, (float)screenHeight / 2 };
    float ballRotation = 0.0f;
    SetTargetFPS(60);
    while (!WindowShouldClose()){
        ballPosition.x += ball.dx;
        ballPosition.y += ball.dy;
        ball.dy -= g;
        ball.dx *= ball.f;
        ballRotation += ball.dx;
        if (ballPosition.y >= 670){
            ballPosition.y = 670;
            ball.cj = true;
        }
        if (ballPosition.x <= 50){
            ballPosition.x = 50;
            ball.dx += ball.acc *35;
        }
        if (ballPosition.x >= 1230){
            ballPosition.x = 1230;
            ball.dx -= ball.acc *35;
        }
        if (IsKeyDown(KEY_RIGHT)) ball.dx += ball.acc;
        if (IsKeyDown(KEY_LEFT))  ball.dx -= ball.acc;
        if (IsKeyDown(KEY_UP) && ball.cj == true ){
            ball.dy -= ball.boost;
            ball.cj = false;
        }
        if (IsKeyDown(KEY_DOWN))  ball.dy += ball.acc;
        BeginDrawing();
            ClearBackground(RAYWHITE);
            for (int x = 0; x <= screenWidth; x += gsp)
                DrawLine(x, 0, x, screenHeight, gridColor);
            for (int y = 0; y <= screenHeight; y += gsp)
                DrawLine(0, y, screenWidth, y, gridColor);
            DrawText("core", 10, 10, 20, BLACK);
            DrawText(TextFormat("Ball position: (%.1f, %.1f)", ballPosition.x, ballPosition.y), 30, 30, 20, BLACK);
            DrawCircleV(ballPosition, 50, BLUE);
        EndDrawing();
    }
    CloseWindow();
    return 0;
}
